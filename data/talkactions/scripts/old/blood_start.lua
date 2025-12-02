function onSay(cid, words, param, channel)
  local plural = bloodconfig.tempoTP == 1 and "minuto" or "minutos"
  local plurals = bloodconfig.tempoAberto == 1 and "minuto" or "minutos"
  doBroadcastMessage("[Blood Castle] O NPC Rob vem vindo do Blood Castle e irá aparecer no depot em " .. bloodconfig.tempoTP .. " " .. plural .. ", não percam!")
  addEvent(createTeleportb, bloodconfig.tempoTP*60*1000)
  addEvent(doBroadcastMessage, bloodconfig.tempoTP*60*1000, "[Blood Castle] O NPC Rob chegou no depot e o evento começará em 10 minutos. Se apressem!")
  addEvent(removeTpb, bloodconfig.tempoTP+bloodconfig.tempoAberto*60*1000)
  addEvent(checkBlood, bloodconfig.tempoTP+bloodconfig.tempoAberto*60*1000+60*1000)
  addEvent(Guarantee, bloodconfig.tempoMaximo*60*1000+15000)
  return true
end