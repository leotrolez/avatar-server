local function hasCreatures(pos)
local creatures = getSpectators(pos, 1, 0)
       if creatures ~= nil and #creatures > 0 then
		for i = 1, #creatures do 
		local creature = creatures[i]
		local poscr = getCreaturePosition(creature)
			if poscr.x == pos.x and poscr.y == pos.y and isPlayer(creature) and getPlayerAccess(creature) < 4 then 
 				return true
			end
		end
	end
	return false
end 

local function getFreePositions(doorPosition, id)
local centralPosition, poses = {}, {}
local one, final = -1, 1
if id == 25841 then 
	centralPosition = {x=doorPosition.x, y=doorPosition.y+2, z=doorPosition.z}
else 
	centralPosition = {x=doorPosition.x, y=doorPosition.y-2, z=doorPosition.z}
end 
	for i = one, final do 
		for j = one, final do 
		   if i ~= 0 or j ~= 0 then 
			local posTest = {x=centralPosition.x+i, y=centralPosition.y+j, z=centralPosition.z}
			if not hasCreatures(posTest) then 
				table.insert(poses, posTest)
			end 
		    end
		end 
	end
	return #poses > 0 and poses or false
end 

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	local fromPosition = (getCreaturePosition(cid))
	local toPosition = getThingPos(item.uid)
	local id = item.actionid
        if id == 25841 and fromPosition.y > toPosition.y then		
			return doTeleportThing(cid, {x=toPosition.x, y=toPosition.y-1, z=toPosition.z}) and doSendMagicEffect(getCreaturePosition(cid), 10)
		elseif id == 25842 and fromPosition.y < toPosition.y then 
			return doTeleportThing(cid, {x=toPosition.x, y=toPosition.y+1, z=toPosition.z}) and doSendMagicEffect(getCreaturePosition(cid), 10)
		else
			local freePoses = getFreePositions(toPosition, id)
			if freePoses then 
				if id == 25842 then 
					sendBlueMessage(cid, getLangString(cid, "Welcome to the training room! You can always leave using the command !leaveacademy or by clicking in the 'Leave Academy' option (can be seen in the '+' button, right upper side of your client).", "Você entrou na sala de treinamento! Você pode sempre sair utilizando o comando !leaveacademy ou clicando na opção 'Sair da Academia' no botão '+', canto superior direito do client."))
					doTeleportThing(cid, freePoses[#freePoses])
				else 
					sendBlueMessage(cid, getLangString(cid, "Welcome to the training room! You can always leave using the command !leaveacademy or by clicking in the 'Leave Academy' option (can be seen in the '+' button, right upper side of your client).", "Você entrou na sala de treinamento! Você pode sempre sair utilizando o comando !leaveacademy ou clicando na opção 'Sair da Academia' no botão '+', canto superior direito do client."))
					doTeleportThing(cid, freePoses[1])
				end
			else 
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Não há espaço vazio nesta sala para você.")
				return true
			end 
		end 
		doSendMagicEffect(getCreaturePosition(cid), 10)
	return true
end


