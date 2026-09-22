#!/bin/sh
set -eu

: "${GF:?Set GF to your GF executable}"
test -x "$GF"
RGL_DIR=${RGL_DIR:-../../gf-rgl}
BUILD_DIR=${BUILD_DIR:-build}
test -f "$RGL_DIR/src/api/Syntax.gf" || {
  echo "Set RGL_DIR to your gf-rgl checkout" >&2
  exit 1
}
mkdir -p "$BUILD_DIR"

opt=
mode=compile
for arg do
  case "$arg" in
    -opt) opt=-optimize-pgf ;;
    -make) mode=make ;;
    -link) mode=link ;;
  esac
done
for lang do
  case "$lang" in -*) continue ;; esac
  case "$lang" in ???) module=Phrasebook$lang ;; *) module=$lang ;; esac
  if test "$mode" != link; then
    mkdir -p "$BUILD_DIR/$module"
    # Use one source profile for local fixes and language-specific Extra modules.
    # Scandinavian grammars also depend on the shared functor sources.
    case "$module" in
      PhrasebookCze) source_dirs="$RGL_DIR/src/czech" ;;
      PhrasebookDan) source_dirs="$RGL_DIR/src/danish:$RGL_DIR/src/scandinavian" ;;
      PhrasebookLav) source_dirs="$RGL_DIR/src/latvian" ;;
      PhrasebookNor) source_dirs="$RGL_DIR/src/norwegian:$RGL_DIR/src/scandinavian" ;;
      PhrasebookPol) source_dirs="$RGL_DIR/src/polish" ;;
      PhrasebookRon) source_dirs="$RGL_DIR/src/romanian" ;;
      PhrasebookRus)
        # Russian's tense patterns require the complete RGL tense parameters.
        source_dirs="$RGL_DIR/src/russian"
        ;;
      PhrasebookTha) source_dirs="$RGL_DIR/src/thai" ;;
      *) source_dirs= ;;
    esac
    if test -n "$source_dirs"; then
      path=".:$RGL_DIR/src/api:$source_dirs:$RGL_DIR/src/common:$RGL_DIR/src/abstract:$RGL_DIR/src/prelude"
    else
      path=".:$RGL_DIR/dist/present:$RGL_DIR/dist/alltenses:$RGL_DIR/dist/prelude"
    fi
    # As in the RGL installer, skip PMCFG generation for library modules.
    # Linking generates the parser for the phrasebook's own abstract syntax.
    "$GF" -make -no-pmcfg $opt -path="$path" -name="$module" \
      -gfo-dir="$BUILD_DIR/$module" -output-dir="$BUILD_DIR" "$module.gf"
  fi
done
if test "$mode" != compile; then
  # Rebuild the positional arguments as PGF paths without shell evaluation.
  for lang do
    shift
    case "$lang" in -*) continue ;; esac
    case "$lang" in ???) module=Phrasebook$lang ;; *) module=$lang ;; esac
    set -- "$@" "$BUILD_DIR/$module.pgf"
  done
  "$GF" -make -name=Phrasebook -output-dir="$BUILD_DIR" "$@"
fi
