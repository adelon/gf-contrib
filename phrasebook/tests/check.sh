#!/bin/sh
set -eu
: "${GF:?Set GF to your GF executable}"
pgf=${1:-build/Phrasebook.pgf}
work=$(mktemp -d "${TMPDIR:-/tmp}/phrasebook-tests.XXXXXX")
trap 'rm -rf "$work"' EXIT HUP INT TERM
tab=$(printf '\t')
count=0
log=${pgf%.pgf}.roundtrips.log
: > "$log"

# A time limit also bounds malformed or unexpectedly expensive parser inputs.
run_gf() {
  perl -e 'alarm 15; exec @ARGV or die $!' "$GF" -run "$pgf"
}

while IFS="$tab" read -r category tree english czech; do
  for lang in Eng Cze; do
    case "$lang" in Eng) expected=$english ;; Cze) expected=$czech ;; esac
    printf 'l -lang=Phrasebook%s %s\nq\n' "$lang" "$tree" | run_gf > "$work/linearization"
    actual=$(sed '/^$/d' "$work/linearization")
    if test "$actual" != "$expected"; then
      printf '%s\nExpected: %s\nActual: %s\n' "$tree ($lang)" "$expected" "$actual" >&2
      exit 1
    fi
    # One extra candidate detects truncation; no first-parse assumption.
    printf 'p -lang=Phrasebook%s -cat=%s "%s" | pt -number=101\nq\n' \
      "$lang" "$category" "$expected" | run_gf | sed '/^$/d' > "$work/parses"
    candidates=$(wc -l < "$work/parses" | tr -d ' ')
    printf '%s: %s (%s candidates)\n' "$lang" "$expected" "$candidates" >> "$log"
    cat "$work/parses" >> "$log"
    if test "$candidates" -ge 101; then
      echo "Parse budget exceeded; candidate list is truncated: $expected" >&2
      exit 1
    fi
    if ! grep -Fxq "$tree" "$work/parses"; then
      printf 'Intended tree missing for %s: %s\n' "$lang" "$expected" >&2
      cat "$work/parses" >&2
      exit 1
    fi
    count=$((count + 1))
  done
done < tests/czech.tsv
printf 'Passed %s generation and parse round trips. Candidates: %s\n' "$count" "$log"
