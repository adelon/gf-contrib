concrete SentencesCze of Sentences = NumeralCze ** SentencesI 
   - [AKnowSentence, AKnowQuestion, AKnowPerson, 
      MMust, MKnow, MWant, 
      PNo, PYes, PYesToNo,
      VEat, VPlay, VDrink, VWait, VRun, VRead, VSit, VSleep, VStop, VSwim, VWalk, VWrite,
      V2Drink, V2Eat, V2Wait,
      Today, Too, Very] 
  with 
    (Syntax = SyntaxCze),
    (Symbolic = SymbolicCze),
    (Lexicon = LexiconCze) 
  ** open 
    (W=WordNetCze),
    ParadigmsCze,
    SyntaxCze 
  in {

  lin
    MWant = W.want_VV ;
    MKnow = W.can_1_VV ;
    MMust = W.must_1_VV ;

    AKnowSentence p s = mkCl p.name W.know_1_VS s ;
    AKnowQuestion p s = mkCl p.name W.know_1_VQ <s : QS> ;
    AKnowPerson p q = mkCl <p.name : NP> <W.know_1_V2 : V2> <q.name : NP> ;

    PYes = mkPhrase W.yes_Interj ;
    PNo = mkPhrase W.no_Interj ;
    PYesToNo = mkPhrase W.yes_Interj ;

    VEat = mkVP <lin V W.eat_1_V2 : V> ; 
    VPlay = mkVP W.play_1_V ;
    VDrink = mkVP <lin V W.drink_1_V2 : V> ;
    VSit = mkVP W.sit_1_V ; 
    VSleep = mkVP W.sleep_1_V ; 
    VStop = mkVP W.stop_1_V ; 
    VSwim = mkVP W.swim_1_V ; 
    VRun = mkVP W.run_1_V ; 
    VWalk = mkVP W.walk_1_V ; 
    VRead = mkVP W.read_1_V ; 
    VWrite = mkVP W.write_2_V ; 
    VWait = mkVP <lin V W.wait_2_V2 : V> ; 

    V2Drink o = mkVP W.drink_1_V2 o ;
    V2Eat o = mkVP W.eat_1_V2 o ;
    V2Wait o = mkVP W.wait_2_V2 o.name ;

    Today = W.today_1_Adv ;
    Very property = mkAP W.very_AdA (mkAP property) ;
    Too property = mkAP W.too_AdA (mkAP property) ;

  } ;
