-- (C) 2009 Aarne Ranta under LGPL

concrete WordsRus of Words = SentencesRus ** 
    open SyntaxRus, (P = ParadigmsRus), (L = LexiconRus), (E = ExtendRus), ExtraRus, Prelude in {

flags coding = utf8 ;

  lin

-- kinds of food

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN L.cheese_N ;
    Chicken = mkCN (P.mkN "курица") ;
    Coffee = mkCN (P.mkN "кофе" P.masculine P.inanimate "0") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (P.mkN "мясо") ;
    Milk = mkCN L.milk_N ; 
    Pizza = mkCN (P.mkN "пицца") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (P.mkN "чай") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties


    Bad = P.mkA "плохой" ;
    Cheap = P.mkA "дешевый" ;
    Boring = P.mkA "скучный" ;
    Cold = L.cold_A ;
    Delicious = P.mkA "вкусный" ;
    Expensive = P.mkA "дорогой" ;
    Fresh = P.mkA "свежий" ;
    Good = L.good_A ;
    Suspect = P.mkA "подозрительный" ;
    Warm = L.warm_A ;



-- places
 
    Airport = mkPlace (P.mkN "аэропорт") in_Prep to2_Prep ;
    AmusementPark = mkPlace2 "развлечения" "парк" in_Prep;
    Bank = mkPlace (P.mkN "банк") in_Prep to2_Prep ;
    Bar = mkPlace (P.mkN "бар") in_Prep to2_Prep ;
    Cafeteria = mkPlace (P.mkN "кафетерий") in_Prep to2_Prep ;
    Center = mkPlace (P.mkN "центр") in_Prep to2_Prep ;
    Church = mkPlace (P.mkN "церковь" P.feminine P.inanimate "8*e") in_Prep to2_Prep ;
    Cinema = mkPlace (P.mkN "кино" P.neuter P.inanimate "0") in_Prep to2_Prep ;
    Disco = mkPlace (P.mkN "дискотека") on_Prep on2_Prep ;
    Hospital = mkPlace (P.mkN "больница") in_Prep to2_Prep ;
    Hotel = mkPlace (P.mkN "отель") in_Prep to2_Prep ;
    Museum = mkPlace (P.mkN "музей") in_Prep to2_Prep ;
    Park = mkPlace (P.mkN "парк") in_Prep to2_Prep ;
    Parking = mkPlace (P.mkN "автостоянка") on_Prep on2_Prep ;
    Pharmacy = mkPlace (P.mkN "аптека") in_Prep to2_Prep ;
    PostOffice = mkPlace (P.mkN "почта") on_Prep on2_Prep ;
    Pub = mkPlace (P.mkN "паб") in_Prep to2_Prep ;
    Restaurant = mkPlace (P.mkN "ресторан") in_Prep to2_Prep ;
    Shop = mkPlace (P.mkN "магазин") in_Prep to2_Prep ;
    School = mkPlace (P.mkN "школа") in_Prep to2_Prep ;
    Station = mkPlace (P.mkN "станция") on_Prep on2_Prep ;
    Supermarket = mkPlace (P.mkN "супермаркет") in_Prep to2_Prep ;
    Theatre = mkPlace (P.mkN "театр") in_Prep to2_Prep ;
    Toilet = mkPlace (P.mkN "туалет") in_Prep to2_Prep ;
    University = mkPlace (P.mkN "университет") in_Prep to2_Prep ;
    Zoo = mkPlace (P.mkN "зоопарк") in_Prep to2_Prep ;

 
    CitRestaurant cit = 
      mkCNPlace (mkCN cit (P.mkN "ресторан")) in_Prep to2_Prep ;    


-- currencies

    DanishCrown = mkCN (P.mkA "датский") (P.mkN "крона") ;
    Dollar = mkCN (P.mkN "доллар") ;
    Euro = mkCN (P.mkN "евро" P.neuter P.inanimate "0") ;
    Lei = mkCN (P.mkN "лей") ;
    Leva = mkCN (P.mkN "лев" P.masculine P.inanimate "1a") ;
    NorwegianCrown = mkCN (P.mkA "норвежский") (P.mkN "крона") ;
    Pound = mkCN (P.mkN "фунт");
    Rouble = mkCN (P.mkN "рубль" P.masculine P.inanimate) ;
    SwedishCrown = mkCN (P.mkA "шведский") (P.mkN "крона") ;
    Zloty = mkCN (P.mkN (P.mkA "злотый") P.masculine P.inanimate) ;


-- Nationalities

    Bulgarian = mkNat "болгарский" (P.mkPN (P.mkN "Болгария" P.feminine P.inanimate)) ;
    Catalan = mkNat "каталонский" (P.mkPN (P.mkN "Каталония" P.feminine P.inanimate)) ;
    Danish = mkNat "датский" (P.mkPN (P.mkN "Дания" P.feminine P.inanimate)) ;
    Dutch = mkNat "нидерландский" (P.mkPN (P.mkN "Нидерланды" P.neuter P.inanimate "1a" P.only_plural)) ;
    English = mkNat "английский" (P.mkPN (P.mkN "Англия" P.feminine P.inanimate)) ;
    Finnish = mkNat "финский" (P.mkPN (P.mkN "Финляндия" P.feminine P.inanimate)) ;
    French = mkNat "французский" (P.mkPN (P.mkN "Франция" P.feminine P.inanimate)) ;
    German = mkNat "немецкий" (P.mkPN (P.mkN "Германия" P.feminine P.inanimate)) ;
    Italian = mkNat "итальянский" (P.mkPN (P.mkN "Италия" P.feminine P.inanimate)) ;
    Norwegian = mkNat "норвежский" (P.mkPN (P.mkN "Норвегия" P.feminine P.inanimate)) ;
    Polish = mkNat "польский" (P.mkPN (P.mkN "Польша" P.feminine P.inanimate)) ;
    Romanian = mkNat "румынский" (P.mkPN (P.mkN "Румыния" P.feminine P.inanimate)) ;
    Russian = mkNat "русский" (P.mkPN (P.mkN "Россия" P.feminine P.inanimate)) ;
    Spanish = mkNat "испанский" (P.mkPN (P.mkN "Испания" P.feminine P.inanimate)) ;
    Swedish = mkNat "шведский" (P.mkPN (P.mkN "Швеция" P.feminine P.inanimate)) ;


-- Means of transportation


    Bike = mkTransport L.bike_N ;
    Bus = mkTransport (P.mkN "автобус") ; 
    Car = mkTransport (P.mkN "автомобиль");
    Ferry = mkTransport (P.mkN "паром") ;
    Plane = mkTransport (P.mkN "самолет") ;
    Subway = mkTransport (P.mkN "метро" P.neuter P.inanimate "0") ;
    Taxi = mkTransport (P.mkN "такси" P.neuter P.inanimate "0") ;
    Tram = mkTransport (P.mkN "трамвай") ;
    Train = mkTransport (P.mkN "поезд") ;

    ByFoot = P.mkAdv "пешком" ;



-- actions
    AHasAge p num = mkCl (mkVP (P.mkV3 be_ell_V P.dative P.nominative)
      p.name (mkNP num L.year_N)) ;
    AHasName p name = mkCl unnamedCallers
      (mkVP (P.mkV3 name_is_V P.accusative P.nominative) p.name name) ;
    AHasChildren p num = mkCl (mkVP have_V3 (mkNP num L.child_N) p.name) ; 
    AHasRoom p num = mkCl (mkVP have2_V3 
      (mkNP (mkNP a_Det (P.mkN "номер")) 
        (SyntaxRus.mkAdv for_Prep (mkNP num (L.man_N)))) p.name) ; 
    AHasTable p num = mkCl (mkVP have2_V3 
      (mkNP (mkNP a_Det (P.mkN "стол")) 
        (SyntaxRus.mkAdv for_Prep (mkNP num (L.man_N)))) p.name) ;
    AHungry p = mkCl p.name (P.mkA "голодный" "голоднее" "1*a" P.short) ;
    AIll p = mkCl p.name (P.mkA "больной" "больнее" "1*b" P.short) ;
    AKnow p = mkCl p.name <lin V L.know_V2 : V> ;
    ALike p item = mkCl item L.like_V2 p.name ;
    ALive p co = mkCl p.name (mkVP (mkVP L.live_V) (SyntaxRus.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name L.love_V2 q.name ;
    AMarried p = case p.sex of {
      Male => mkCl p.name (P.ShortenA (P.mkA "женатый")) ;
      Female => mkAdvCl p.name (P.mkAdv "замужем") ;
      Unknown => mkAdvCl p.name (SyntaxRus.mkAdv in_Prep (mkNP (P.mkN "брак")))
      } ;
    AReady p = mkCl p.name (P.ShortenA (P.mkA "готовый")) ;
    AScared p = mkCl p.name <lin V L.fear_V2 : V> ;
    ASpeak p lang = mkCl p.name (P.mkV2
      (P.mkV P.imperfective P.intransitive "говорить" "говорю" "говорит")
      (P.mkPrep "на" P.prepositional)) lang ;
    AThirsty p = mkCl p.name want_VV (mkVP <lin V L.drink_V2 : V>) ;
    ATired p = mkCl p.name (P.ShortenA (P.mkA "усталый")) ;
    AUnderstand p = mkCl p.name <lin V L.understand_V2 : V> ;
    AWant p obj = mkCl p.name (P.mkV2 (P.mkV P.imperfective P.transitive "хотеть")) obj ;
    AWantGo p place = mkCl p.name want_VV
      (mkVP (mkVP (P.mkV P.perfective P.intransitive "пойти")) place.to) ;
    
-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv
      (mkCl unnamedCallers (P.mkV2 name_is_V P.accusative) p.name)) ;
    QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N)
      (mkVP (mkVP be_ell_V) (SyntaxRus.mkAdv to_dat_Prep p.name))) ;
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item cost_V)) ; 
    ItCost item price = mkCl item (P.mkV2 cost_V P.accusative) price ;

    PropOpen p = mkCl p.name open_A ; 
    PropClosed p = mkCl p.name closed_A ; 
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 


