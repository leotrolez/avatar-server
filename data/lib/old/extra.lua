paragonRewards = 
{
	[5] = {reward = "bend", values = {1}},
	[10] = {reward = "health", values = {100, 40}},
	[15] = {reward = "speed", values = {20}},
	[20] = {reward = "text", values = {"Trade items with Mithlock and Kurt will give you 20% more gold for each.", "Negociar itens com os NPCs Mithlock e Kurt dará 20% a mais de dinheiro por item."}},
	[25] = {reward = "itemElement", values = {18104, 18105, 18106, 18107, 2}},
	[30] = {reward = "points", values = {2}},
	[35] = {reward = "itemElement", values = {12686, 12688, 12689, 12687, 1}},
	[40] = {reward = "health", values = {200, 80}},
	[45] = {reward = "speed", values = {40}},
	[50] = {reward = "text", values = {"Buying items from Edward Colin, Hugo and Borkas will be 20% more cheap.", "20% de desconto ao comprar itens com os NPCs Edward Colin, Hugo e Borkas."}},
	[60] = {reward = "points", values = {4}},
	[70] = {reward = "item", values = {12754, 2}},
	[80] = {reward = "itemElement", values = {18109, 18110, 18111, 18112, 2}},
	[90] = {reward = "health", values = {300, 140}},
	[100] = {reward = "bend", values = {2}},
	[120] = {reward = "item", values = {11259, 25}},
	[140] = {reward = "text", values = {"30 minutes cooldown reduction in the Passive Resurrectione. ", "Redução de 30 minutos no cooldown da Passiva de Ressurreição."}},
	[160] = {reward = "itemElement", values = {12686, 12688, 12689, 12687, 2}},
	[180] = {reward = "itemElement", values = {18130, 18131, 18132, 18133, 2}},
	[200] = {reward = "bend", values = {3}},
	[220] = {reward = "speed", values = {80}},
	[250] = {reward = "health", values = {500, 200}},
	[300] = {reward = "points", values = {8}},
	[350] = {reward = "bend", values = {5}},
	[450] = {reward = "itemElement", values = {12686, 12688, 12689, 12687, 7}},
	[500] = {reward = "item", values = {11259, 75}},
	[750] = {reward = "text", values = {"15% damage increase on all bends.", "Aumento de 15% no dano causado de todas as dobras."}},
}

function onUpgradeParagon(cid, newParagon)
	if paragonRewards[newParagon] then
		local paragon = paragonRewards[newParagon]
		if paragon.reward == "bend" then
			doPlayerAddMagicLevel(cid, paragon.values[1])
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Paragon " .. newParagon .. " reward: +"..paragon.values[1].." Bend Level.")
		elseif paragon.reward == "health" then
			setCreatureMaxMana(cid, getCreatureMaxMana(cid, true)+paragon.values[2])     
			setCreatureMaxHealth(cid, getCreatureMaxHealth(cid, true)+paragon.values[1])
			doCreatureAddHealth(cid, 1)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Paragon " .. newParagon .. " reward: +"..paragon.values[1].." Max Health, +"..paragon.values[2].." Max Mana.")
		elseif paragon.reward == "speed" then
			doChangeSpeed(cid, paragon.values[1])
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Paragon " .. newParagon .. " reward: +"..paragon.values[1].." Speed.")
		elseif paragon.reward == "points" then
			local pendentes = getPlayerStorageValue(cid, "AttributesPoints")+paragon.values[1]
			setPlayerStorageValue(cid, "AttributesPoints", pendentes)
			doSendPlayerExtendedOpcode(cid, 41, pendentes)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Paragon " .. newParagon .. " reward: +"..paragon.values[1].." Elemental Points.")
		elseif paragon.reward == "text" then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Paragon " .. newParagon .. " reward: " .. getLangString(cid, paragon.values[1], paragon.values[2]))
		elseif paragon.reward == "itemElement" then
			doPlayerAddItem(cid, paragon.values[getPlayerVocation(cid)], paragon.values[5])
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Paragon " .. newParagon .. " reward: " .. paragon.values[5] .. "x "..getItemNameById(paragon.values[getPlayerVocation(cid)])..".")
		elseif paragon.reward == "item" then
			if #paragon.values >= 4 then
				doPlayerAddItem(cid, paragon.values[1], paragon.values[2])
				doPlayerAddItem(cid, paragon.values[3], paragon.values[4])
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Paragon " .. newParagon .. " reward: " .. paragon.values[2] .. "x "..getItemNameById(paragon.values[1])..", " .. paragon.values[4] .. "x "..getItemNameById(paragon.values[3])..".")
			else
				doPlayerAddItem(cid, paragon.values[1], paragon.values[2])
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Paragon " .. newParagon .. " reward: " .. paragon.values[2] .. "x "..getItemNameById(paragon.values[1])..".")
			end
		end
		return true
	end
