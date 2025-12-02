local posExit = {x=868,y=1126,z=9}

function onStepIn(cid, item, position, fromPosition)
	local fases = 0
    if isPlayer(cid) then
        doTeleportCreature(cid, posExit, 10)
        setPlayerStorageValue(cid, "poiReward"..(item.actionid-8720+1), 1)
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
		 for x = 1, 6 do
            if getPlayerStorageValue(cid, "poiReward"..x) == 1 then
              fases = fases+1
            end
        end
		if fases < 5 then 
			doPlayerSendTextMessage(cid, 22, "Você completou esta fase! Agora restam "..(6-fases).." fases para você completar.")
		elseif fases == 5 then 
			doPlayerSendTextMessage(cid, 22, "Você completou esta fase! Agora resta apenas 1 fase para você completar.")
		else 
			doPlayerSendTextMessage(cid, 22, "Parabéns, você completou a Survival Quest! Siga para o norte e entre na sala das recompensas.")
		end 
    end

  return true
end
