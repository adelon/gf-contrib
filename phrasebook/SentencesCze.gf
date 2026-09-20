concrete SentencesCze of Sentences = NumeralCze ** SentencesI - [
Object, PrimObject, ObjItem, ObjNumber, ObjIndef, ObjPlural, ObjPlur, ObjMass,
    ObjAndObj, OneObj, DrinkNumber, PObject, GObjectPlease, SHave, QDoHave,
    Modality, MCan, MKnow, MMust, MWant, AKnowPerson,
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
  ** open ParadigmsCze, SyntaxCze, ExtraCze, Prelude, PhrasebookReferents,
    (E = ExtendCze), (L = LexiconCze) in {
  param
    HumanSex = Male | Female | UnknownSex ;
  lincat
    Object, PrimObject = CzechObject ;
    Modality = CzechModality ;
    Transport = CzechTransport ;
    Person = NPPerson ;
    Nationality = CzechNationality ;
    LAnguage = CzechLanguage ;
    Citizenship = CzechCitizenship ;
    Country = CzechCountry ;
    VerbPhrase = CzechActivity ;
  lin
    ObjItem i = object True i ;
    ObjNumber n k = object True (mkNP n k) ;
    ObjIndef k = object True (mkNP a_Quant k) ;
    ObjPlural k = object False (mkNP aPl_Det k) ;
    ObjPlur k = object False (mkNP aPl_Det k) ;
    ObjMass k = object False (mkNP k) ;
    ObjAndObj a b = object (andB a.bounded b.bounded) (mkNP and_Conj a.np b.np) ;
    OneObj o = o ;
    DrinkNumber n k = object True (mkNP n k) ;
    PObject o = mkPhrase (mkUtt o.np) ;
    GObjectPlease o = lin Text (mkPhr noPConj (mkUtt o.np) please_Voc) | lin Text (mkUtt o.np) ;
    SHave p o = mkS (mkCl (personNP p) have_V2 o.np) ;
    QDoHave p o = mkQS (mkQCl (mkCl (personNP p) have_V2 o.np)) ;
    AKnowPerson p q = mkCl (personNP p) (personVP p.ref L.know_V2 q) ;

    MCan = {verb = can_VV ; bounded = True} ;
    MKnow = {verb = can8know_VV ; bounded = False} ;
    MMust = {verb = must_VV ; bounded = True} ;
    MWant = {verb = want_VV ; bounded = True} ;

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
      name = n ; bound = E.ReflPron ; ref,anchor = Unresolved ; sex = UnknownSex ;
      isPron = False ; poss = mkQuant he_Pron ; boundPoss = E.ReflPossPron
      } ;

    PLanguage l = mkPhrase (mkUtt l.name) ;
    PCountry c = mkPhrase (mkUtt c.name) ;
    PCitizenship c = mkPhrase (mkUtt c.male) ;

    ADoVerbPhrase p v = mkCl (personNP p) (activityVP False p.ref v) ;
    AModVerbPhrase m p v = mkCl (personNP p) (mkVP m.verb (activityVP m.bounded p.ref v)) ;
    ADoVerbPhrasePlace p v x = mkCl (personNP p) (mkVP (activityVP False p.ref v) x.at) ;
    AModVerbPhrasePlace m p v x = mkCl (personNP p) (mkVP m.verb (mkVP (activityVP m.bounded p.ref v) x.at)) ;
    QWhereDoVerbPhrase p v = mkQS (mkQCl where_IAdv (mkCl (personNP p) (activityVP False p.ref v))) ;
    QWhereModVerbPhrase m p v = mkQS (mkQCl where_IAdv (mkCl (personNP p) (mkVP m.verb (activityVP m.bounded p.ref v)))) ;

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
    -- Buying requests denote a purchase, including a purchase of an
    -- unspecified amount. Consumption has an endpoint only for bounded objects.
    V2Buy o = eventActivity (mkVP L.buy_V2 o.np) (mkVP buyPerfective_V2 o.np) ;
    V2Drink o = consumption L.drink_V2 drinkPerfective_V2 o ;
    V2Eat o = consumption L.eat_V2 eatPerfective_V2 o ;
    V2Wait p = {
      ongoing,event = \\bound => boundPersonVP bound L.wait_V2 p ;
      owner = p.anchor
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
      name : NP ; bound : E.RNP ; ref,anchor : Referent ; sex : HumanSex ;
      isPron : Bool ; poss,boundPoss : Quant
      } ;
    person : Referent -> HumanSex -> Pron -> NPPerson = \r,sex,p -> {
      name = mkNP p ; bound = E.ReflPron ; ref,anchor = r ; sex = sex ;
      isPron = True ; poss = mkQuant p ; boundPoss = E.ReflPossPron
      } ;
    mkRelative : GNumber -> CN -> NPPerson -> NPPerson = \n,x,p ->
      let num = if_then_else Num n plNum sgNum in {
        name = case p.isPron of {
          True => mkNP p.poss num x ;
          False => mkNP (mkNP the_Quant num x) (SyntaxCze.mkAdv possess_Prep p.name)
          } ;
        bound = case p.isPron of {
          -- Consume the owner's actual possessive forms in both readings.
          -- RNP retains the case forms of the NP built by the public API.
          True => let np : NP = mkNP p.boundPoss num x in lin RNP {s = np.s ; prep = np.prep} ;
          False => E.AdvRNP (mkNP the_Quant num x) possess_Prep p.bound
          } ;
        anchor = p.anchor ; ref = Unresolved ; sex = UnknownSex ;
        isPron = False ; poss = mkQuant he_Pron ; boundPoss = E.ReflPossPron
        } ;
    personNP : NPPerson -> NP = \p -> p.name ;
    personVP : Referent -> V2 -> NPPerson -> VP = \subject,v,p ->
      boundPersonVP (sameReferent subject p.anchor) v p ;
    boundPersonVP : Bool -> V2 -> NPPerson -> VP = \bound,v,p -> case bound of {
      False => mkVP v p.name ;
      True => E.ReflRNP (mkVPSlash v) p.bound
      } ;

    CzechCitizenship : Type = {modifier : A ; male,female : CN} ;
    CzechCountry : Type = {name : NP ; at : Adv} ;
    CzechLanguage : Type = {name : NP ; spoken : Adv} ;
    CzechNationality : Type = {language : CzechLanguage ; country : CzechCountry ; citizenship : CzechCitizenship} ;
    CzechTransport : Type = {name : CN ; by : Adv ; motion : V} ;
    CzechObject : Type = {np : NP ; bounded : Bool} ;
    object : Bool -> NP -> CzechObject = \bounded,np -> {np = np ; bounded = bounded} ;
    CzechModality : Type = {verb : VV ; bounded : Bool} ;
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
    consumption : V2 -> V2 -> CzechObject -> CzechActivity = \ongoing,event,o ->
      eventActivity (mkVP ongoing o.np)
        (mkVP (case o.bounded of {True => event ; False => ongoing}) o.np) ;
    buyPerfective_V2 : V2 = lin V2 (mkV2 (mkV "koupit" "koupím" "koupíš" "koupí" "koupíme" "koupíte" "koupí" "koupil" "koupili" "kup" "kupme" "kupte") );
    eatPerfective_V2 : V2 = lin V2 (mkV2 (mkV "sníst" "sním" "sníš" "sní" "sníme" "sníte" "snědí" "snědl" "snědli" "sněz" "snězme" "snězte") );
    drinkPerfective_V2 : V2 = lin V2 (mkV2 (mkV "vypít" "vypiji" "vypiješ" "vypije" "vypijeme" "vypijete" "vypijí" "vypil" "vypili" "vypij" "vypijme" "vypijte") );
    stopImperfective_V : V = reflV (mkV "zastavovat" "zastavuji" "zastavuješ" "zastavuje" "zastavujeme" "zastavujete" "zastavují" "zastavoval" "zastavovali" "zastavuj" "zastavujme" "zastavujte") accusative ;
    stopPerfective_V : V = reflV (mkV "zastavit" "zastavím" "zastavíš" "zastaví" "zastavíme" "zastavíte" "zastaví" "zastavil" "zastavili" "zastav" "zastavme" "zastavte") accusative ;
}
