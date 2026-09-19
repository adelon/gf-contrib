concrete WordsCze of Words = SentencesCze **
  open SyntaxCze, ParadigmsCze, (L = LexiconCze), (P = ParadigmsCze) in {

-- Initial Czech coverage: food, places, actions, family and dates.
-- Unimplemented abstract functions deliberately have no linearization;
-- see README.md. Do not fill coverage gaps with English words.
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
  Church = indoors ((hradN "kostel") ** {sloc = "kostele"}) ;
  Disco = place (mkCN (zenaN "diskotéka")) on_Prep (P.mkPrep "na" accusative) ;
  Hospital = indoors (ruzeN "nemocnice") ;
  Hotel = indoors (hradN "hotel") ;
  Museum = place (mkCN (mkN "muzeum" "muzea" neuter)) (P.mkPrep "v" locative) to_Prep ;
  Park = indoors (hradN "park") ;
  Parking = place (mkCN ((moreN "parkoviště") ** {pgen = "parkovišť"})) on_Prep (P.mkPrep "na" accusative) ;
  Pharmacy = indoors (zenaN "lékárna") ;
  PostOffice = place (mkCN (zenaN "pošta")) on_Prep (P.mkPrep "na" accusative) ;
  Pub = indoors (zenaN "hospoda") ;
  Restaurant = indoors restaurant_N ;
  School = place (mkCN L.school_N) (P.mkPrep "ve" locative) to_Prep ;
  Shop = indoors ((hradN "obchod") ** {sloc = "obchodě"}) ;
  Station = place (mkCN (staveniN "nádraží")) on_Prep (P.mkPrep "na" accusative) ;
  Supermarket = indoors (hradN "supermarket") ;
  Theatre = indoors ((mestoN "divadlo") ** {sloc = "divadle" ; pgen = "divadel"}) ;
  Toilet = place (mkCN (zenaN "toaleta")) on_Prep (P.mkPrep "na" accusative) ;
  University = place (mkCN (zenaN "univerzita")) on_Prep (P.mkPrep "na" accusative) ;
  Zoo = place (mkCN (mkA "zoologický") (zenaN "zahrada")) in_Prep to_Prep ;
  CitRestaurant cit = place (mkCN cit restaurant_N) in_Prep to_Prep ;

  Euro = mkCN ((mestoN "euro") ** {pgen = "eur"}) ;
  Dollar = mkCN (hradN "dolar") ;
  Pound = mkCN (zenaN "libra") ;
  Rouble = mkCN (hradN "rubl") ;
  DanishCrown = mkCN (mkA "dánský") (zenaN "koruna") ;
  NorwegianCrown = mkCN (mkA "norský") (zenaN "koruna") ;
  SwedishCrown = mkCN (mkA "švédský") (zenaN "koruna") ;

  ByFoot = P.mkAdv "pěšky" ;
  Bike = transport (mestoN "kolo") ;
  Bus = transport (hradN "autobus") ;
  Car = transport (mestoN "auto") ;
  Ferry = transport (hradN "trajekt") ;
  Plane = transport (mestoN "letadlo") ;
  Subway = transport (mestoN "metro") ;
  Taxi = transport (mkN "taxi" "taxi" neuter) ;
  Train = transport (hradN "vlak") ;
  Tram = transport ((pisenN "tramvaj") ** {sgen,pnom,pacc = "tramvaje"}) ;

  AHasRoom p n = capacity p n room_N ;
  AHasTable p n = capacity p n ((hradN "stůl") ** {sgen = "stolu" ; sdat,sloc = "stolu" ; sins = "stolem"}) ;
  AHasName p n = mkCl (nameOf p) n ;
  AHungry p = mkCl p.name have_V2 (mkNP (hradN "hlad")) ;
  AIll p = mkCl p.name (mkA "nemocný") ;
  AKnow p = mkCl p.name (lin V L.know_VS) ;
  ALove p q = mkCl p.name L.love_V2 q.name ;
  AReady p = mkCl p.name (mkA "připravený") ;
  AScared p = mkCl p.name have_V2 (mkNP (hradN "strach")) ;
  AThirsty p = mkCl p.name have_V2 (mkNP (kostN "žízeň")) ;
  ATired p = mkCl p.name (mkA "unavený") ;
  AUnderstand p = mkCl p.name understand_V ;
  AWant p obj = mkCl p.name (mkV2 (lin V want_VV)) obj ;
  AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

  QWhatName p = mkQS (mkQCl (mkIComp whatSg_IP) (nameOf p)) ;
  HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item cost_V)) ;
  ItCost item price = mkCl item (mkV2 cost_V) price ;
  PropOpen p = mkCl p.name (mkA "otevřený") ;
  PropClosed p = mkCl p.name (mkA "zavřený") ;
  PropOpenDate p d = mkCl p.name (mkVP (mkVP (mkA "otevřený")) d) ;
  PropClosedDate p d = mkCl p.name (mkVP (mkVP (mkA "zavřený")) d) ;
  PropOpenDay p d = mkCl p.name (mkVP (mkVP (mkA "otevřený")) d.habitual) ;
  PropClosedDay p d = mkCl p.name (mkVP (mkVP (mkA "zavřený")) d.habitual) ;

  Wife = mkRelative sing (mkCN (zenaN "manželka")) ;
  Husband = mkRelative sing (mkCN L.husband_N) ;
  Son = mkRelative sing (mkCN ((panN "syn") ** {pnom = "synové"})) ;
  Daughter = mkRelative sing (mkCN ((zenaN "dcera") ** {sdat,sloc = "dceři"})) ;

  Monday = day (staveniN "pondělí") ;
  Tuesday = day (staveniN "úterý") ;
  Wednesday = day (zenaN "středa") ;
  Thursday = day (hradN "čtvrtek") ;
  Friday = day (hradN "pátek") ;
  Saturday = day (zenaN "sobota") ;
  Sunday = day (ruzeN "neděle") ;
  Tomorrow = P.mkAdv "zítra" ;

  HowFar place = mkQS (mkQCl far_IAdv place.name) ;
  HowFarFrom x y = mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxCze.mkAdv from_Prep x.name))) ;
  HowFarBy y t = mkQS (mkQCl far_IAdv (mkCl y.name t)) ;
  HowFarFromBy x y t = mkQS (mkQCl far_IAdv (mkCl y.name (mkVP (mkVP (SyntaxCze.mkAdv from_Prep x.name)) t))) ;
  WhichTranspPlace t p = mkQS (mkQCl (mkIP which_IDet t.name) (mkVP (mkVP L.go_V) p.to)) ;
  IsTranspPlace t p = mkQS (mkQCl (mkCl (mkCN t.name p.to))) ;

