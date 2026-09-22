#!/bin/sh
set -eu
: "${GF:?Set GF to your GF executable}"
pgf=${1:-build/Phrasebook.pgf}
other=${2:-Cze}
case "$other" in
  Cze)
    cases=tests/czech.tsv
    missing='ObjPlur ThesPlur ThesePlur ThosePlur'
    ;;
  Fre)
    cases=tests/french.tsv
    # Existing French vocabulary and upstream numeral gaps, outside these tests.
    missing='Chinese Hindi India Indian ObjPlur Rupee ThesPlur ThesePlur ThosePlur Yuan pot21 pot31 pot3decimal pot4 pot41 pot4decimal pot4plus pot5 pot51 pot5decimal pot5plus'
    ;;
  *) echo "Unsupported test language: $other" >&2; exit 1 ;;
esac
work=$(mktemp -d "${TMPDIR:-/tmp}/phrasebook-tests.XXXXXX")
trap 'rm -rf "$work"' EXIT HUP INT TERM
tab=$(printf '\t')
count=0
log=${pgf%.pgf}.roundtrips.log

# Import the PGF once instead of loading the morphology for every assertion.
# Each parse has a 100-candidate budget, with one lookahead for truncation.
while IFS="$tab" read -r category tree english translation forbidden; do
  for lang in Eng "$other"; do
    count=$((count + 1))
    case "$lang" in Eng) expected=$english ;; *) expected=$translation ;; esac
    printf '%s\t%s\t%s\t%s\t%s\n' "$count" "$lang" "$tree" "$expected" "$forbidden" >> "$work/expected"
    printf 'ps "GEN %s"\nl -lang=Phrasebook%s %s\n' "$count" "$lang" "$tree" >> "$work/commands"
    printf 'ps "PARSE %s"\np -lang=Phrasebook%s -cat=%s "%s" | pt -number=101\n' \
      "$count" "$lang" "$category" "$expected" >> "$work/commands"
  done
done < "$cases"
printf 'ps "MISSING"\npg -missing\nps "DONE"\nq\n' >> "$work/commands"
# Bound the whole batch as well as the number of parses. A timeout is a failure.
perl -e 'alarm 120; exec @ARGV or die $!' "$GF" -run "$pgf" < "$work/commands" > "$work/actual"

awk -F '\t' -v log_path="$log" -v total="$count" -v other="$other" -v other_missing="$missing" '
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
  mode == "MISSING" && $0 == "PhrasebookEng : ObjPlur ThesPlur ThesePlur ThosePlur" {missing++; next}
  mode == "MISSING" && $0 == "Phrasebook" other " : " other_missing {missing++; next}
  /^DONE$/ {finish(); mode=""; done=1; next}
  /^$/ {next}
  mode == "GEN" {
    generated++;
    if ($0 != expected[id]) fail(tree[id] " (" lang[id] ")\nExpected: " expected[id] "\nActual: " $0);
    next
  }
  mode == "PARSE" {
    candidates++;
    if ($0 ~ /\?[0-9]+/) fail("Unresolved argument in parse for " lang[id] ": " expected[id] "\n" $0);
    if ($0 == tree[id]) found=1;
    if (forbidden[id] != "" && $0 == forbidden[id])
      fail("Incorrect meaning recovered for " lang[id] ": " expected[id] "\n" $0);
    print > log_path; next
  }
  {fail("Unexpected GF output: " $0)}
  END {
    if (!done || checked != total || missing != 2) fail("Incomplete test batch");
    if (failed) exit 1;
    print "Passed " total " generation and parse round trips. Candidates: " log_path;
  }
' "$work/expected" "$work/actual"
