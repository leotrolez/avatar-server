local config = {
  posAcademyExit = {x=511,y=348,z=8}
}

function onSay(cid, words, param, channel)
  if getPlayerInPos(cid, {x=398,y=337}, {x=359,y=321}, 9) or getPlayerInPos(cid, {x=398,y=340}, {x=360,y=320}, 8) then
    doTeleportCreature(cid, config.posAcademyExit, 10)
  else
    doPlayerSendCancel(cid, getLangString(cid, "You must be within the Academy of Ba Sing Se to use this command.", "Você precisa estar dentro da academia de Ba Sing Se para usar este comando."))
  end

  return true
end