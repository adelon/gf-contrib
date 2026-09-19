-- The bilingual phrasebook's discourse model, independent of RGL agreement.
resource PhrasebookReferents = open Prelude in {
param
  Referent = Speaker | Addressee | MaleThird | FemaleThird |
    SpeakerGroup | AddresseeGroup | ThirdMaleGroup | ThirdFemaleGroup | Unresolved ;
oper
  sameReferent : Referent -> Referent -> Bool = \a,b -> case <a,b> of {
    <Speaker,Speaker> | <Addressee,Addressee> | <MaleThird,MaleThird> |
    <FemaleThird,FemaleThird> | <SpeakerGroup,SpeakerGroup> |
    <AddresseeGroup,AddresseeGroup> |
    <ThirdMaleGroup,ThirdMaleGroup> | <ThirdFemaleGroup,ThirdFemaleGroup> => True ;
    _ => False
    } ;
}
