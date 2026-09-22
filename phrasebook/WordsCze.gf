concrete WordsCze of Words = SentencesCze **
  open Prelude, SyntaxCze, ExtraCze, ParadigmsCze, (L = LexiconCze), (P = ParadigmsCze) in {

-- Domain meanings are realized through typed Czech RGL constructions.
lin
  Apple = mkCN L.apple_N ;
  Beer = mkCN L.beer_N ;
  Bread = mkCN L.bread_N ;
  Cheese = mkCN (hradN "sýr") ;
  Chicken = mkCN (mkA "kuřecí") (mestoN "maso") ;
  Coffee = mkCN (zenaN "káva") ;
  Fish = mkCN L.fish_N ;
  Meat = mkCN (mestoN "maso") ;
  Milk = mkCN L.milk_N ;
  Pizza = mkCN (zenaN "pizza") ;
  Salt = mkCN L.salt_N ;
  Tea = mkCN (strojN "čaj") ;
  Water = mkCN L.water_N ;
  Wine = mkCN L.wine_N ;

  Bad = L.bad_A ;
  Boring = mkA "nudný" ;
  Cheap = mkA "levný" ;
  Cold = L.cold_A ;
  Delicious = mkA "chutný" ;
  Expensive = mkA "drahý" ;
  Fresh = mkA "čerstvý" ;
  Good = L.good_A ;
  Suspect = mkA "podezřelý" ;
  Warm = L.warm_A ;

  Airport = place (mkCN ((moreN "letiště") ** {pgen = "letišť"})) on_Prep (P.mkPrep "na" accusative) ;
  AmusementPark = place (mkCN (mkA "zábavní") (hradN "park")) in_Prep to_Prep ;
  Bank = indoors (zenaN "banka") ;
  Bar = indoors (hradN "bar") ;
  Cafeteria = indoors (zenaN "jídelna") ;
  Center = indoors (mkN "centrum" "centra" neuter) ;
  Cinema = indoors ((mestoN "kino") ** {sloc = "kině"}) ;
  Church = indoors ((hradN "kostel") ** {sgen = "kostela" ; sloc = "kostele"}) ;
  Disco = place (mkCN (zenaN "diskotéka")) on_Prep (P.mkPrep "na" accusative) ;
  Hospital = indoors (ruzeN "nemocnice") ;
  Hotel = indoors (hradN "hotel") ;
  Museum = place (mkCN (mkN "muzeum" "muzea" neuter)) in_Prep to_Prep ;
  Park = indoors (hradN "park") ;
  Parking = place (mkCN ((moreN "parkoviště") ** {pgen = "parkovišť"})) on_Prep (P.mkPrep "na" accusative) ;
  Pharmacy = indoors (zenaN "lékárna") ;
  PostOffice = place (mkCN (zenaN "pošta")) on_Prep (P.mkPrep "na" accusative) ;
  Pub = indoors (zenaN "hospoda") ;
  Restaurant = indoors restaurant_N ;
  School = place (mkCN L.school_N) in_Prep to_Prep ;
  Shop = indoors ((hradN "obchod") ** {sloc = "obchodě"}) ;
  Station = place (mkCN (staveniN "nádraží")) on_Prep (P.mkPrep "na" accusative) ;
  Supermarket = indoors (hradN "supermarket") ;
  Theatre = indoors ((mestoN "divadlo") ** {sloc = "divadle" ; pgen = "divadel"}) ;
  Toilet = place (mkCN (zenaN "toaleta")) on_Prep (P.mkPrep "na" accusative) ;
  University = place (mkCN (zenaN "univerzita")) on_Prep (P.mkPrep "na" accusative) ;
  Zoo = place (mkCN (mkA "zoologický") (zenaN "zahrada")) in_Prep to_Prep ;
  CitRestaurant cit = place (mkCN cit.modifier restaurant_N) in_Prep to_Prep ;

  Lei = mkCN (mkN "lei" "lei" mascInanimate) ;
  Leva = mkCN (hradN "lev") ;
  Rupee = mkCN (ruzeN "rupie") ;
  Zloty = mkCN (mkN "zlotý" "zlotého" mascInanimate) ;
  Yuan = mkCN (hradN "jüan") ;
  Euro = mkCN ((mestoN "euro") ** {pgen = "eur"}) ;
  Dollar = mkCN (hradN "dolar") ;
  Pound = mkCN ((zenaN "libra") ** {pgen = "liber"}) ;
  Rouble = mkCN (hradN "rubl") ;
  DanishCrown = mkCN (mkA "dánský") (zenaN "koruna") ;
  NorwegianCrown = mkCN (mkA "norský") (zenaN "koruna") ;
  SwedishCrown = mkCN (mkA "švédský") (zenaN "koruna") ;

  Bulgarian = nationality (citizenship (mkA "bulharský") ((panN "Bulhar") ** {pnom = "Bulhaři"})
    ((zenaN "Bulharka") ** {pgen = "Bulharek"}))
    (language (zenaN "bulharština") "bulharsky") (country (mestoN "Bulharsko") in_Prep) ;
  Catalan = nationality (citizenship (mkA "katalánský") ((muzN "Katalánec") ** {pnom = "Katalánci"})
    ((zenaN "Katalánka") ** {pgen = "Katalánek"}))
    (language (zenaN "katalánština") "katalánsky") (country (mestoN "Katalánsko") in_Prep) ;
  Chinese = nationality (citizenship (mkA "čínský") ((panN "Číňan") ** {pnom = "Číňané"})
    ((zenaN "Číňanka") ** {pgen = "Číňanek"}))
    (language (zenaN "čínština") "čínsky") (country (zenaN "Čína") in_Prep) ;
  Danish = nationality (citizenship (mkA "dánský") ((panN "Dán") ** {pnom = "Dánové"})
    ((zenaN "Dánka") ** {pgen = "Dánek"}))
    (language (zenaN "dánština") "dánsky") (country (mestoN "Dánsko") in_Prep) ;
  Dutch = nationality (citizenship (mkA "nizozemský") ((muzN "Nizozemec") ** {pnom = "Nizozemci"})
    ((zenaN "Nizozemka") ** {pgen = "Nizozemek"}))
    (language (zenaN "nizozemština") "nizozemsky") (country (mestoN "Nizozemsko") in_Prep) ;
  English = nationality (citizenship (mkA "anglický") ((panN "Angličan") ** {pnom = "Angličané"})
    ((zenaN "Angličanka") ** {pgen = "Angličanek"}))
    (language (zenaN "angličtina") "anglicky") (country (ruzeN "Anglie") in_Prep) ;
  Finnish = nationality (citizenship (mkA "finský") ((panN "Fin") ** {pnom = "Finové"})
    ((zenaN "Finka") ** {pgen = "Finek"}))
    (language (zenaN "finština") "finsky") (country (mestoN "Finsko") in_Prep) ;
  French = nationality (citizenship (mkA "francouzský") ((panN "Francouz") ** {pnom = "Francouzi"})
    ((zenaN "Francouzka") ** {pgen = "Francouzek"}))
    (language (zenaN "francouzština") "francouzsky") (country (ruzeN "Francie") in_Prep) ;
  German = nationality (citizenship (mkA "německý") ((muzN "Němec") ** {pnom = "Němci"})
    ((zenaN "Němka") ** {pgen = "Němek"}))
    (language (zenaN "němčina") "německy") (country (mestoN "Německo") in_Prep) ;
  Italian = nationality (citizenship (mkA "italský") ((panN "Ital") ** {pnom = "Italové"})
    ((zenaN "Italka") ** {pgen = "Italek"}))
    (language (zenaN "italština") "italsky") (country (ruzeN "Itálie") in_Prep) ;
  Norwegian = nationality (citizenship (mkA "norský") ((panN "Nor") ** {pnom = "Norové"})
    ((zenaN "Norka") ** {pgen = "Norek"}))
    (language (zenaN "norština") "norsky") (country (mestoN "Norsko") in_Prep) ;
  Polish = nationality (citizenship (mkA "polský") ((panN "Polák") ** {pnom = "Poláci"})
    ((zenaN "Polka") ** {pgen = "Polek"}))
    (language (zenaN "polština") "polsky") (country (mestoN "Polsko") in_Prep) ;
  Romanian = nationality (citizenship (mkA "rumunský") ((panN "Rumun") ** {pnom = "Rumuni"})
    ((zenaN "Rumunka") ** {pgen = "Rumunek"}))
    (language (zenaN "rumunština") "rumunsky") (country (mestoN "Rumunsko") in_Prep) ;
  Russian = nationality (citizenship (mkA "ruský") ((panN "Rus") ** {pnom = "Rusové"})
    ((zenaN "Ruska") ** {pgen = "Rusek"}))
    (language (zenaN "ruština") "rusky") (country (mestoN "Rusko") in_Prep) ;
  Spanish = nationality (citizenship (mkA "španělský") ((panN "Španěl") ** {pnom = "Španělé"})
    ((zenaN "Španělka") ** {pgen = "Španělek"}))
    (language (zenaN "španělština") "španělsky") (country (mestoN "Španělsko") in_Prep) ;
  Swedish = nationality (citizenship (mkA "švédský") ((panN "Švéd") ** {pnom = "Švédové"})
    ((zenaN "Švédka") ** {pgen = "Švédek"}))
    (language (zenaN "švédština") "švédsky") (country (mestoN "Švédsko") in_Prep) ;
  Belgian = citizenship (mkA "belgický") ((panN "Belgičan") ** {pnom = "Belgičané"}) ((zenaN "Belgičanka") ** {pgen = "Belgičanek"}) ;
  Indian = citizenship (mkA "indický") ((panN "Ind") ** {pnom = "Indové"}) ((zenaN "Indka") ** {pgen = "Indek"}) ;
  Belgium = country (ruzeN "Belgie") in_Prep ;
  India = country (ruzeN "Indie") in_Prep ;
  Flemish = language (zenaN "vlámština") "vlámsky" ;
  Hindi = language (zenaN "hindština") "hindsky" ;

  TheBest = superlative L.good_A ;
  TheWorst = superlative L.bad_A ;
  TheClosest = superlative (mkA "blízký" "bližší") ;
  TheCheapest = superlative (mkA "levný" "levnější") ;
  TheMostExpensive = superlative (mkA "drahý" "dražší") ;
  TheMostPopular = superlative (mkA "oblíbený" "oblíbenější") ;
  SuperlPlace sup p = placeNP sup p ;

  PSeeYouDate d = farewell d ;
  PSeeYouPlace p = farewell p.at ;
  PSeeYouPlaceDate p d = mkText (farewell p.at) (mkPhrase (mkUtt d)) ;

  ByFoot = P.mkAdv "pěšky" ;
  Bike = (transport ((mestoN "kolo") ** {sloc = "kole"}) ride_V) ** {by = SyntaxCze.mkAdv on_Prep (mkNP ((mestoN "kolo") ** {sloc = "kole"}))} ;
  Bus = transport (hradN "autobus") ride_V ;
  Car = transport (mestoN "auto") ride_V ;
  Ferry = transport (hradN "trajekt") sail_V ;
  Plane = transport (mestoN "letadlo") fly_V ;
  Subway = transport (mestoN "metro") ride_V ;
  Taxi = transport (hradN "taxík") ride_V ;
  Train = transport (hradN "vlak") ride_V ;
  Tram = transport ((pisenN "tramvaj") ** {sgen,pnom,pacc = "tramvaje"}) ride_V ;

  AHasAge p n = DativeCopulaCl (personNP p) (mkNP n L.year_N) ;
  QWhatAge p = mkQS (DativeCopulaQCl (personNP p) (mkIP how8many_IDet (mkCN L.year_N))) ;
  AHasChildren p n = mkCl (personNP p) have_V2 (mkNP n L.child_N) ;
  ALike p item = mkCl (personNP p) (mkVP (SlashV2AP have_V2 like_AP) item) ;
  ALive p country = mkCl (personNP p) (mkVP (mkVP live_V) country.at) ;
  AMarried p = case p.sex of {
    Male => mkCl (personNP p) (mkA "ženatý") ;
    Female => mkCl (personNP p) (mkA "vdaný") ;
    UnknownSex => mkCl (personNP p) (SyntaxCze.mkAdv in_Prep (mkNP (staveniN "manželství")))
    } ;

  ASpeak p language = mkCl (personNP p) (mkVP (mkVP speak_V) language.spoken) ;

  AHasRoom p n = capacity p n room_N ;
  AHasTable p n = capacity p n ((hradN "stůl") ** {sgen = "stolu" ; sdat,sloc = "stolu" ; sins = "stolem"}) ;
  AHasName p n = mkCl (personNP p) (mkV2 name_V) n ;
  AHungry p = mkCl (personNP p) have_V2 (mkNP (hradN "hlad")) ;
  AIll p = mkCl (personNP p) (mkA "nemocný") ;
  AKnow p = mkCl (personNP p) (lin V L.know_VS) ;
  ALove p q = mkCl (personNP p) (personVP (personRef p) L.love_V2 q) ;
  AReady p = mkCl (personNP p) (mkA "připravený") ;
  AScared p = mkCl (personNP p) have_V2 (mkNP (hradN "strach")) ;
  AThirsty p = mkCl (personNP p) have_V2 (mkNP (kostN "žízeň")) ;
  ATired p = mkCl (personNP p) (mkA "unavený") ;
  AUnderstand p = mkCl (personNP p) understand_V ;
  AWant p obj = mkCl (personNP p) (mkV2 <lin V want_VV : V>) (objectNP obj) ;
  AWantGo p place = mkCl (personNP p) want_VV (mkVP (mkVP L.go_V) place.to) ;

  QWhatName p = mkQS (mkQCl how_IAdv (mkCl (personNP p) name_V)) ;
  HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item cost_V)) ;
  ItCost item price = mkCl item (mkV2 cost_V) price ;
  PropOpen p = mkCl (placeName p) (mkA "otevřený") ;
  PropClosed p = mkCl (placeName p) (mkA "zavřený") ;
  PropOpenDate p d = mkCl (placeName p) (mkVP (mkVP (mkA "otevřený")) d) ;
  PropClosedDate p d = mkCl (placeName p) (mkVP (mkVP (mkA "zavřený")) d) ;
  PropOpenDay p d = mkCl (placeName p) (mkVP (mkVP (mkA "otevřený")) d.habitual) ;
  PropClosedDay p d = mkCl (placeName p) (mkVP (mkVP (mkA "zavřený")) d.habitual) ;

  Children p = (mkRelative plur (mkCN L.child_N) p) ** {sex = UnknownSex} ;
  Wife p = (mkRelative sing (mkCN (zenaN "manželka")) p) ** {sex = Female} ;
  Husband p = (mkRelative sing (mkCN L.husband_N) p) ** {sex = Male} ;
  Son p = (mkRelative sing (mkCN ((panN "syn") ** {pnom = "synové"})) p) ** {sex = Male} ;
  Daughter p = (mkRelative sing (mkCN ((zenaN "dcera") ** {sdat,sloc = "dceři"})) p) ** {sex = Female} ;

  Monday = day (staveniN "pondělí") ;
  Tuesday = day (staveniN "úterý") ;
  Wednesday = day (zenaN "středa") ;
  Thursday = day (hradN "čtvrtek") ;
  Friday = day (hradN "pátek") ;
  Saturday = day (zenaN "sobota") ;
  Sunday = day (ruzeN "neděle") ;
  Tomorrow = P.mkAdv "zítra" ;

  HowFar place = mkQS (mkQCl far_IAdv (placeName place)) ;
  HowFarFrom x y = mkQS (mkQCl far_IAdv (mkCl (placeName y) (SyntaxCze.mkAdv (P.mkPrep "od" genitive) (placeName x)))) ;
  HowFarBy y t = mkQS (mkQCl far_IAdv (mkCl (placeName y) t)) ;
  HowFarFromBy x y t = mkQS (mkQCl far_IAdv (mkCl (placeName y) (mkVP (mkVP (SyntaxCze.mkAdv (P.mkPrep "od" genitive) (placeName x))) t))) ;
  WhichTranspPlace t p = mkQS (mkQCl (mkIP which_IDet t.name) (mkVP (mkVP t.motion) p.to)) ;
  IsTranspPlace t p = mkQS (mkQCl (mkCl (mkNP someSg_Det t.name) (mkVP (mkVP t.motion) p.to))) ;

