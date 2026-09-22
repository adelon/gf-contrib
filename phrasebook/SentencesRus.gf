concrete SentencesRus of Sentences = NumeralRus ** SentencesI - [
  NameNN, SHave, SHaveNo, SHaveNoMass, QDoHave, AHaveCurr, ABePlace,
    NPPerson, mkPerson, relativePerson, PersonName,
    IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, YouPolFemale,
    He, She, WeMale, WeFemale, YouPlurFamMale, YouPlurFamFemale,
    YouPlurPolMale, YouPlurPolFemale, TheyMale, TheyFemale
 ]  with 
  (Syntax = SyntaxRus),
  (Symbolic = SymbolicRus),
  (Lexicon = LexiconRus), (Grammar = GrammarRus) ** open Prelude, SyntaxRus, ExtraRus,
    (P = ParadigmsRus), (E = ExtendRus) in {
    lin
      SHave p obj = mkS (mkCl (mkVP have_V3 obj p.name)) ;
      SHaveNo p obj = mkS (mkCl (mkVP have_not_V3 (mkNP obj) p.name)) ;
      SHaveNoMass p obj = mkS (mkCl (mkVP have_not_V3 (mkNP obj) p.name)) ;
      QDoHave p obj = mkQS (mkQCl (mkCl (mkVP have_V3 obj p.name))) ;

      AHaveCurr p curr = mkCl (mkVP have_V3 (mkNP aPl_Det curr) p.name) ;
      ABePlace p place = mkAdvCl p.name place.at ;

    lin
      NameNN = mkNP (P.mkN "NN") ;
      IMale = mkPerson Male i_Pron ;
      IFemale = mkPerson Female E.iFem_Pron ;
      YouFamMale = mkPerson Male youSg_Pron ;
      YouFamFemale = mkPerson Female E.youFem_Pron ;
      YouPolMale = mkPerson Male youPol_Pron ;
      YouPolFemale = mkPerson Female youPol_Pron ;
      He = mkPerson Male he_Pron ;
      She = mkPerson Female she_Pron ;
      WeMale = mkPerson Male we_Pron ;
      WeFemale = mkPerson Female we_Pron ;
      YouPlurFamMale, YouPlurPolMale = mkPerson Male youPl_Pron ;
      YouPlurFamFemale, YouPlurPolFemale = mkPerson Female youPl_Pron ;
      TheyMale = mkPerson Male they_Pron ;
      TheyFemale = mkPerson Female they_Pron ;
      PersonName n = {
        name = n ; isPron = False ; poss = mkQuant he_Pron ; sex = Unknown
        } ;

    -- Sex selects marital vocabulary; it does not change RGL agreement.
    param Sex = Male | Female | Unknown ;
    oper
      -- Ordinary location/status predicates omit the present copula.
      mkAdvCl : NP -> Adv -> Cl = \np,adv ->
        mkCl np (mkVP (mkVP be_ell_V) adv) ;

      NPPerson : Type = {name : NP ; isPron : Bool ; poss : Quant ; sex : Sex} ;

      mkPerson : Sex -> Pron -> NPPerson = \s,p -> {
        name = mkNP p ; isPron = True ; poss = mkQuant p ; sex = s
        } ;

      relativePerson : GNumber -> CN -> (Num -> NP -> CN -> NP) -> NPPerson -> NPPerson =
        \n,x,f,p -> let num = if_then_else Num n plNum sgNum in {
          name = case p.isPron of {
            True => mkNP p.poss num x ;
            False => f num p.name x
            } ;
          isPron = False ; poss = mkQuant he_Pron ; sex = Unknown
          } ;

}
