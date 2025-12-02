local theFoods = {2328, 2787, 2362, 2666, 2667, 2668, 2669, 2670, 2671, 2672, 2673, 2674, 2675, 2676, 2677, 2678, 2679, 2680, 2681, 2682, 2683, 2684, 2685, 2686, 2687, 2688, 2689, 2690, 2691, 2692, 2693, 2694, 2695, 2696, 5097, 5678, 6125, 6278, 
2679, 6393, 6394, 6501, 6541, 6542, 6543, 6544, 6545, 6569, 6574, 7158, 7159, 7245, 7372, 7373, 7374, 7375, 7376, 7377, 7909, 7963, 8838, 8839, 8840, 8841, 8842, 8843, 8844, 8845, 8847, 9005, 9114, 10454, 11246, 11429, 12415, 12416, 12417, 12418, 12637, 12639}

table.find = function (table, value)
	for i, v in pairs(table) do
		if(v == value) then
			return i
		end
	end

	return nil
end

table.serialize = function(x, recur)
	local t = type(x)
	recur = recur or {}

	if(t == nil) then
		return "nil"
	elseif(t == "string") then
		return string.format("%q", x)
	elseif(t == "number") then
		return tostring(x)
	elseif(t == "boolean") then
		return t and "true" or "false"
	elseif(getmetatable(x)) then
		error("Can not serialize a table that has a metatable associated with it.")
	elseif(t == "table") then
		if(table.find(recur, x)) then
			error("Can not serialize recursive tables.")
		end
		table.insert(recur, x)

		local s = "{"
		for k, v in pairs(x) do
			s = s .. "[" .. table.serialize(k, recur) .. "]"
			s = s .. " = " .. table.serialize(v, recur) .. ","
		end
		s = s .. "}"
		return s
	else
		error("Can not serialize value of type '" .. t .. "'.")
	end
end

function transformGolds(cid) -- change golds
	local gold = getPlayerMoney(cid)
	if doPlayerRemoveMoney(cid, gold) then
		doPlayerAddMoney(cid, gold)
	end
end

function autoLootContainer(cid, container)
	local looted = false
	local golded = false
	local toRemove = {}
    local sendLootScreen = {}
	for x=0, (getContainerSize(container.uid)) do
		local candidato = getContainerItem(container.uid, x)
		
		if candidato.itemid == 1987 then
			autoLootContainer(cid, candidato)
		elseif not isInArray(theFoods, candidato.itemid) or getPlayerFood(cid) == 0 then
			if candidato.itemid > 0 and doPlayerAddItem(cid, candidato.itemid, candidato.type, false) then
				table.insert(toRemove, candidato.uid)
				sendLootScreen[getItemDescriptions(candidato.itemid).name] = {
					itemId = getItemDescriptions(candidato.itemid).clientId,
					count  = candidato.type
				}
				looted = true
				if candidato.itemid == 2148 or candidato.itemid == 2152 then
					golded = true
				end
			end
		end
	end
	if #toRemove > 0 then
		for i = 1, #toRemove do
			doRemoveItem(toRemove[i])
		end
	end
	if golded then
		transformGolds(cid)
	end
	if looted then
	    doSendPlayerExtendedOpcode(cid, 158, table.serialize(sendLootScreen))
		return true
	end
	return false
end

function onUse(cid, item)
	if not getContainerSize(item.uid) then
		return false
	end
	local corpseOwner = getItemAttribute(item.uid, "corpseowner")
	if corpseOwner and not canOpenCorpse(cid, corpseOwner) then -- checar se buga caso o owner nao esteja logado ou nao exista (testar dando /kick apos matar e matando com atacante 0 /lua)
		doPlayerSendCancel(cid, "You're not the owner.")
		return true
	end
	doSetItemActionId(item.uid, 0)
	if getPlayerStorageValue(cid, "autolootdesativo") == 1 then
		return false
	end
	local looted = autoLootContainer(cid, item)
	if looted then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, getLangString(cid, "You looted some items.", "Você coletou alguns itens."))
		return true
	else
		return false
	end
end