-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("увидимся"))) (mkPhrase (mkUtt d)) ; 
    PSeeYouPlace p = 
      mkText (lin Text (ss ("увидимся"))) (mkPhrase (mkUtt p.at)) ; 
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("увидимся"))) 
        (mkText (mkPhrase (mkUtt d)) (mkPhrase (mkUtt p.at))) ; 

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf Female sing L.wife_N ;
    Husband = xOf Male sing L.husband_N ;
    Son = xOf Male sing (P.mkN "сын" P.masculine P.animate) ;
    Daughter = xOf Female sing (P.mkN "дочь" "дочери" "дочери" "дочь" "дочерью" "дочери" "дочери" "дочери" "дочерей" "дочерям" "дочерей" "дочерьми" "дочерях" P.feminine P.animate) ;
    Children = xOf Unknown plur L.child_N ;


 
-- week days

    Monday = mkDay (P.mkN "понедельник") ;
    Tuesday = mkDay (P.mkN "вторник") ;
    Wednesday = mkDay (P.mkN "среда") ;
    Thursday = mkDay (P.mkN "четверг") ;
    Friday = mkDay (P.mkN "пятница") ;
    Saturday = mkDay (P.mkN "суббота") ;
    Sunday = mkDay (P.mkN "воскресенье") ;

  Tomorrow = P.mkAdv "завтра" ;

