#!/bin/sh
set -eu
: "${GF:?Set GF to your GF executable}"
pgf=${1:-build/Phrasebook.pgf}
work=$(mktemp -d "${TMPDIR:-/tmp}/phrasebook-tests.XXXXXX")
trap 'rm -rf "$work"' EXIT HUP INT TERM
tab=$(printf '\t')
count=0
log=${pgf%.pgf}.roundtrips.log

# Import the PGF once: loading the Czech morphology for every assertion is slow.
# Each parse has a 100-candidate budget, with one lookahead for truncation.
while IFS="$tab" read -r category tree english czech forbidden; do
  for lang in Eng Cze; do
    count=$((count + 1))
    case "$lang" in Eng) expected=$english ;; Cze) expected=$czech ;; esac
    printf '%s\t%s\t%s\t%s\t%s\n' "$count" "$lang" "$tree" "$expected" "$forbidden" >> "$work/expected"
    printf 'ps "GEN %s"\nl -lang=Phrasebook%s %s\n' "$count" "$lang" "$tree" >> "$work/commands"
    printf 'ps "PARSE %s"\np -lang=Phrasebook%s -cat=%s "%s" | pt -number=101\n' \
      "$count" "$lang" "$category" "$expected" >> "$work/commands"
  done
done < tests/czech.tsv
printf 'ps "MISSING"\npg -missing\nps "DONE"\nq\n' >> "$work/commands"
# Bound the whole batch as well as the number of parses. A timeout is a failure.
perl -e 'alarm 120; exec @ARGV or die $!' "$GF" -run "$pgf" < "$work/commands" > "$work/actual"

awk -F '\t' -v log_path="$log" -v total="$count" '
  NR == FNR {lang[$1]=$2; tree[$1]=$3; expected[$1]=$4; forbidden[$1]=$5; next}
  function fail(message) {print message > "/dev/stderr"; failed=1}
  function finish() {
    if (mode == "GEN" && generated != 1) fail("Expected one default linearization for " tree[id]);
    if (mode == "PARSE") {
      if (candidates >= 101) fail("Parse budget exceeded; candidates truncated: " expected[id]);
      if (!found) fail("Intended tree missing for " lang[id] ": " expected[id] "\n" tree[id]);
      checked++;
    }
  }
  /^GEN [0-9]+$/ {
    finish(); split($0, marker, " "); id=marker[2]; mode="GEN"; generated=0; next
  }
  /^PARSE [0-9]+$/ {
    finish(); split($0, marker, " "); id=marker[2]; mode="PARSE"; candidates=0; found=0;
    print lang[id] ": " expected[id] > log_path; next
  }
  /^MISSING$/ {finish(); mode="MISSING"; next}
  mode == "MISSING" && /^Phrasebook(Eng|Cze) : ObjPlur ThesPlur ThesePlur ThosePlur$/ {missing++; next}
  /^DONE$/ {finish(); mode=""; done=1; next}
  /^$/ {next}
  mode == "GEN" {
    generated++;
    if ($0 != expected[id]) fail(tree[id] " (" lang[id] ")\nExpected: " expected[id] "\nActual: " $0);
    next
  }
  mode == "PARSE" {
    candidates++;
    if ($0 == tree[id]) found=1;
    if (lang[id] == "Cze" && forbidden[id] != "" && $0 == forbidden[id])
      fail("Incorrect meaning recovered for " expected[id] "\n" $0);
    print > log_path; next
  }
  {fail("Unexpected GF output: " $0)}
  END {
    if (!done || checked != total || missing != 2) fail("Incomplete test batch");
    if (failed) exit 1;
    print "Passed " total " generation and parse round trips. Candidates: " log_path;
  }
' "$work/expected" "$work/actual"