oper
  restaurant_N : N = ruzeN "restaurace" ;
  room_N : N = strojN "pokoj" ;
  understand_V : V = mkV "rozumět" "rozumím" "rozumíš" "rozumí" "rozumíme" "rozumíte" "rozumějí" "rozuměl" "rozuměli" "rozuměj" "rozumějme" "rozumějte" ;
  cost_V : V = mkV "stát" "stojím" "stojíš" "stojí" "stojíme" "stojíte" "stojí" "stál" "stáli" "stůj" "stůjme" "stůjte" ;
  place : CN -> Prep -> Prep -> CNPlace = mkCNPlace ;
  indoors : N -> CNPlace = \n -> place (mkCN n) in_Prep to_Prep ;
  capacity : NPPerson -> Card -> N -> Cl = \p,n,room ->
    mkCl p.name have_V2 (mkNP (mkCN (mkCN room) (SyntaxCze.mkAdv for_Prep (mkNP n (zenaN "osoba"))))) ;
  nameOf : NPPerson -> NP = \p -> (mkRelative sing (mkCN (mestoN "jméno")) p).name ;
  transport : N -> {name : CN ; by : Adv} = \n -> {
    name = mkCN n ; by = SyntaxCze.mkAdv (P.mkPrep "" instrumental) (mkNP n)
    } ;
  day : N -> NPDay = \n -> mkNPDay (mkNP n)
    (SyntaxCze.mkAdv (P.mkPrep (pre {"st" | "čt" => "ve" ; _ => "v"}) accusative) (mkNP n))
    (SyntaxCze.mkAdv (P.mkPrep (pre {"st" | "čt" => "ve" ; _ => "v"}) accusative) (mkNP aPl_Det n)) ;
  far_IAdv : IAdv = lin IAdv {s = "jak daleko"} ;
}
