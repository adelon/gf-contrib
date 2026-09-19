concrete SentencesCze of Sentences = NumeralCze ** SentencesI - [
    IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, YouPolFemale,
    WeMale, WeFemale, YouPlurFamMale, YouPlurFamFemale,
    YouPlurPolMale, YouPlurPolFemale, TheyMale, TheyFemale, VStop
  ] with
    (Syntax = SyntaxCze),
    (Symbolic = SymbolicCze),
    (Lexicon = LexiconCze)
  ** open ParadigmsCze, SyntaxCze in {
  lin
    IMale = mkPerson i_Pron ;
    IFemale = mkPerson (genderPron feminine i_Pron) ;
    YouFamMale = mkPerson youSg_Pron ;
    YouFamFemale = mkPerson (genderPron feminine youSg_Pron) ;
    YouPolMale = mkPerson youPol_Pron ;
    YouPolFemale = mkPerson (genderPron feminine youPol_Pron) ;
    WeMale = mkPerson we_Pron ;
    WeFemale = mkPerson (genderPron feminine we_Pron) ;
    YouPlurFamMale, YouPlurPolMale = mkPerson youPl_Pron ;
    YouPlurFamFemale, YouPlurPolFemale = mkPerson (genderPron feminine youPl_Pron) ;
    TheyMale = mkPerson they_Pron ;
    TheyFemale = mkPerson (genderPron feminine they_Pron) ;
}
