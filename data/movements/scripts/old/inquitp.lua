function onStepIn(cid, item, position, fromPosition)

local sto = Ahu -- storage vip aqui.

 if isPlayer(cid) then
   if getPlayerStorageValue(cid, sto) >= 2 then
     doTeleportThing(cid, position, true)
       else
         doTeleportThing(cid, fromPosition, true)
       doSendMagicEffect(getThingPos(cid), 11)
      doPlayerSendTextMessage(cid, 25, "Você não tem permissão para entrar aqui! Fale com o protetor Tunico.")
   end
 end
 
return true
end