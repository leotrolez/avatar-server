function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function getOutfitOtclient(outfit)
  return {
    type = outfit.lookType,
    feet = outfit.lookFeet,
    addons = outfit.lookAddons,
    legs = outfit.lookLegs,
    auxType = outfit.lookTypeEx,
    head = outfit.lookHead,
    body = outfit.Body
  }
end

local LootOpcode = 163
local forbiddenNames = {"Draptor", "Tyrn", "Devil Skeleton", "Kraken", "Death Wing", "The Duke Of The Depths", "Mouth of Hell", "Marsh Prince", "Machine King", "Arachnophobica", "Tannyl", "Olaf", "Evil Zuko", "Demmorlim", "Flaming Rarod", "Energy Rarod", "Brown Rarod", "Swamp Rarod", "Frozen Rarod", "Spider Queen", "Kelpie", "Gaz'Haragoth", "Hellflayer", "Zorvorax", "Seacrest Serpent", "Devovorga", "Skullfrost", "Moohtant", "King Scorpianus", "Jaul", "Evil Avatar", "Lost Avatar", "Demodras", "The Imperor", "The Plasmother", "Dracola", "Massacre", "Mr. Punish", "The Handmaiden", "Bretzecutioner", "Medreth", "Bulmohr", "Grudgan", "The Baron From Below", "Retching Horror", "Dragonking Zyrtarch", "Sandking", "Kollos", "Abyssador", "Lava Golem", "Blood Knight", "Mad Mage", "Ethern", "Spark Of Destruction", "Beelzeboss", "Target"}

function onSay(cid, words, param, channel)
  if param == nil or param == "" or param == " " then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, getLangString(cid, "Incorrect  parameter. Type !loot MonsterName", "Parâmetro incorreto. Digite !loot NomeDoMonstro"))
	return true 
  end 
  
  local monster = getMonsterInfo(param)
  
  if ( not monster ) then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, param .. getLangString(cid, " does not exist.", " não existe."))
	return true
  end
  
  if isInArray(forbiddenNames, param) then
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, monster.name .. getLangString(cid, " information is locked.", " não pode ser listado."))
	return true
  end
  
  if ( not monster.loot ) then
    monster.loot = getMonsterLootList(param)
  end
  
  local count 		  = 0
  local auxLoot       = {}
  local monsterLoots  = {}
  monsterLoots.loot   = {}
  monsterLoots.name   = monster.name
  monsterLoots.outfit = getOutfitOtclient(getCreatureOutfit(getCreatureByName(monster.name)))
  
  for _, item in pairs(monster.loot) do
    count = count+1
	auxLoot[count] = item
	if item.child then
	  for _, item in pairs(item.child) do
	    count = count+1
		auxLoot[count] = item
	  end
	end
  end
  
  for _, item in spairs(auxLoot, function(t,a,b) return t[b].chance < t[a].chance end) do
    local itemName = getItemNameById(item.id)
	if ( itemName ~= "bag" ) then
	  local rarityName = '-'

      if item.chance and item.chance < 2001 then
	    rarityName = getLangString(cid, "uncommon", "incomum")
	    if item.chance <= 50 then
		  rarityName = getLangString(cid, "very rare", "muito raro")
		elseif item.chance <= 200 then
		  rarityName = getLangString(cid, "rare", "raro")
		elseif item.chance <= 500 then
		  rarityName = getLangString(cid, "semi rare", "semi raro")
		end
	  elseif item.chance and item.chance >= 100000 then
	    rarityName = getLangString(cid, "always", "sempre")
	  end
	  
	  table.insert(monsterLoots.loot, {
	    id     = getItemInfo(item.id).clientId,
		name   = itemName,
		count  = (item.countMax and item.countMax or item.count),
		chance = rarityName
	  }) 
	end
  end
  doSendPlayerExtendedOpcode(cid, LootOpcode, table.tostring(monsterLoots))
  return true
end