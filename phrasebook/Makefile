RGL_DIR ?= ../../gf-rgl
BUILD_DIR ?= build
export GF RGL_DIR BUILD_DIR
# Legacy app/demo targets keep their PGFs here, but share compiler/RGL selection.
compile = BUILD_DIR=. sh ./build.sh

.PHONY: Eng Cze EngCze test-czech test-disamb-english test-french test-russian test-thai forApp all demo compdemo linkdemo linkdemothb fin missing clean
Eng:
	sh ./build.sh Eng

Cze:
	sh ./build.sh Cze

EngCze:
	sh ./build.sh -make Eng Cze

test-czech: EngCze
	sh tests/check.sh "$(BUILD_DIR)/Phrasebook.pgf"

test-disamb-english:
	BUILD_DIR="$(BUILD_DIR)/disamb-english" sh ./build.sh -make Eng DisambPhrasebookEng
	sh tests/check.sh "$(BUILD_DIR)/disamb-english/Phrasebook.pgf" DisambEng

test-french:
	BUILD_DIR="$(BUILD_DIR)/french" sh ./build.sh -make Eng Fre
	sh tests/check.sh "$(BUILD_DIR)/french/Phrasebook.pgf" Fre

test-russian:
	BUILD_DIR="$(BUILD_DIR)/russian" sh ./build.sh -make Eng Rus
	sh tests/check.sh "$(BUILD_DIR)/russian/Phrasebook.pgf" Rus

test-thai:
	BUILD_DIR="$(BUILD_DIR)/thai" sh ./build.sh -make Eng Tha
	sh tests/check.sh "$(BUILD_DIR)/thai/Phrasebook.pgf" Tha

forApp:
	$(compile) Bul Cat Chi Cze Dut Eng Est Fin Fre Ger Hin Ita Jpn Rus Spa Swe Tha Urd
	$(MAKE) gfos

.PHONY: gfos

Chi:
	$(compile) Chi

all: demo
	$(MAKE) missing gfos

gfos:
	mkdir -p gfos
	@set -e; for file in *.gfo Phrasebook*/*.gfo DisambPhrasebook*/*.gfo; do \
	  if test -f "$$file"; then cp -p "$$file" gfos/; fi; \
	done

thaidroid: #thaiscript
	cp -p Phrasebook.pgf FullPhrasebook.pgf
	$(compile) Eng Swe Tha Thb DisambPhrasebookEng
	$(compile) -link Eng Fin Swe Tha Thb DisambPhrasebookEng
	mv Phrasebook.pgf Thaidroid.pgf
	mv FullPhrasebook.pgf Phrasebook.pgf

thaiscript:
	runghc ../../lib/src/thai/ThaiScript.hs

demo: compdemo fin
	$(MAKE) linkdemo

compdemo:
	$(compile) Bul Cat Chi Cze Dan Dut Eng Fre Ger Hin Ita Jpn Lav Nor Pes Pol Ron Rus Spa Swe Tha Urd DisambPhrasebookEng

linkdemo:
	$(compile) -link Eng Bul Cat Chi Cze Dan Dut Fin Fre Ger Hin Ita Jpn Lav Nor Pes Pol Ron Rus Spa Swe Tha Urd DisambPhrasebookEng

linkdemothb:
	$(compile) -link Eng Bul Cat Chi Cze Dan Dut Fin Fre Ger Ita Jpn Nor Pol Ron Rus Spa Swe Tha Thb Urd DisambPhrasebookEng

#separate, because slow...
fin:
	$(compile) Fin

missing:
	echo "pg -missing | wf -file=missing.txt" | "$(GF)" -run Phrasebook.pgf

doc:
	cat Sentences.gf Words.gf >Ontology.gf
	gfdoc Ontology.gf
	rm -f Ontology.gf
	cat SentencesI.gf WordsEng.gf >Implementation.gf
	gfdoc Implementation.gf
	txt2tags -thtml --toc doc-phrasebook.txt
	txt2tags -thtml help-phrasebook.txt
	rm -f Ontology.gf Implementation.gf

clean:
	rm -f *.gfo *.pgf Phrasebook*/*.gfo DisambPhrasebook*/*.gfo

upload:: Phrasebook.pgf
	rsync -avb Phrasebook.pgf www.grammaticalframework.org:/usr/local/www/GF-demos/www/grammars
