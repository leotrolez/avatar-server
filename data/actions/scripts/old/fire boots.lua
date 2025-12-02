local function isSamePos(pos1, pos2)
return pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z
end 

local function isPz(pos)
return getTileInfo(pos).protection
end 

local function explodesPos(cid, pos)
	if not isCreature(cid) or isPz(getCreaturePosition(cid)) then return false end
	local min = getPlayerLevel(cid) + getPlayerMagLevel(cid)
	doAreaCombatHealth(cid, COMBAT_FIREDAMAGE, pos, {{3}}, -min*0.4, -min*0.8, 15)
end 

local function flamingPath(cid, lastPosition, timeEnd, fireBoots)
	if os.time() > timeEnd then 
		return false
	end 
	if not isCreature(cid) or getPlayerSlotItem(cid, 8).actionid ~= fireBoots then 
		return false 
	end
	local myPos = getCreaturePosition(cid)
	if not isSamePos(myPos, lastPosition) and not isPz(myPos) and not isPz(lastPosition) then 
		for i = 0, 2 do 
			addEvent(explodesPos, 500*i, cid, lastPosition)
		end 
	end 
	addEvent(flamingPath, 100, cid, myPos, timeEnd, fireBoots)
end 

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.actionid >= 0 and item.actionid > os.time() then 
		local restante = getSecsString(item.actionid-os.time()) 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Esta fire boots ainda está recarregando por "..restante..".")
		return true
	elseif getPlayerSlotItem(cid, 8).uid ~= item.uid then 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa estar com a fire boots equipada para ativar sua habilidade.")
		return true
	elseif getTileInfo(getCreaturePosition(cid)).protection then 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa sair da zona de proteção para ativar a habilidade da fire boots.")
		return true
	end 
	doSendMagicEffect(getCreaturePosition(cid), 36)
	doCreatureSay(cid, "Fire Boots - Flaming Path", TALKTYPE_ORANGE_1)
	doSetItemActionId(item.uid, os.time()+20*60)
	flamingPath(cid, getCreaturePosition(cid), os.time()+120, os.time()+20*60)
  return true
end