oper
  citizenship : A -> N -> N -> CzechCitizenship = \a,m,f -> {
    modifier = a ; male = mkCN m ; female = mkCN f
    } ;
  language : N -> Str -> CzechLanguage = \n,adv -> {label = mkUtt (mkNP n) ; spoken = P.mkAdv adv} ;
  country : N -> Prep -> CzechCountry = \n,p -> {label = mkUtt (mkNP n) ; at = SyntaxCze.mkAdv p (mkNP n)} ;
  nationality : CzechCitizenship -> CzechLanguage -> CzechCountry -> CzechNationality = \c,l,n -> {
    citizenship = c ; language = l ; country = n
    } ;
  superlative : A -> Det = \a -> mkDet the_Quant (mkOrd a) ;
  farewell : Adv -> Text = \a -> mkText (mkGreeting "na shledanou") (mkPhrase (mkUtt a)) ;
  like_AP : AP = shortAP "rád" "ráda" "rádo" "rádi" "rády" "ráda" ;
  name_V : V = reflV (mkV "jmenovat" "jmenuji" "jmenuješ" "jmenuje" "jmenujeme" "jmenujete" "jmenují" "jmenoval" "jmenovali" "jmenuj" "jmenujme" "jmenujte") accusative ;
  live_V : V = mkV "žít" "žiji" "žiješ" "žije" "žijeme" "žijete" "žijí" "žil" "žili" "žij" "žijme" "žijte" ;
  speak_V : V = mkV "mluvit" "mluvím" "mluvíš" "mluví" "mluvíme" "mluvíte" "mluví" "mluvil" "mluvili" "mluv" "mluvme" "mluvte" ;
  ride_V : V = mkV "jet" "jedu" "jedeš" "jede" "jedeme" "jedete" "jedou" "jel" "jeli" "jeď" "jeďme" "jeďte" ;
  fly_V : V = mkV "letět" "letím" "letíš" "letí" "letíme" "letíte" "letí" "letěl" "letěli" "leť" "leťme" "leťte" ;
  sail_V : V = mkV "plout" "pluji" "pluješ" "pluje" "plujeme" "plujete" "plují" "plul" "pluli" "pluj" "plujme" "plujte" ;
  restaurant_N : N = ruzeN "restaurace" ;
  room_N : N = strojN "pokoj" ;
  understand_V : V = mkV "rozumět" "rozumím" "rozumíš" "rozumí" "rozumíme" "rozumíte" "rozumějí" "rozuměl" "rozuměli" "rozuměj" "rozumějme" "rozumějte" ;
  cost_V : V = mkV "stát" "stojím" "stojíš" "stojí" "stojíme" "stojíte" "stojí" "stál" "stáli" "stůj" "stůjme" "stůjte" ;
  place : CN -> Prep -> Prep -> CNPlace = mkCNPlace ;
  indoors : N -> CNPlace = \n -> place (mkCN n) in_Prep to_Prep ;
  capacity : NPPerson -> Card -> N -> Cl = \p,n,room ->
    mkCl (personNP p) have_V2 (mkNP (mkCN (mkCN room) (SyntaxCze.mkAdv for_Prep (mkNP n (zenaN "osoba"))))) ;
  transport : N -> V -> CzechTransport = \n,v -> {
    name = mkCN n ; motion = v ; by = SyntaxCze.mkAdv (P.mkPrep "" instrumental) (mkNP n)
    } ;
  day : N -> NPDay = \n -> mkNPDay (mkNP n)
    (SyntaxCze.mkAdv (P.v_Prep accusative) (mkNP n))
    (SyntaxCze.mkAdv (P.v_Prep accusative) (mkNP aPl_Det n)) ;
  far_IAdv : IAdv = lin IAdv {s = "jak daleko"} ;
}
