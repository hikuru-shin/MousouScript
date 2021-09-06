function eliminateFN(){
  if(enatlation == 1){
    if(skillgageEliminate==0){
      enatlation = 0;
    }
    if(skillgageEliminate>0 && time%2 == 0){
    skillgageEliminate--;
    }
  }
  skillTimeEnalationOrigin++;
  //console.log(skillTimeEnalation + " " + skillTimeEnalationOrigin);
  if(skillTimeEnalation == skillTimeEnalationOrigin){
    //enatlation =0;
    isEnatlation = true;
  }
}
