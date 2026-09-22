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
    # Compile these languages from source so local RGL fixes are included.
    case "$lang" in
      Cze|PhrasebookCze)
        path=".:$RGL_DIR/src/api:$RGL_DIR/src/czech:$RGL_DIR/src/common:$RGL_DIR/src/abstract:$RGL_DIR/src/prelude"
        ;;
      Rus|PhrasebookRus)
        # Russian's tense patterns require the complete RGL tense parameters.
        path=".:$RGL_DIR/src/api:$RGL_DIR/src/russian:$RGL_DIR/src/common:$RGL_DIR/src/abstract:$RGL_DIR/src/prelude"
        ;;
      Tha|PhrasebookTha)
        path=".:$RGL_DIR/src/api:$RGL_DIR/src/thai:$RGL_DIR/src/common:$RGL_DIR/src/abstract:$RGL_DIR/src/prelude"
        ;;
      *) path=".:$RGL_DIR/dist/present:$RGL_DIR/dist/alltenses:$RGL_DIR/dist/prelude" ;;
    esac
    "$GF" -make $opt -path="$path" -name="$module" \
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
