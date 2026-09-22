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
output directory, and the existing `GF_LIB_PATH` is left intact. Both Makefiles
use `build.sh` and `$GF`, including the legacy app/demo targets. Czech is included
in their compile and link lists and uses the same RGL source paths as `make Cze`.

The legacy targets retain their output layout: PGFs are written in this directory,
with intermediate GFOs under each module's name. `make gfos` collects those GFOs
for the app. To build only Czech through the parallel Makefile, use
`make -f Makefile2 PhrasebookCze.pgf RGL_DIR="$RGL_DIR"`.
The historical `Compile.hs` script is no longer used by either Makefile.

The builds retain both `Phrase` and `Word`. They do not enable `-optimize-pgf`:
GF's global PGF optimization keeps only components reachable from `startcat`
(`Phrase`), which removes the standalone `Word` linearizations. This option is
separate from using an optimized GF compiler executable.
When migrating from previously optimized legacy PGFs, run `make clean` before
rebuilding: GF's timestamp check does not detect changed optimization options.

The complete legacy app/demo language set still needs separate compatibility
work against current RGL APIs. For example, with RGL `820382715`,
`WordsFre.TheCheapest` fails because its old adjective record expects a string
where `MorphoFre.mkAdj` now supplies a table. This does not affect the bilingual
English/Czech build or the Czech target in `Makefile2`.

The Czech source requires the companion RGL revisions providing `ExtraCze`,
the standard `ExtendCze` reflexive noun-phrase constructions,
subject omission, quantified agreement, clitic domains and `v_Prep`.
Run `sh tests/czech/check.sh` in that checkout to check its source constructions
and its standard installed language and API modules. `SyntaxCzeExtra` has been replaced by the
conventional `ExtraCzeAbs` / `ExtraCze` extension.

Compilation also depends on the size of concrete parameter records: GF
enumerates combinations even when fields are constant or correlated in the
application. Czech uses compact application records and reconstructs full RGL
values when a construction needs them:

- Objects and places contain nominal descriptions, so their pronoun and clitic
  flags are constant. Their clause and modifier agreement remain separate,
  including for quantified objects.
- Persons are bare pronouns, proper names or unquantified kinship descriptions.
  Their modifier agreement follows their grammatical agreement; pronoun status
  determines clitic eligibility and neutral subject omission. Only pronouns
  establish a subject referent, while descriptions retain their possessor's
  referent for nested binding. These choices are derived instead of stored twice.
- Country and language names are composed as citation utterances. Location and
  spoken-language expressions are built separately through the RGL. No later
  phrasebook constructor needs to inflect the citation utterance.

All case and constituent-placement forms come from the RGL. The conversion
helpers in `SentencesCze.gf` rely on the domain restrictions above; extending
`Person` with quantified or focused noun phrases would require revisiting them.
The general RGL NP and RNP representations are unchanged.

For a compilation regression check, use a fresh `BUILD_DIR` and a memory cap.
On machines with `saferun`, for example:

```sh
saferun 8 -- timeout --kill-after=5s 180s \
  make test-czech RGL_DIR="$RGL_DIR" BUILD_DIR="$(mktemp -d)"
```

With an optimized GF 3.12.0 and RGL revision `820382715`, a fresh English/Czech
build and all 548 generation/parse round trips took 23.7 seconds and peaked at
2.85 GiB resident memory. Before compaction, compilation exceeded a 16 GB cap.
These measurements depend on the compiler, RGL revision and machine.

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
  *zastavovat se*, while episodic modal infinitives and positive commands use
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

Statements describe ongoing or habitual activities. Positive commands and
`MWant`, `MMust`, and `MCan` request or discuss an event; `MKnow` denotes a
skill. Where an activity has an endpoint, the event realization is perfective:
*kupte pizzu* / *chci koupit pizzu*, versus *nekupujte pizzu* /
*umím kupovat pizzu*. Statements and prohibitions remain imperfective.

`MMust` denotes necessity, and `SPropNot` negates the whole proposition.
English uses *have to* and Czech uses *muset*: *he has to drink* / *musí pít*,
but *he doesn't have to drink* / *nemusí pít*. This remains true in questions
and embedded clauses. English *mustn't* would express prohibition instead;
prohibition would need a separate meaning if added to the modal vocabulary.
The other language concretes have not been checked against this scope contract.

Object constructors retain whether a quantity is bounded. Identified or counted
food and drink select *sníst* / *vypít* in event contexts, while unspecified
amounts retain *jíst* / *pít*: *vypijte tuto vodu*, but *pijte vodu*. Buying is
a purchase event even with an unspecified amount. This is a controlled reading
of the existing abstract constructors, not a general rule that all Czech
imperatives or infinitives must be perfective. Broader distinctions between
habitual and episodic modal meanings would need an explicit abstract contrast.

Pronoun constructors denote discourse participants. English and Czech use the
same identity rules from `PhrasebookReferents`, separately from RGL agreement
and sex. Gender/address variants of the speaker, addressee and speaker group
share identity; `He`, `She`, `TheyMale` and `TheyFemale` denote their respective
third-person participants. `ALove He He` means *he loves himself* / *miluje sebe*.
It does not denote loving another man. `ALove He (Wife He)` uses *svou manželku*,
whereas `ALove He (Wife IMale)` uses *mou manželku*. The same binding applies
inside verb phrases, including modal and imperative requests to wait for
someone. The RGL supplies case and reflexive forms; the phrasebook decides
whether the object or possessor denotes the subject. Both concretes use the
standard `Extend` RNP interface for oneself. Czech also uses `ReflPossPron` for
one's relative and `AdvRNP` to embed that relative within another description;
English retains its ordinary possessives and genitives. Thus
`ALove He (Wife (Son He))` means *he loves his son's wife* /
*miluje manželku svého syna*. Czech retains the innermost participant's binding
at arbitrary kinship depth. These identity rules are implemented and tested in
English and Czech; the legacy language concretes have not been migrated.

Each person supplies its own reflexive forms. Czech pronouns also supply ordinary
and reflexive possessive quantifiers; kinship constructions consume the owner's
appropriate quantifier and preserve nested bound RNPs. The owner therefore
contributes actual forms such as *svou* or *svého* to the parsing derivation,
without an artificial empty-string dependency. Czech retains the case and
constituent-placement forms of RGL-built NPs and RNPs, reconstructing their
derived metadata when they are used; the RGL still supplies all morphology.

Parsing need not recover a unique tree: *miluje sebe* can describe either
`ALove He He` or `ALove She She`. Round-trip tests require the intended tree to
be among the candidates, allowing distinctions that the language leaves
unexpressed while rejecting known incorrect bindings.

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
a forbidden reading in either language; the possession contrasts check meaning as well as
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