end

function getParagonExtraSpeed(cid)
	local bonusSpeed = 0
	local levelBonuses = {15, 45, 220}
	local paragonToSpeed = {20, 40, 80}
	local resets = getPlayerResets(cid)
	for i = 1, #levelBonuses do
		if resets >= levelBonuses[i] then
			bonusSpeed = bonusSpeed + paragonToSpeed[i]
		else
			break
		end
	end
	return bonusSpeed
end

function getParagonExtraHp(cid)
	local bonusHealth = 0
	local levelBonuses = {10, 40, 90, 250}
	local paragonToHealth = {100, 200, 300, 500}
	local resets = getPlayerResets(cid)
	for i = 1, #levelBonuses do
		if resets >= levelBonuses[i] then
			bonusHealth = bonusHealth + paragonToHealth[i]
		else
			break
		end
	end
	return bonusHealth
end

function getParagonExtraMana(cid)
	local bonusMana = 0
	local levelBonuses = {10, 40, 90, 250}
	local paragonToMana = {40, 80, 140, 200}
	local resets = getPlayerResets(cid)
	for i = 1, #levelBonuses do
		if resets >= levelBonuses[i] then
			bonusMana = bonusMana + paragonToMana[i]
		else
			break
		end
	end
	return bonusMana
end

function getParagonExtraBend(cid)
	local bonusBend = 0
	local levelBonuses = {5, 100, 200, 350}
	local paragonToBend = {1, 2, 3, 5}
	local resets = getPlayerResets(cid)
	for i = 1, #levelBonuses do
		if resets >= levelBonuses[i] then
			bonusBend = bonusBend + paragonToBend[i]
		else
			break
		end
	end
	return bonusBend
end

function getParagonExtraPoints(cid)
	local bonusPoints = 0
	local levelBonuses = {30, 60, 300}
	local paragonToPoints = {2, 4, 8}
	local resets = getPlayerResets(cid)
	for i = 1, #levelBonuses do
		if resets >= levelBonuses[i] then
			bonusPoints = bonusPoints + paragonToPoints[i]
		else
			break
		end
	end
	return bonusPoints
end

function getPlayerCoins(cid)
	if not isPlayer(cid) then return 0 end 

	local resultId = db.storeQuery("SELECT `premium_points` FROM `accounts` WHERE `id` = "..getPlayerAccountId(cid)..";")
	if resultId ~= false then
		local ret = result.getNumber(resultId, "premium_points")
		result.free(resultId)
		return ret
	end

	return 0
end

function doSlow(cid, target, value, time, effect)
 local speed = getCreatureSpeed(target)
 if speed < 30 then
  return true
 end
 local newspeed = speed*(1-(value/100))
 if newspeed < 30 then 
  return true
 end
 local perdida = speed - newspeed
 doChangeSpeed(target, -perdida)     
 if effect then 
  local targpos = getThingPos(target)
  doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, effect)
 end 
 addEvent(function()
                if isCreature(target) then
                    doChangeSpeed(target, perdida)
                end
            end, time)
