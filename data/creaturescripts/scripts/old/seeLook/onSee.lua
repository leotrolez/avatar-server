dofile(getDataDir().."creaturescripts/scripts/seeLook/onSeeFuncs.lua")
 
local durabilityIDs = {2553}
local priceExeptionsIDs = {4863, 4864, 2148, 2152, 2160, 3901, 3902, 3903, 3904, 3905, 3906, 3907, 3908,
                           3909, 3910, 3911, 3912, 3913, 3914, 3917, 3919, 3920, 3921, 3922, 3923, 3924,
                           3925, 3926, 3927, 3928, 3929, 3930, 3931, 3933, 3934, 3935, 5087, 6372, 8692,
                           1872, 1860, 1866, 1857, 1869, 1880, 1863, 1678, 1679, 1680, 1681, 1682, 1683,
                           1684, 1690, 1691, 1692, 1693, 1685, 1686, 1687, 1688, 1689, 1845, 1848, 1851,
                           7904, 7905, 7906, 7907, 2562, 12828, 11259, 12825, 12751, 2553, 4856}
 
local potsBlood = {8473,7588,7618,13366,13367,13368, 15014}
 
local potions = {
  [13366] = 150,
  [13367] = 300,
  [13368] = 450,
  [15014] = 600
}
 
local potionsOld = {
  [7618] = 150,
  [7588] = 300,
  [8473] = 450,
  [15014] = 600
}
 
local function saveUnkownItemLog(itemid, playerName)
  local file = io.open("data/logs/unknowItems.txt", "a+")
  local string, canWrite = file:read("*all"), true
 
 
  if string then
    if string.find(string, itemid) then
      canWrite = false
    end
  end
 
  if canWrite then
    file:write(itemid .. " [" .. playerName .. "]\n")
  end
 
  file:close()
end
 
function onLook(cid, thing, position, lookDistance)
  if not isCreature(thing.uid) then
    local description = getItemAttribute(thing.uid, "description") or ""
 
    --isso resolve os bug das house--
    if doMessageCheck(description, "#") then
      local totalMsg = string.explode(description, "#")
      doItemSetAttribute(thing.uid, "description", totalMsg[1].." "..totalMsg[2])
      return true
 
    else
      local item = getItemDescriptionsById(thing.itemid).name or ""
 
      --unknowItem
      if item == "" then
      --  saveUnkownItemLog(thing.itemid, getCreatureName(cid))
          return true
      end
    end
    --fim--
    if isInArray(potsBlood, thing.itemid) then
      local bloodItem = getItemAttribute(thing.uid, "hitpoints") or (potions[thing.itemid] or potionsOld[thing.itemid])
      local author = getItemAttribute(thing.uid, "author") or getLangString(cid, "unknown", "alguém desconhecido")
 
      local text = getLangString(cid, "This flask of blood contains "..bloodItem.." hitpoints, blood drawn from "..author..".\n It only heals "..(bloodItem/2).." hitpoints if you received damage from players on last 5 seconds.", "Esse sangue pertence á "..author..", tendo exatamente "..bloodItem.." hitpoints. \n Isto apenas regenera "..(bloodItem/2).." hitpoints caso você tenha recebido dano de algum jogador nos últimos 5 segundos.")
      doItemSetAttribute(thing.uid, "description", text)
      return true
 
    --elseif isInArray(durabilityIDs, thing.itemid) then
      --local itemDurability = getItemAttribute(thing.uid, "durability") or 100
      --doItemSetAttribute(thing.uid, "name", getItemNameById(thing.itemid).." ("..getLangString(cid, "durability", "durabilidade")..": "..itemDurability.."%)")
    else
 
      if isInArray(priceExeptionsIDs, thing.itemid) then
        return true
      end
 
      if not isPickupableById(thing.itemid) then
        return true
      end
 
      if isContainer(thing.uid) then
        return true
      end
 
      setItemToRealPrice(cid, thing)
      setDescriptionItemBonus(cid, thing)
    end
  elseif isPlayer(thing.uid) then
      local text = ""
	  if getPlayerLevel(thing.uid) < 50 then 
		if thing.uid ~= cid then
			text = getLangString(cid, "\nThis player doesnt have enough level to PvP.", "\nEste jogador não possui nível suficiente para participar de combates PvP.")
		else
			text = getLangString(cid, "\nYou dont have enough level to PvP.", "\nVocê não possui nível suficiente para participar de combates PvP.")
		end
	  end 
	    if getPlayerStorageValue(thing.uid, "isAvatar") == 1 then
			if thing.uid ~= cid then
				text = text .. getLangString(cid, "\nHe is the Avatar.", "\nEle é o Avatar.")
			else
				text = text .. getLangString(cid, "\nYou are the Avatar.", "\nVocê é o Avatar.")
			end
		end
      doPlayerSetSpecialDescription(thing.uid, text)
      return true
  end
  if isPlayer(thing.uid) and getPlayerStorageValue(thing.uid, "isAvatar") == 1 then
	if thing.uid ~= cid then
		doPlayerSetSpecialDescription(thing.uid, getLangString(cid, "\nHe is the Avatar.", "\nEle é o Avatar."))
	 else
		doPlayerSetSpecialDescription(thing.uid, getLangString(cid, "\nYou are the Avatar.", "\nVocê é o Avatar."))
	 end
  end
 
  return true
end