concrete SentencesCze of Sentences = NumeralCze ** SentencesI - [
    IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, YouPolFemale,
    WeMale, WeFemale, YouPlurFamMale, YouPlurFamFemale,
    YouPlurPolMale, YouPlurPolFemale, TheyMale, TheyFemale,
    Transport, Person, NPPerson, mkPerson, relativePerson, PersonName, NameNN,
    Nationality, LAnguage, Citizenship, Country, PCountry, NPNationality, mkNPNationality,
    LangNat, CitiNat, CountryNat, PropCit, ACitizen, PLanguage, PCitizenship,
    VerbPhrase, VPlay, VRun, VSit, VSleep, VSwim, VWalk, VStop,
    VDrink, VEat, VRead, VWait, VWrite, V2Buy, V2Drink, V2Eat, V2Wait,
    ADoVerbPhrase, AModVerbPhrase, ADoVerbPhrasePlace, AModVerbPhrasePlace,
    QWhereDoVerbPhrase, QWhereModVerbPhrase,
    PImperativeFamPos, PImperativeFamNeg, PImperativePolPos, PImperativePolNeg,
    PImperativePlurPos, PImperativePlurNeg
  ] with
    (Syntax = SyntaxCze),
    (Symbolic = SymbolicCze),
    (Lexicon = LexiconCze)
  ** open ParadigmsCze, SyntaxCze, SyntaxCzeExtra, Prelude, (L = LexiconCze) in {
  lincat
    Transport = CzechTransport ;
    Person = NPPerson ;
    Nationality = CzechNationality ;
    LAnguage = CzechLanguage ;
    Citizenship = CzechCitizenship ;
    Country = CzechCountry ;
    VerbPhrase = CzechActivity ;
  lin
    LangNat n = n.language ;
    CitiNat n = n.citizenship ;
    CountryNat n = n.country ;
    PropCit c = c.modifier ;
    -- Grammatical gender need not identify a person's sex: děti is feminine.
    ACitizen p c = case p.unknownGender of {
      True => mkCl p.name have_V2 (mkNP (mkCN c.modifier (kostN "národnost"))) ;
      False => mkCl p.name (genderedCNVP c.male c.female)
      } ;
    NameNN = mkNP (mkPN "NN" mascAnimate) ;
    PersonName n = {name = n ; isPron = False ; poss = mkQuant he_Pron ; unknownGender = True} ;

    PLanguage l = mkPhrase (mkUtt l.name) ;
    PCountry c = mkPhrase (mkUtt c.name) ;
    PCitizenship c = mkPhrase (mkUtt c.male) ;

    ADoVerbPhrase p v = mkCl p.name v.statement ;
    AModVerbPhrase m p v = mkCl p.name (mkVP m v.infinitive) ;
    ADoVerbPhrasePlace p v x = mkCl p.name (mkVP v.statement x.at) ;
    AModVerbPhrasePlace m p v x = mkCl p.name (mkVP m (mkVP v.infinitive x.at)) ;
    QWhereDoVerbPhrase p v = mkQS (mkQCl where_IAdv (mkCl p.name v.statement)) ;
    QWhereModVerbPhrase m p v = mkQS (mkQCl where_IAdv (mkCl p.name (mkVP m v.infinitive))) ;

    PImperativeFamPos v = phrasePlease (mkUtt (mkImp v.command)) ;
    PImperativePolPos v = phrasePlease (mkUtt politeImpForm (mkImp v.command)) ;
    PImperativePlurPos v = phrasePlease (mkUtt pluralImpForm (mkImp v.command)) ;
    PImperativeFamNeg v = phrasePlease (mkUtt negativePol (mkImp v.statement)) ;
    PImperativePolNeg v = phrasePlease (mkUtt politeImpForm negativePol (mkImp v.statement)) ;
    PImperativePlurNeg v = phrasePlease (mkUtt pluralImpForm negativePol (mkImp v.statement)) ;

    VPlay = activity (mkVP L.play_V) ;
    VRun = activity (mkVP L.run_V) ;
    VSit = activity (mkVP L.sit_V) ;
    VSleep = activity (mkVP L.sleep_V) ;
    VSwim = activity (mkVP L.swim_V) ;
    VWalk = activity (mkVP L.walk_V) ;
    VDrink = activity (mkVP <lin V L.drink_V2 : V>) ;
    VEat = activity (mkVP <lin V L.eat_V2 : V>) ;
    VRead = activity (mkVP <lin V L.read_V2 : V>) ;
    VWait = activity (mkVP <lin V L.wait_V2 : V>) ;
    VWrite = activity (mkVP <lin V L.write_V2 : V>) ;
    V2Buy o = activity (mkVP L.buy_V2 o) ;
    V2Drink o = activity (mkVP L.drink_V2 o) ;
    V2Eat o = activity (mkVP L.eat_V2 o) ;
    V2Wait p = activity (mkVP L.wait_V2 p.name) ;
    -- One stopping event is requested by a positive command. Modal infinitives
    -- use the perfective too; statements and prohibitions use the imperfective.
    VStop = {statement = mkVP stopImperfective_V ; infinitive,command = mkVP stopPerfective_V} ;

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
  oper
    NPPerson : Type = {name : NP ; isPron,unknownGender : Bool ; poss : Quant} ;
    mkPerson : Pron -> NPPerson = \p -> {
      name = mkNP p ; isPron = True ; poss = mkQuant p ; unknownGender = False
      } ;
    relativePerson : GNumber -> CN -> (Num -> NP -> CN -> NP) -> NPPerson -> NPPerson = \n,x,f,p ->
      let num = if_then_else Num n plNum sgNum in {
        name = case p.isPron of {True => mkNP p.poss num x ; False => f num p.name x} ;
        isPron = False ; poss = mkQuant he_Pron ; unknownGender = False
        } ;

    CzechCitizenship : Type = {modifier : A ; male,female : CN} ;
    CzechCountry : Type = {name : NP ; at : Adv} ;
    CzechLanguage : Type = {name : NP ; spoken : Adv} ;
    CzechNationality : Type = {language : CzechLanguage ; country : CzechCountry ; citizenship : CzechCitizenship} ;
    CzechTransport : Type = {name : CN ; by : Adv ; motion : V} ;
    CzechActivity : Type = {statement,infinitive,command : VP} ;
    activity : VP -> CzechActivity = \vp -> {statement,infinitive,command = vp} ;
    stopImperfective_V : V = reflV (mkV "zastavovat" "zastavuji" "zastavuješ" "zastavuje" "zastavujeme" "zastavujete" "zastavují" "zastavoval" "zastavovali" "zastavuj" "zastavujme" "zastavujte") accusative ;
    stopPerfective_V : V = reflV (mkV "zastavit" "zastavím" "zastavíš" "zastaví" "zastavíme" "zastavíte" "zastaví" "zastavil" "zastavili" "zastav" "zastavme" "zastavte") accusative ;
}
