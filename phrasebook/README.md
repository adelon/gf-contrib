# Building the phrasebook

Set `GF` to the GF executable and `RGL_DIR` to a local gf-rgl checkout with
compiled libraries in `dist`. From this directory:

```sh
make Eng RGL_DIR="$HOME/Code/gf-rgl"
make Cze RGL_DIR="$HOME/Code/gf-rgl"
make EngCze RGL_DIR="$HOME/Code/gf-rgl"
```

The bilingual grammar is `build/Phrasebook.pgf`. Czech is compiled from RGL
sources, so local Czech fixes are included without reinstalling the RGL.
English uses the installed present-tense profile. `BUILD_DIR` can select a
fresh output directory. The existing `GF_LIB_PATH` is left intact.

The abstract API and start category (`Phrase`) are shared by both languages.
Use explicit `-lang=PhrasebookCze` or `-lang=PhrasebookEng` in the GF shell,
and `-cat=Phrase` when parsing complete phrases. Word translations use `Word`.

## Czech milestone and tests

```sh
make test-czech RGL_DIR="$HOME/Code/gf-rgl"
```

This runs 45 trees through both English and Czech: exact generation followed
by parsing and membership of the intended tree in the result set. Parsing is
limited to 100 candidates with an extra candidate to detect truncation, and
15 seconds per invocation. Ambiguities are recorded in
`build/Phrasebook.roundtrips.log`; the test never selects the first parse.
The test runner requires standard shell utilities and Perl for the timeout.

Examples include `já mám hlad`, `vy nejste unavená`, `kde je hotel`,
`já chci jít do hotelu`, `nepijte`, and `já chci pět pizz`. Tests cover
gender and number, formal and informal address, negative verbs, modal verbs,
imperatives, case after prepositions, possession, and embedded questions.
Ordinary GF tokenization is used: punctuation is separated by spaces.

This is an initial working subset, not a complete Czech phrasebook. Food,
places, common actions, family relations, dates, transport, some currencies,
and fixed greetings have Czech implementations. Countries, nationalities and
languages, superlatives, age, children, liking, marriage, residence, speaking,
compositional farewells, several currencies, and `VStop` remain unimplemented.
The RGL also lacks some larger numeral constructors. Ask GF for the complete
current list:

```sh
printf 'pg -missing\nq\n' | "$GF" -run build/PhrasebookCze.pgf
```

Missing entries deliberately have no Czech linearization. No English
placeholder or `WordNetCze` dependency remains. The existing abstract API
is unchanged. Explicit subject pronouns preserve person arguments in parse
trees; recovering the same trees from omitted subjects is future work.
The existing broad multilingual Makefile targets still use the legacy
`Compile.hs`; the new targets use `build.sh` and `$GF`.

The matching gf-rgl changes are required (commit `30b060eb`); their focused
regressions live in `tests/czech/`. The automated suite verifies the stated examples, not every
lexical form or possible recombination. Wider coverage needs further Czech
linguistic review. Useful references are the RGL's cited *Czech: An Essential
Grammar* and the [Czech Language Institute's language handbook](https://prirucka.ujc.cas.cz/).