return true
end

function isInPz(cid)
	local pos = getCreaturePosition(cid)
return getTileInfo(pos).protection
end

function getAtributosString(cid)
local atributosList = {"health", "bend", "speed", "dodge"}
local pendentes = getPlayerStorageValue(cid, "AttributesPoints")
local string = pendentes.. ", 0"
	for i = 1, #atributosList do
		local storageAtributo = atributosList[i] .. "value"
		local valor = getPlayerStorageValue(cid, storageAtributo)
		valor = valor ~= -1 and valor or 0
		string = string.. ", "..valor..""
		string = string.. ", "..getCostByValue(valor, atributosList[i])..""
	end
	return string
end

function getCostByValue(value, att)
	if not tonumber(value) then 
		print("[Alerta] getCostByValue retornando 99 em algum caso errado")
		return 99
	end
	if att == "health" or att == "speed" then 
		if value <= 15 then
			return 1
		elseif value <= 25 then
			return 2
		elseif value <= 40 then
			return 3
		elseif value <= 50 then
			return 4
		elseif value <= 85 then
			return 5
		else
			return 8
		end
	elseif att == "bend" then 
	    if value >= 0 and value <= 19 then
			return 1
		elseif value >= 20 and value <= 29 then
			return 2
		elseif value >= 30 and value <= 49 then
			return 4
		elseif value >= 50 and value <= 59 then
			return 7
		elseif value >= 60 and value <= 69 then
			return 10
		elseif value >= 70 then
			return 15
		end
	elseif att == "dodge" then 
		value = value+1
		local dodgeValues = {1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 10}
		if value >= 0 and value <= 15 then
			return dodgeValues[value]
		else
			return 99
		end
	end 
		print("[Alerta] getCostByValue retornando 99 em algum caso errado")
	return 99
end 

function adjustDirection(dir)
local finaldir = dir-1
if finaldir == -1 then 
return 3
elseif finaldir == 4 then 
return 0
end 
return finaldir
end 
function returnPositionByCoord(pos, linha, coluna, dir)
return getPosByDir(getPosByDir(pos, dir, 6-linha), adjustDirection(dir), 6-coluna)
end
function changeOrNot(change, value, compr)
if change then 
return (compr-value)
end
return 0
end
function getPositionsByTable(pos, tabela, dir, compr, tabelas)
	local poses = {}
	for i = 1, tabelas do
	table.insert(poses, {})
	end
	local linhas = #tabela
	local changelinhas, changecolunas = false, false
	if linhas <= compr then 
		changelinhas = true 
	end 

	for i = 1, linhas do 
		local colunas = #tabela[i]
		if colunas <= compr then 
			changecolunas = true 
		end 
		for j = 1, colunas do
			if tabela[i][j] > 0 then 
				local posf = returnPositionByCoord({x=pos.x, y=pos.y, z=pos.z}, i+(changeOrNot(changelinhas, linhas, compr)), j+(changeOrNot(changecolunas, colunas, compr)), dir)
				table.insert(poses[tabela[i][j]], posf)
			end 
		end
	end
	return poses
end

function getRealMaxHp(cid)
local base = 110
local fromLevel = getPlayerLevel(cid)*30
local vitality = getPlayerStorageValue(cid, "healthvalue")
if vitality <= 0 then vitality = 0 end
local fromVit = vitality*50
local fromCrystal = getPlayerStorageValue(cid, "pointsUsedInLifeCrystal")
if fromCrystal <= 0 then 
	fromCrystal = 0
end

return base + fromLevel + fromVit + fromCrystal + getParagonExtraHp(cid)
end

function getRealMaxMana(cid)
local base = 95
local fromLevel = getPlayerLevel(cid)*5
local vitality = getPlayerStorageValue(cid, "speedvalue")
if vitality <= 0 then vitality = 0 end
local fromVit = vitality*20

return base + fromLevel + fromVit + getParagonExtraMana(cid)
end