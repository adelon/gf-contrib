concrete SentencesCze of Sentences = NumeralCze ** SentencesI - [
AKnowPerson,
    He, She, IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, YouPolFemale,
    WeMale, WeFemale, YouPlurFamMale, YouPlurFamFemale,
    YouPlurPolMale, YouPlurPolFemale, TheyMale, TheyFemale,
    Transport, Person, NPPerson, mkPerson, personNP, relativePerson, mkRelative, PersonName, NameNN,
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
  ** open ParadigmsCze, SyntaxCze, ExtraCze, Prelude, (L = LexiconCze) in {
  param
    HumanSex = Male | Female | UnknownSex ;
    -- The pronoun constructors identify discourse participants. Kinship
    -- descriptions do not introduce a new globally identifiable participant.
    Referent = Speaker | Addressee | MaleThird | FemaleThird |
      SpeakerGroup | AddresseeGroup | ThirdMaleGroup | ThirdFemaleGroup | Unresolved ;
  lincat
    Transport = CzechTransport ;
    Person = NPPerson ;
    Nationality = CzechNationality ;
    LAnguage = CzechLanguage ;
    Citizenship = CzechCitizenship ;
    Country = CzechCountry ;
    VerbPhrase = CzechActivity ;
  lin
    AKnowPerson p q = mkCl (personNP p) L.know_V2 (personObject p.ref q) ;

    LangNat n = n.language ;
    CitiNat n = n.citizenship ;
    CountryNat n = n.country ;
    PropCit c = c.modifier ;
    ACitizen p c = case p.sex of {
      Male => mkCl (personNP p) (mkVP c.male) ;
      Female => mkCl (personNP p) (mkVP c.female) ;
      UnknownSex => mkCl (personNP p) have_V2 (mkNP (mkCN c.modifier (kostN "národnost")))
      } ;
    NameNN = mkNP (mkPN "NN" mascAnimate) ;
    PersonName n = {
      forms = plainPossessiveNP n ; ref = Unresolved ; owner = Unresolved ; sex = UnknownSex ;
      isPron = False ; poss = mkQuant he_Pron
      } ;

    PLanguage l = mkPhrase (mkUtt l.name) ;
    PCountry c = mkPhrase (mkUtt c.name) ;
    PCitizenship c = mkPhrase (mkUtt c.male) ;

    ADoVerbPhrase p v = mkCl (personNP p) (activityVP False p.ref v) ;
    AModVerbPhrase m p v = mkCl (personNP p) (mkVP m (activityVP True p.ref v)) ;
    ADoVerbPhrasePlace p v x = mkCl (personNP p) (mkVP (activityVP False p.ref v) x.at) ;
    AModVerbPhrasePlace m p v x = mkCl (personNP p) (mkVP m (mkVP (activityVP True p.ref v) x.at)) ;
    QWhereDoVerbPhrase p v = mkQS (mkQCl where_IAdv (mkCl (personNP p) (activityVP False p.ref v))) ;
    QWhereModVerbPhrase m p v = mkQS (mkQCl where_IAdv (mkCl (personNP p) (mkVP m (activityVP True p.ref v)))) ;

    PImperativeFamPos v = phrasePlease (mkUtt (mkImp (activityVP True Addressee v))) ;
    PImperativePolPos v = phrasePlease (mkUtt politeImpForm (mkImp (activityVP True Addressee v))) ;
    PImperativePlurPos v = phrasePlease (mkUtt pluralImpForm (mkImp (activityVP True AddresseeGroup v))) ;
    PImperativeFamNeg v = phrasePlease (mkUtt negativePol (mkImp (activityVP False Addressee v))) ;
    PImperativePolNeg v = phrasePlease (mkUtt politeImpForm negativePol (mkImp (activityVP False Addressee v))) ;
    PImperativePlurNeg v = phrasePlease (mkUtt pluralImpForm negativePol (mkImp (activityVP False AddresseeGroup v))) ;

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
    V2Wait p = {
      ongoing,event = \\bound => mkVP L.wait_V2 (boundPersonObject bound p) ;
      owner = objectReferent p
      } ;
    VStop = eventActivity (mkVP stopImperfective_V) (mkVP stopPerfective_V) ;

    He = person MaleThird Male he_Pron ;
    She = person FemaleThird Female she_Pron ;
    IMale = person Speaker Male i_Pron ;
    IFemale = person Speaker Female (genderPron feminine i_Pron) ;
    YouFamMale = person Addressee Male youSg_Pron ;
    YouFamFemale = person Addressee Female (genderPron feminine youSg_Pron) ;
    YouPolMale = person Addressee Male youPol_Pron ;
    YouPolFemale = person Addressee Female (genderPron feminine youPol_Pron) ;
    WeMale = person SpeakerGroup Male we_Pron ;
    WeFemale = person SpeakerGroup Female (genderPron feminine we_Pron) ;
    YouPlurFamMale, YouPlurPolMale = person AddresseeGroup Male youPl_Pron ;
    YouPlurFamFemale, YouPlurPolFemale = person AddresseeGroup Female (genderPron feminine youPl_Pron) ;
    TheyMale = person ThirdMaleGroup Male they_Pron ;
    TheyFemale = person ThirdFemaleGroup Female (genderPron feminine they_Pron) ;
  oper
    NPPerson : Type = {
      forms : PossessiveNP ; ref,owner : Referent ; sex : HumanSex ;
      isPron : Bool ; poss : Quant
      } ;
    person : Referent -> HumanSex -> Pron -> NPPerson = \r,sex,p -> {
      forms = plainPossessiveNP (mkNP p) ; ref = r ; owner = Unresolved ; sex = sex ;
      isPron = True ; poss = mkQuant p
      } ;
    mkRelative : GNumber -> CN -> NPPerson -> NPPerson = \n,x,p ->
      let num = if_then_else Num n plNum sgNum in {
        forms = case p.isPron of {
          True => possessiveNP p.forms p.poss num x ;
          False => genitivePossessiveNP p.forms num x
          } ;
        owner = p.ref ; ref = Unresolved ; sex = UnknownSex ;
        isPron = False ; poss = mkQuant he_Pron
        } ;
    personNP : NPPerson -> NP = \p -> usePossessiveNP False p.forms ;
    personObject : Referent -> NPPerson -> NP = \subject,p ->
      boundPersonObject (sameReferent subject (objectReferent p)) p ;
    objectReferent : NPPerson -> Referent = \p -> case p.ref of {
      Unresolved => p.owner ; _ => p.ref
      } ;
    boundPersonObject : Bool -> NPPerson -> NP = \bound,p -> case bound of {
      False => personNP p ;
      True => case p.ref of {
        Unresolved => usePossessiveNP True p.forms ;
        _ => reflexiveObjectNP p.forms
        }
      } ;
    sameReferent : Referent -> Referent -> Bool = \a,b -> case <a,b> of {
      <Speaker,Speaker> | <Addressee,Addressee> | <MaleThird,MaleThird> |
      <FemaleThird,FemaleThird> | <SpeakerGroup,SpeakerGroup> |
      <AddresseeGroup,AddresseeGroup> |
      <ThirdMaleGroup,ThirdMaleGroup> | <ThirdFemaleGroup,ThirdFemaleGroup> => True ; _ => False
      } ;

    CzechCitizenship : Type = {modifier : A ; male,female : CN} ;
    CzechCountry : Type = {name : NP ; at : Adv} ;
    CzechLanguage : Type = {name : NP ; spoken : Adv} ;
    CzechNationality : Type = {language : CzechLanguage ; country : CzechCountry ; citizenship : CzechCitizenship} ;
    CzechTransport : Type = {name : CN ; by : Adv ; motion : V} ;
    CzechActivity : Type = {ongoing,event : Bool => VP ; owner : Referent} ;
    activityVP : Bool -> Referent -> CzechActivity -> VP = \bounded,subject,v ->
      case bounded of {
        True => v.event ! sameReferent subject v.owner ;
        False => v.ongoing ! sameReferent subject v.owner
        } ;
    activity : VP -> CzechActivity = \vp -> eventActivity vp vp ;
    eventActivity : VP -> VP -> CzechActivity = \ongoing,event -> {
      ongoing = \\_ => ongoing ; event = \\_ => event ; owner = Unresolved
      } ;
    stopImperfective_V : V = reflV (mkV "zastavovat" "zastavuji" "zastavuješ" "zastavuje" "zastavujeme" "zastavujete" "zastavují" "zastavoval" "zastavovali" "zastavuj" "zastavujme" "zastavujte") accusative ;
    stopPerfective_V : V = reflV (mkV "zastavit" "zastavím" "zastavíš" "zastaví" "zastavíme" "zastavíte" "zastaví" "zastavil" "zastavili" "zastav" "zastavme" "zastavte") accusative ;
}
