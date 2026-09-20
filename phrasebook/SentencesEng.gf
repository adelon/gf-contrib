concrete SentencesEng of Sentences = NumeralEng ** SentencesI - [
  Person, NPPerson, mkPerson, mkRelative, relativePerson, PersonName,
  He, She, IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, YouPolFemale,
  WeMale, WeFemale, YouPlurFamMale, YouPlurFamFemale,
  YouPlurPolMale, YouPlurPolFemale, TheyMale, TheyFemale, AKnowPerson,
  MMust, VerbPhrase, VPlay, VRun, VSit, VSleep, VSwim, VWalk, VStop,
  VDrink, VEat, VRead, VWait, VWrite, V2Buy, V2Drink, V2Eat, V2Wait,
  ADoVerbPhrase, AModVerbPhrase, ADoVerbPhrasePlace, AModVerbPhrasePlace,
  QWhereDoVerbPhrase, QWhereModVerbPhrase,
  PImperativeFamPos, PImperativeFamNeg, PImperativePolPos, PImperativePolNeg,
  PImperativePlurPos, PImperativePlurNeg
  ] with
  (Syntax = SyntaxEng),
  (Symbolic = SymbolicEng),
  (Lexicon = LexiconEng)
  ** open SyntaxEng, Prelude, PhrasebookReferents, (E = ExtendEng), (L = LexiconEng),
    (P = ParadigmsEng), (Irreg = IrregEng) in {
  lincat
    Person = NPPerson ;
    VerbPhrase = EnglishActivity ;
  lin
    IMale, IFemale = person Speaker i_Pron ;
    YouFamMale, YouFamFemale = person Addressee youSg_Pron ;
    YouPolMale, YouPolFemale = person Addressee youPol_Pron ;
    He = person MaleThird he_Pron ;
    She = person FemaleThird she_Pron ;
    WeMale, WeFemale = person SpeakerGroup we_Pron ;
    YouPlurFamMale, YouPlurFamFemale, YouPlurPolMale, YouPlurPolFemale = person AddresseeGroup youPl_Pron ;
    TheyMale = person ThirdMaleGroup they_Pron ;
    TheyFemale = person ThirdFemaleGroup they_Pron ;
    PersonName n = {
      name = n ; ref = Unresolved ; gap = [] ;
      isPron = False ; poss = mkQuant he_Pron
      } ;
    AKnowPerson p q = mkCl p.name (personVP p.ref L.know_V2 q) ;

    -- Ordinary negation of necessity: does not have to, rather than must not.
    MMust = P.mkVV Irreg.have_V ;

    ADoVerbPhrase p v = mkCl p.name (activityVP p.ref v) ;
    AModVerbPhrase m p v = mkCl p.name (mkVP m (activityVP p.ref v)) ;
    ADoVerbPhrasePlace p v x = mkCl p.name (mkVP (activityVP p.ref v) x.at) ;
    AModVerbPhrasePlace m p v x = mkCl p.name (mkVP m (mkVP (activityVP p.ref v) x.at)) ;
    QWhereDoVerbPhrase p v = mkQS (mkQCl where_IAdv (mkCl p.name (activityVP p.ref v))) ;
    QWhereModVerbPhrase m p v = mkQS (mkQCl where_IAdv (mkCl p.name (mkVP m (activityVP p.ref v)))) ;

    PImperativeFamPos v = phrasePlease (mkUtt (mkImp (activityVP Addressee v))) ;
    PImperativeFamNeg v = phrasePlease (mkUtt negativePol (mkImp (activityVP Addressee v))) ;
    PImperativePolPos v = phrasePlease (mkUtt politeImpForm (mkImp (activityVP Addressee v))) ;
    PImperativePolNeg v = phrasePlease (mkUtt politeImpForm negativePol (mkImp (activityVP Addressee v))) ;
    PImperativePlurPos v = phrasePlease (mkUtt pluralImpForm (mkImp (activityVP AddresseeGroup v))) ;
    PImperativePlurNeg v = phrasePlease (mkUtt pluralImpForm negativePol (mkImp (activityVP AddresseeGroup v))) ;

    VPlay = activity (mkVP L.play_V) ;
    VRun = activity (mkVP L.run_V) ;
    VSit = activity (mkVP L.sit_V) ;
    VSleep = activity (mkVP L.sleep_V) ;
    VSwim = activity (mkVP L.swim_V) ;
    VWalk = activity (mkVP L.walk_V) ;
    VStop = activity (mkVP L.stop_V) ;
    VDrink = activity (mkVP <lin V L.drink_V2 : V>) ;
    VEat = activity (mkVP <lin V L.eat_V2 : V>) ;
    VRead = activity (mkVP <lin V L.read_V2 : V>) ;
    VWait = activity (mkVP <lin V L.wait_V2 : V>) ;
    VWrite = activity (mkVP <lin V L.write_V2 : V>) ;
    V2Buy o = activity (mkVP L.buy_V2 o) ;
    V2Drink o = activity (mkVP L.drink_V2 o) ;
    V2Eat o = activity (mkVP L.eat_V2 o) ;
    V2Wait p = {forms = \\bound => boundPersonVP bound L.wait_V2 p ; owner = p.ref} ;
  oper
    NPPerson : Type = {
      name : NP ; ref : Referent ; gap : Str ;
      isPron : Bool ; poss : Quant
      } ;
    person : Referent -> Pron -> NPPerson = \r,p -> {
      name = mkNP p ; ref = r ; gap = [] ;
      isPron = True ; poss = mkQuant p
      } ;
    mkRelative : GNumber -> CN -> NPPerson -> NPPerson = \n,cn,p ->
      let num = if_then_else Num n plNum sgNum in {
        name = mkNP (case p.isPron of {True => p.poss ; False => E.GenNP p.name}) num cn ;
        -- English keeps ordinary possessives under subject binding:
        -- his wife / his son's wife. Only a direct object pronoun changes.
        ref = Unresolved ; gap = p.gap ;
        isPron = False ; poss = mkQuant he_Pron
        } ;
    personVP : Referent -> V2 -> NPPerson -> VP = \subject,v,p ->
      boundPersonVP (sameReferent subject p.ref) v p ;
    boundPersonVP : Bool -> V2 -> NPPerson -> VP = \bound,v,p -> case bound of {
      False => mkVP v p.name ;
      True => E.ReflRNP (mkVPSlash v) (retainReferent p.gap E.ReflPron)
      } ;
    -- Retain the implicit participant as a zero constituent for PGF parsing.
    retainReferent : Str -> E.RNP -> E.RNP = \gap,np -> np ** {s = \\a => gap ++ np.s ! a} ;
    EnglishActivity : Type = {forms : Bool => VP ; owner : Referent} ;
    activity : VP -> EnglishActivity = \vp -> {forms = \\_ => vp ; owner = Unresolved} ;
    activityVP : Referent -> EnglishActivity -> VP = \subject,v -> v.forms ! sameReferent subject v.owner ;
}