-- modifiers of places 
    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (P.mkA "дешевый") ;
    TheMostExpensive = mkSuperl (P.mkA "дорогой") ;
    TheMostPopular = mkSuperl (P.mkA "популярный") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;

-- transports

    HowFar place = mkQS (mkQCl far_IAdv place.name) ; 
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP y.name (SyntaxRus.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkNP (mkNP y.name (SyntaxRus.mkAdv from_Prep x.name)) t)) ;
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkNP y.name t)) ; 
 
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;




  oper
    mkNat : Str -> PN -> NPNationality = \la,co -> 
      mkNPNationality (mkNP (mkCN (P.mkA la) (P.mkN "язык"))) (mkNP co) (P.mkA la) ;

    mkDay : N -> NPDay = \d ->
      mkNPDay (mkNP d)
        (mkAdv (P.mkPrep "в" P.accusative) (mkNP d))
        (mkAdv (P.mkPrep "по" P.dative) (mkNP aPl_Det d)) ;

    mkPlace : N -> Prep -> Prep -> CNPlace = \p,i,t ->
      mkCNPlace (mkCN p) i t ;

    mkPlace2 : Str -> Str -> Prep -> {name : CN ; at : Prep ; to : Prep ; isPl : Bool} = \p,p2,i -> 
      mkCNPlace (mkCN (P.mkN2 (P.mkN p2)) (mkNP (P.mkN p))) i to2_Prep;

    open_A = P.ShortenA (P.mkA "открытый") ;
    closed_A = P.ShortenA (P.mkA "закрытый") ;

    cost_V = P.mkV P.imperfective P.transitive "стоить" "стою" "стоит" "4a" ;

    name_is_V = P.mkV P.imperfective P.transitive "звать" "зову" "зовёт" "6°b/c" ;
    -- Russian names use an indefinite personal clause: "меня зовут NN".
    unnamedCallers : NP = mkNP (E.ProDrop they_Pron) ;

    xOf : Sex -> GNumber -> N -> NPPerson -> NPPerson = \s,n,x,p ->
      relativePerson n (mkCN x)
        (\a,b,c -> mkNP (mkNP the_Quant a c) (SyntaxRus.mkAdv possess_Prep b)) p
        ** {sex = s} ;

     mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ;  
     by = SyntaxRus.mkAdv on_Prep (mkNP the_Det n)
      } ;

     far_IAdv = P.mkIAdv "как далеко" ;

     mkSuperl : A -> Det = \a -> SyntaxRus.mkDet the_Art (SyntaxRus.mkOrd a) ;

}
