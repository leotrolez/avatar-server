--------- FUNCTIONS ------------
local function onAddAtributo(cid, atributo, quantia)
	if atributo == "health" then                     
		setCreatureMaxHealth(cid, getCreatureMaxHealth(cid, true)+(50*quantia))
        doCreatureAddHealth(cid, 1)
	elseif atributo == "bend" then 
        doPlayerAddMagicLevel(cid, quantia)
	elseif atributo == "dodge" then 
		local oldDodge = getPlayerStorageValue(cid, "AttributesPointsInDodge")
		if oldDodge < 1 then 
			oldDodge = 0
		end 
		setPlayerStorageValue(cid, "AttributesPointsInDodge", oldDodge+quantia)
		doChangeSpeed(cid, 6*quantia)
	elseif atributo == "speed" then 
		--doChangeSpeed(cid, 2*quantia)
	end 

end
local function getAgility(cid)
return getPlayerStorageValue(cid, "AttributesPointsInDodge")
end 
local function getVitality(cid)
return getPlayerStorageValue(cid, "healthvalue")
end 
local function getManality(cid)
return getPlayerStorageValue(cid, "speedvalue")
end 
function resetAtributos(cid)
	if getAgility(cid) > 0 then 
		doChangeSpeed(cid, -(6*(getAgility(cid))))
	end
	if getVitality(cid) > 1 then 
		local novaHealth = getCreatureMaxHealth(cid, true)-(50*(getVitality(cid)))
		local myHealth = getCreatureHealth(cid)
		if myHealth > novaHealth then 
			doCreatureAddHealth(cid, -(myHealth - novaHealth))
		elseif myHealth > 4 then
			doCreatureAddHealth(cid, -1) 
		else 
			doCreatureAddHealth(cid, 1) 
		end 
		setCreatureMaxHealth(cid, novaHealth)
	end 
	if getManality(cid) > 1 then 
		local novaMana = getCreatureMaxMana(cid, true)-(20*(getManality(cid)))
		local myMana = getCreatureMana(cid)
		if myMana > novaMana then 
			doCreatureAddMana(cid, -(myMana - novaMana))
		elseif myMana > 4 then
			doCreatureAddMana(cid, -1) 
		else 
			doCreatureAddMana(cid, 1) 
		end 
		setCreatureMaxMana(cid, novaMana)
	end 
	local atributosList = {"speed", "health", "bend", "dodge"}
	for i = 1, #atributosList do 
		local storageAtributo = atributosList[i] .. "value"
		setPlayerStorageValue(cid, storageAtributo, 0)
	end 
		setPlayerStorageValue(cid, "AttributesPointsInDodge", 0)
		local lastLevel = getPlayerStorageValue(cid, 188100)
		lastLevel = lastLevel > 0 and lastLevel or 1
		setPlayerStorageValue(cid, "AttributesPoints", lastLevel+4+getParagonExtraPoints(cid))
		--doSendPlayerExtendedOpcode(cid, 40, getAtributosString(cid))
		--exhaustion.set(cid, "lastReset", (60*60)*24)
		--doSendMagicEffect(getCreaturePosition(cid), 29)
		--doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Seus atributos foram resetados.")
		doPlayerResetMagicLevel(cid)
return true
end 

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if not getTileInfo(getCreaturePosition(cid)).protection then 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "É necessário estar em uma zona protegida (PZ) para resetar seus atributos.")
		return false 
	end 
	if getPlayerStorageValue(cid, "ativoBot") == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você precisa responder ao Anti-Bot primeiro.")
		return false 
	end
    doRemoveItem(item.uid, 1)
	resetAtributos(cid)
  return true
end
