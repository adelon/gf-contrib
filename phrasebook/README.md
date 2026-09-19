# Building the phrasebook

Set `GF` to the GF executable and `RGL_DIR` to a local gf-rgl checkout with
compiled libraries in `dist`. From this directory:

```sh
make Eng RGL_DIR="$HOME/Code/gf-rgl"
make Cze RGL_DIR="$HOME/Code/gf-rgl"
make EngCze RGL_DIR="$HOME/Code/gf-rgl"
make test-czech RGL_DIR="$HOME/Code/gf-rgl"
```

The bilingual grammar is `build/Phrasebook.pgf`. Czech is compiled from RGL
sources, so local Czech fixes are included without reinstalling the RGL.
English uses the installed present-tense profile. `BUILD_DIR` selects a fresh
output directory, and the existing `GF_LIB_PATH` is left intact. The legacy
multilingual targets still use `Compile.hs`; these targets use `build.sh` and
`$GF`.

The Czech source requires the companion RGL revisions providing `ExtraCze`,
subject omission, quantified agreement, clitic domains and `v_Prep`.
Run `sh tests/czech/check.sh` in that checkout to check its source constructions
and its standard installed API. `SyntaxCzeExtra` has been replaced by the
conventional `ExtraCzeAbs` / `ExtraCze` extension.

## Semantic application grammar

The shared abstract API is unchanged. Its trees describe phrasebook meanings;
the Czech concrete chooses vocabulary and constructions for those meanings.
For example, `English` supplies several lexical realizations:

| Context | Czech realization |
| --- | --- |
| `ACitizen IMale (CitiNat English)` | jsem Angličan |
| `ACitizen YouPolFemale (CitiNat English)` | jste Angličanka |
| `ASpeak IFemale (LangNat English)` | mluvím anglicky |
| `PLanguage (LangNat English)` | angličtina |
| `CitRestaurant (CitiNat English)` | anglická restaurace |
| `ALive IMale (CountryNat English)` | žiji v Anglii |

The RGL supplies inflection, agreement, adjective degrees, reflexive clitic
placement, case-governed complements and dative copular constructions. The
phrasebook supplies nationality records, vocabulary, country prepositions,
and the interpretation of each domain action:

- `ALike` means general liking, realized with *mít rád*.
- `AHasAge` uses *je mi pět let* / *jsou mi dva roky*.
- `AHasName` uses *jmenovat se*.
- `AMarried` selects *ženatý* or *vdaná* from the person’s sex, independently
  of grammatical gender.
- `VStop` means stopping oneself: statements and prohibitions use
  *zastavovat se*, while modal infinitives and positive commands use
  *zastavit se*. These are separate lexical VPs in the application;
  the RGL does not mix the conjugations of two aspectual verbs.
- Transport entries select motion verbs (*jet*, *letět*, *plout*) and
  idiomatic manner expressions such as *na kole* and *taxíkem*.
- Productive farewells combine the fixed idiom *na shledanou* with the
  supplied place and date.

Grammatical gender alone does not identify a person's sex. In particular,
*děti* has feminine plural agreement. For `Children` and an opaque
`PersonName`, nationality uses *mít ... národnost* and marital status uses
*být v manželství*, avoiding an unsupported choice of male or female people.
The `NN` person-name placeholder has default masculine grammatical agreement.
Standalone citizenship vocabulary uses the masculine noun as its dictionary
form. `Citizenship` here follows the existing nationality sense, not a claim
about legal passport status.

Pronoun constructors denote discourse participants. Czech tracks their identity
separately from agreement and sex: `ALove He (Wife He)` uses *svou manželku*,
whereas `ALove He (Wife IMale)` uses *mou manželku*. The same binding applies
inside verb phrases, including modal and imperative requests to wait for
someone. The RGL supplies case and reflexive forms; the phrasebook decides
whether the object or possessor denotes the subject.

The `NN` placeholder and kinship descriptions do not introduce discourse
identifiers. Repeating an arbitrary description does not establish identity.
Content requiring distinct named participants or explicit coreference between
descriptions needs discourse identifiers in the abstract grammar, rather than
comparison of Czech strings or agreement features.

## Coverage and verification

Czech implements all active, reachable phrasebook content: food and qualities,
places and superlatives, currencies, nationalities, countries, languages,
actions, family, dates, transport, greetings and imperatives. The historical
expansion commented out in `Words.gf` is outside the active abstract API.

`pg -missing` reports only `ObjPlur`, `ThesPlur`, `ThesePlur` and `ThosePlur`
in both languages. Their argument category `PlurKind` has no active vocabulary;
the concrete rules are implemented. The test runner checks this coverage
boundary so a new missing Czech entry fails verification.

The treebank tests default generation and parsing in both languages, including
all nationality entries, count agreement, polite feminine address, irregular
currency plurals, case after prepositions, reflexives under modals, and new
combinations of the same constituents. Parsing must contain the intended tree;
the runner does not choose the first parse. An optional fifth TSV column names
a forbidden Czech reading; the possession contrasts check meaning as well as
round-trip membership. It retains at most 100 candidates,
with one extra to detect truncation, and bounds the whole batch to 120 seconds.
All candidates are recorded in `build/Phrasebook.roundtrips.log`. Standard shell
utilities, awk and Perl are required.

Use explicit languages and categories in the GF shell:

```gf
i build/Phrasebook.pgf
l -lang=PhrasebookCze PSentence (SProp (PropAction (ACitizen YouPolFemale (CitiNat English))))
p -lang=PhrasebookCze -cat=Phrase "jste Angličanka ."
```

The start category is `Phrase`; standalone vocabulary uses `Word`. Tests use
GF token strings, with punctuation separated by spaces and `&+` binding markers
in hyphenated English numerals and decimals. For display, pipe linearizations
through `ps -bind`. Neutral Czech clauses omit personal subject pronouns.
Parsing recovers their person from agreement and retains alternatives for
unexpressed gender and formal or plural address.

The tests establish these generation and parsing examples, not exhaustive
linguistic correctness. Native-speaker review is still appropriate before
using the material for teaching. Linguistic references include the RGL's cited
*Czech: An Essential Grammar*, the Ministry of Education's
[Czech A2 description](https://www.msmt.cz/uploads/soubory/mezinarodni_vztahy/cestinaA2.pdf),
the [Oxford learner lexicon](https://czech.mml.ox.ac.uk/static/lexicon/Czech%20Lexicon%20for%20Learners%20-%20JDN.pdf),
and the [Czech Language Institute handbook](https://prirucka.ujc.cas.cz/).
