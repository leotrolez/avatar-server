function aisNonPvp(cid)
return getPlayerLevel(cid) < 50
end 

function aisInPz(cid)
local tileInfo = getTileInfo(getCreaturePosition(cid))
if tileInfo.protection or tileInfo.hardcore or tileInfo.optional then
	return true
end
return false
end 

function aisGM(cid)
return getPlayerGroupId(cid) >= 3
end 

function searchAvatar()
local avatar = 0
local possiveisNovos = {}
local possiveisOlds = {}

	for _, pid in ipairs(getPlayersOnline()) do
		if not aisGM(pid) and not aisNonPvp(pid) and not aisInPz(pid) and getPlayerStorageValue(pid, "isAvatar") ~= 1 then
			table.insert(possiveisOlds, pid)
			if getPlayerStorageValue(pid, "isAvatar") == -1 then
				table.insert(possiveisNovos, pid)
			end
		end
	end
	if possiveisNovos and #possiveisNovos > 0 then
		avatar = possiveisNovos[math.random(1, #possiveisNovos)]
	elseif possiveisOlds and #possiveisOlds > 0 then
		avatar = possiveisOlds[math.random(1, #possiveisOlds)]
	end
return avatar
end

function randomizeNewAvatar()
	local avatar = searchAvatar()
	if avatar ~= 0 then
		doBroadcastMessage("O dobrador "..getCreatureName(avatar).." é o novo Avatar escolhido.", MESSAGE_STATUS_CONSOLE_BLUE)
		setPlayerStorageValue(avatar, "isAvatar", 1)
		local oldAvatar = 0
		if getStorage(73991) > 0 then
			oldAvatar = getPlayerByNameWildcard(getPlayerNameByGUID(getStorage(73991)))
		end
		doSetStorage(73991, getPlayerGUIDByName(getCreatureName(avatar)))
		if oldAvatar and oldAvatar > 0 and isCreature(oldAvatar) then
			setPlayerStorageValue(oldAvatar, "isAvatar", 0)
		end
		local avatarPos = getCreaturePosition(avatar)
		doSendMagicEffect({x=avatarPos.x+1, y=avatarPos.y+1, z=avatarPos.z}, 134)
		doSendMagicEffect({x=avatarPos.x+1, y=avatarPos.y+1, z=avatarPos.z}, 135)
		doSendMagicEffect({x=avatarPos.x+1, y=avatarPos.y+1, z=avatarPos.z}, 121)
	end
return TRUE
end

function makeNewAvatar(avatar)
	if avatar ~= 0 then
		doBroadcastMessage("O dobrador "..getCreatureName(avatar).." é o novo Avatar escolhido.", MESSAGE_STATUS_CONSOLE_BLUE)
		setPlayerStorageValue(avatar, "isAvatar", 1)
		local oldAvatar = 0
		if getStorage(73991) > 0 then
			oldAvatar = getPlayerByNameWildcard(getPlayerNameByGUID(getStorage(73991)))
		end
		doSetStorage(73991, getPlayerGUIDByName(getCreatureName(avatar)))
		if oldAvatar and oldAvatar > 0 and isCreature(oldAvatar) then
			setPlayerStorageValue(oldAvatar, "isAvatar", 0)
		end
		local avatarPos = getCreaturePosition(avatar)
		doSendMagicEffect({x=avatarPos.x+1, y=avatarPos.y+1, z=avatarPos.z}, 134)
		doSendMagicEffect({x=avatarPos.x+1, y=avatarPos.y+1, z=avatarPos.z}, 135)
		doSendMagicEffect({x=avatarPos.x+1, y=avatarPos.y+1, z=avatarPos.z}, 121)
	end
return TRUE
end

function remakeAirEarth(cid, value)
	if cid and isCreature(cid) and getPlayerResets(cid) >= 750 then
		value = value * 1.15
	end
	return value
end

function remakeValue(vocation, value, cid)
	if cid and isCreature(cid) and getPlayerResets(cid) >= 750 then
		value = value * 1.15
	end
	if cid and isCreature(cid) and type(getPlayerStorageValue(cid, "jumpdebuff")) == "number" and exhaustion.check(cid, "jumpdebuff") and type(getPlayerStorageValue(cid, "debuffValue")) == "number" and getPlayerStorageValue(cid, "debuffValue") > 0 then
		value = value*((100-getPlayerStorageValue(cid, "debuffValue"))*0.01)
	end
	local orbita = getStorage(57302)
	if orbita == 1 and vocation == 1 then
		value = value * 1.2
	elseif orbita == 2 and vocation == 2 then
		value = value * 1.2
	elseif orbita == 3 then
		value = value * 0.8
	end
	if getPlayerStorageValue(cid, "90526i1") == 1 then
		value = value * 1.05
	end
	if (getCreatureSkullType(cid) == SKULL_RED) then
		value = value/4
	end
	return value
end

function tryEclipse()
	-- aqui se encerra o passado e nao rola um novo no caso
	if getStorage(57302) > 0 then
		local ultimo = getStorage(57302)
		doSetStorage(57302, 0)
		if ultimo == 1 then
			doBroadcastMessage("O Cometa de Sozin não está mais afetando o mundo Avatar, os dobradores de Fogo não estão mais fortificados.", 22)
		elseif ultimo == 2 then
			doBroadcastMessage("A Lua Cheia se despede do mundo Avatar, os dobradores de Água não estão mais fortificados.", 22)
		else
			doBroadcastMessage("O Eclipse Lunar terminou, os dobradores de Água e Fogo não estão mais enfraquecidos.", 22)
		end
		return false
	end
	
	-- aqui antes fica o test de 10 porcento
	if getStorage(56304) ~= 1 and math.random(1, 100) <= 75 then
		return false
	end
	doSetStorage(56304, 0)

	local proximo = getStorage(57301)
	if proximo < 2 then
		proximo = 2
	end
	proximo = proximo + 1
	doSetStorage(57301, proximo)
	if proximo % 3 == 2 then
		-- eclipse
		doBroadcastMessage("O mundo Avatar está sob Eclipse Lunar, todos os dobradores de Água e Fogo estão enfraquecidos com 20% menos de dano em suas dobras nas próximas 4 horas.", 22)
		doSetStorage(57302, 3)
	elseif proximo % 3 == 1 then
		-- lua
		doBroadcastMessage("A Lua Cheia chegou no mundo Avatar, todos os dobradores de Água estão fortificados com 20% de dano extra em suas dobras nas próximas 4 horas.", 22)
		doSetStorage(57302, 2)
	else
		-- cometa
		doBroadcastMessage("O Cometa de Sozin está passando próximo ao mundo Avatar, todos os dobradores de Fogo estão fortificados com 20% de dano extra em suas dobras nas próximas 4 horas.", 22)
		doSetStorage(57302, 1)
	end
end