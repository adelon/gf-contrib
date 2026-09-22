concrete SentencesCze of Sentences = NumeralCze ** SentencesI - [
    Object, PrimObject, ObjItem, ObjNumber, ObjIndef, ObjPlural, ObjPlur, ObjMass,
    ObjAndObj, OneObj, DrinkNumber, PObject, GObjectPlease, SHave, QDoHave,
    Modality, MCan, MKnow, MMust, MWant, AKnowPerson,
    Place, NPPlace, placeNP, PPlace, WherePlace,
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
    (E = ExtendCze), (L = LexiconCze), (R = ResCze) in {
  param
    HumanSex = Male | Female | UnknownSex ;
  lincat
    Place = NPPlace ;
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
    ObjAndObj a b = object (andB a.bounded b.bounded) (mkNP and_Conj (objectNP a) (objectNP b)) ;
    OneObj o = o ;
    DrinkNumber n k = object True (mkNP n k) ;
    PObject o = mkPhrase (mkUtt (objectNP o)) ;
    GObjectPlease o = lin Text (mkPhr noPConj (E.UttAccNP (objectNP o)) please_Voc) | lin Text (E.UttAccNP (objectNP o)) ;
    SHave p o = mkS (mkCl (personNP p) have_V2 (objectNP o)) ;
    QDoHave p o = mkQS (mkQCl (mkCl (personNP p) have_V2 (objectNP o))) ;
    PPlace p = mkPhrase (mkUtt (placeName p)) ;
    WherePlace p = mkQS (mkQCl where_IAdv (placeName p)) ;
    AKnowPerson p q = mkCl (personNP p) (personVP (personRef p) L.know_V2 q) ;

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
      name = n ; bound = E.fullRNP n ; anchor = Unresolved ; sex = UnknownSex ;
      isPron = False ; poss = mkQuant he_Pron ; boundPoss = E.ReflPossPron
      } ;

    PLanguage l = mkPhrase l.label ;
    PCountry c = mkPhrase c.label ;
    PCitizenship c = mkPhrase (mkUtt c.male) ;

    ADoVerbPhrase p v = mkCl (personNP p) (activityVP False (personRef p) v) ;
    AModVerbPhrase m p v = mkCl (personNP p) (mkVP m.verb (activityVP m.bounded (personRef p) v)) ;
    ADoVerbPhrasePlace p v x = mkCl (personNP p) (mkVP (activityVP False (personRef p) v) x.at) ;
    AModVerbPhrasePlace m p v x = mkCl (personNP p) (mkVP m.verb (mkVP (activityVP m.bounded (personRef p) v) x.at)) ;
    QWhereDoVerbPhrase p v = mkQS (mkQCl where_IAdv (mkCl (personNP p) (activityVP False (personRef p) v))) ;
    QWhereModVerbPhrase m p v = mkQS (mkQCl where_IAdv (mkCl (personNP p) (mkVP m.verb (activityVP m.bounded (personRef p) v)))) ;

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
    V2Buy o = eventActivity (mkVP L.buy_V2 (objectNP o)) (mkVP buyPerfective_V2 (objectNP o)) ;
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
    -- Objects and places are nominal descriptions, never personal pronouns.
    -- Keep both agreements: quantified NPs can have different clause and
    -- modifier agreement. Only their constant pronoun flags are reconstructed.
    NominalForms : Type = R.NPForms ** {a : R.Agr ; m : R.ModifierAgr} ;
    nominalForms : NP -> NominalForms = \np -> np ;
    nominalNP : NominalForms -> NP = \np -> lin NP (np ** {
      clit = np.s ; hasClit,isDrop,isPron = False
      }) ;
    NPPlace : Type = {name : NominalForms ; at,to : Adv} ;
    placeName : NPPlace -> NP = \p -> nominalNP p.name ;
    placeNP : Det -> CNPlace -> NPPlace = \det,kind ->
      let np : NP = mkNP det kind.name in {
        name = nominalForms np ;
        at = SyntaxCze.mkAdv kind.at np ; to = SyntaxCze.mkAdv kind.to np
        } ;
    -- Persons are bare pronouns, proper names or unquantified kinship NPs.
    -- Their modifier agreement follows a; isPron determines clitic eligibility
    -- and neutral subject omission. Store these correlated choices only once.
    PersonForms : Type = R.NPForms ** {clit : R.Case => Str ; a : R.Agr} ;
    personForms : NP -> PersonForms = \np -> np ;
    NPPerson : Type = {
      name : PersonForms ; bound : E.BoundNPForms ;
      anchor : Referent ; sex : HumanSex ;
      isPron : Bool ; poss,boundPoss : Quant
      } ;
    person : Referent -> HumanSex -> Pron -> NPPerson = \r,sex,p -> {
      name = personForms (mkNP p) ; bound = E.ReflPron ; anchor = r ; sex = sex ;
      isPron = True ; poss = mkQuant p ; boundPoss = E.ReflPossPron
      } ;
    mkRelative : GNumber -> CN -> NPPerson -> NPPerson = \n,x,p ->
      let num = if_then_else Num n plNum sgNum in {
        name = personForms (case p.isPron of {
          True => mkNP p.poss num x ;
          False => mkNP (mkNP the_Quant num x) (SyntaxCze.mkAdv possess_Prep (personNP p))
          }) ;
        bound = case p.isPron of {
          -- Consume the owner's actual possessive forms in both readings.
          -- Retain the RGL's case and constituent-placement forms.
          True => let np : NP = mkNP p.boundPoss num x in E.fullRNP np ;
          False => E.AdvRNP (mkNP the_Quant num x) possess_Prep (personRNP p)
          } ;
        anchor = p.anchor ; sex = UnknownSex ;
        isPron = False ; poss = mkQuant he_Pron ; boundPoss = E.ReflPossPron
        } ;
    personRef : NPPerson -> Referent = \p -> case p.isPron of {
      True => p.anchor ; False => Unresolved
      } ;
    -- These are genuine RGL values, reconstructed at the composition boundary.
    -- Keeping their derived parameters in NPPerson would multiply its states.
    personNP : NPPerson -> NP = \p -> lin NP (p.name ** {
      m = R.modifierAgr p.name.a ;
      hasClit,isDrop,isPron = p.isPron
      }) ;
    personRNP : NPPerson -> E.RNP = \p -> lin RNP (p.bound ** {
      m = case p.isPron of {
        True => E.AntecedentHead ;
        False => E.FixedHead (R.modifierAgr p.name.a)
        } ;
      isPron = p.isPron
      }) ;
    personVP : Referent -> V2 -> NPPerson -> VP = \subject,v,p ->
      boundPersonVP (sameReferent subject p.anchor) v p ;
    boundPersonVP : Bool -> V2 -> NPPerson -> VP = \bound,v,p -> case bound of {
      False => mkVP v (personNP p) ;
      True => E.ReflRNP (mkVPSlash v) (personRNP p)
      } ;

    CzechCitizenship : Type = {modifier : A ; male,female : CN} ;
    -- These names occur only as citation utterances. The separate location
    -- and spoken-language expressions have already received their own case.
    CzechCountry : Type = {label : Utt ; at : Adv} ;
    CzechLanguage : Type = {label : Utt ; spoken : Adv} ;
    CzechNationality : Type = {language : CzechLanguage ; country : CzechCountry ; citizenship : CzechCitizenship} ;
    CzechTransport : Type = {name : CN ; by : Adv ; motion : V} ;
    CzechObject : Type = {np : NominalForms ; bounded : Bool} ;
    object : Bool -> NP -> CzechObject = \bounded,np -> {np = nominalForms np ; bounded = bounded} ;
    objectNP : CzechObject -> NP = \o -> nominalNP o.np ;
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
      eventActivity (mkVP ongoing (objectNP o))
        (mkVP (case o.bounded of {True => event ; False => ongoing}) (objectNP o)) ;
    buyPerfective_V2 : V2 = lin V2 (mkV2 (mkV "koupit" "koupím" "koupíš" "koupí" "koupíme" "koupíte" "koupí" "koupil" "koupili" "kup" "kupme" "kupte") );
    eatPerfective_V2 : V2 = lin V2 (mkV2 (mkV "sníst" "sním" "sníš" "sní" "sníme" "sníte" "snědí" "snědl" "snědli" "sněz" "snězme" "snězte") );
    drinkPerfective_V2 : V2 = lin V2 (mkV2 (mkV "vypít" "vypiji" "vypiješ" "vypije" "vypijeme" "vypijete" "vypijí" "vypil" "vypili" "vypij" "vypijme" "vypijte") );
    stopImperfective_V : V = reflV (mkV "zastavovat" "zastavuji" "zastavuješ" "zastavuje" "zastavujeme" "zastavujete" "zastavují" "zastavoval" "zastavovali" "zastavuj" "zastavujme" "zastavujte") accusative ;
    stopPerfective_V : V = reflV (mkV "zastavit" "zastavím" "zastavíš" "zastaví" "zastavíme" "zastavíte" "zastaví" "zastavil" "zastavili" "zastav" "zastavme" "zastavte") accusative ;
}
