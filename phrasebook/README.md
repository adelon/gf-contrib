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
