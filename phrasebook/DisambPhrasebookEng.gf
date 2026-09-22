--# -path=.:present

concrete DisambPhrasebookEng of Phrasebook = PhrasebookEng - 
   [
    PGreetingMale, PGreetingFemale,
    IMale, IFemale,
    YouFamMale, YouFamFemale, 
    YouPolMale, YouPolFemale, 
    LangNat, -- CitiNat,
    GExcuse, GExcusePol, 
    GSorry, GSorryPol, 
    GPleaseGive, GPleaseGivePol,
    GNiceToMeetYou, -- GNiceToMeetYouPol,
    PYes, PYesToNo, ObjMass,
    MKnow,
    WeMale, WeFemale,
    YouPlurFamMale, YouPlurFamFemale,
    YouPlurPolMale, YouPlurPolFemale,
    TheyMale, TheyFemale,
    PImperativeFamPos, 
    PImperativeFamNeg, 
    PImperativePolPos, 
    PImperativePolNeg,
    PImperativePlurPos,
    PImperativePlurNeg 
   ] 
  ** open SyntaxEng, ParadigmsEng, IrregEng, Prelude,
    (Base = PhrasebookEng) in {
lin
  PGreetingMale g   = mkText (lin Text g) (lin Text (ss "(by male)")) ;
  PGreetingFemale g = mkText (lin Text g) (lin Text (ss "(by female)")) ;
  IMale = mkP Base.IMale "(male)" ;
  IFemale = mkP Base.IFemale "(female)" ;
  WeMale = mkP Base.WeMale "(male)" ;
  WeFemale = mkP Base.WeFemale "(female)" ;
  YouFamMale = mkP Base.YouFamMale "(singular,familiar,male)" ;
  YouFamFemale = mkP Base.YouFamFemale "(singular,familiar,female)" ;
  YouPolMale = mkP Base.YouPolMale "(singular,polite,male)" ;
  YouPolFemale = mkP Base.YouPolFemale "(singular,polite,female)" ;
  YouPlurFamMale = mkP Base.YouPlurFamMale "(plural,familiar,male)" ;
  YouPlurFamFemale = mkP Base.YouPlurFamFemale "(plural,familiar,female)" ;
  YouPlurPolMale = mkP Base.YouPlurPolMale "(plural,polite,male)" ;
  YouPlurPolFemale = mkP Base.YouPlurPolFemale "(plural,polite,female)" ;
  TheyMale = mkP Base.TheyMale "(male)" ;
  TheyFemale = mkP Base.TheyFemale "(female)" ;

  MKnow = mkVV (partV know_V "how") ; ---

  LangNat nat = mkNP nat.lang (ParadigmsEng.mkAdv "(language)") ;
--  CitiNat nat = nat.prop ;

  GExcuse = fam "excuse me" ;
  GExcusePol = pol "excuse me" ;
  GSorry = fam "sorry" ;
  GSorryPol = pol "sorry" ;
  GPleaseGive = fam "please" ;
  GPleaseGivePol = pol "please" ;
  GNiceToMeetYou = fam "nice to meet you" ;
--  GNiceToMeetYouPol = pol "nice to meet you" ;

  PYes = mkPhrase (lin Utt (ss "yes (answer to positive question)")) ;
  PYesToNo = mkPhrase (lin Utt (ss "yes (answer to negative question)")) ;

  ObjMass x = mkNP (mkNP x) (ParadigmsEng.mkAdv "(a portion of)") ;

    PImperativeFamPos  v = annotateText (Base.PImperativeFamPos v) "(singular,familiar)" ;
    PImperativeFamNeg  v = annotateText (Base.PImperativeFamNeg v) "(singular,familiar)" ;
    PImperativePolPos  v = annotateText (Base.PImperativePolPos v) "(singular,polite)" ;
    PImperativePolNeg  v = annotateText (Base.PImperativePolNeg v) "(singular,polite)" ;
    PImperativePlurPos v = annotateText (Base.PImperativePlurPos v) "(plural,familiar)" ;
    PImperativePlurNeg v = annotateText (Base.PImperativePlurNeg v) "(plural,familiar)" ;


oper
  fam : Str -> SS = \s -> postfixSS "(familiar)" (ss s) ;
  pol : Str -> SS = \s -> postfixSS "(polite)" (ss s) ;

  -- Keep the base person's identity and agreement. Feedback must survive
  -- possessive and reflexive uses as well as ordinary NP modification.
  mkP : NPPerson -> Str -> NPPerson = \p,s -> p ** {
     name = mkNP p.name (ParadigmsEng.mkAdv s) ;
     poss = p.poss ** {
       s = \\hasCard,n => p.poss.s ! hasCard ! n ++ s ;
       sp = \\g,hasAdj,n,c => p.poss.sp ! g ! hasAdj ! n ! c ++ s
       } ;
     bound = p.bound ** {s = \\a => p.bound.s ! a ++ s}
    } ;

  -- Resolve imperative binding in the base grammar before adding feedback.
  annotateText : Text -> Str -> Text = \t,s -> mkText t (lin Text (ss s)) ;
}
