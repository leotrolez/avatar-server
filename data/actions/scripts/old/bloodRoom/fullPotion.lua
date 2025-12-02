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

local config = {
  storage = "healthBeforePotion",
  cidUsing = {}
}


local function heal(cid, amount)
  if not isCreature(cid) then
    return true
  end
	if getPlayerSlotItem(cid, 2).itemid == 10219 then 
		amount = amount*1.2
	end 
  local health = getCreatureHealth(cid)
  addEvent(function() config.cidUsing[cid] = nil end, 2000)

  if exhaustion.check(cid, "isInCombat") then
 --   doSendAnimatedText(getThingPos(cid), "Interrupted!", COLOR_RED)
    doCreatureAddHealth(cid, amount/2)
    doSendMagicEffect(getThingPos(cid), 12)  
    return true
  else
    doCreatureAddHealth(cid, amount)
    doSendMagicEffect(getThingPos(cid), 12)  
  end
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if config.cidUsing[cid] ~= nil then
    doPlayerSendCancel(cid, "You can only use one potion every 2 seconds.")
    return true
  end

  local bloodItem = getItemAttribute(item.uid, "hitpoints") or (potions[item.itemid] or potionsOld[item.itemid])
  setPlayerStorageValue(cid, "canPotion", 1)
  config.cidUsing[cid] = true
  doCreatureSay(cid, "Aaaah...", TALKTYPE_MONSTER)
  doCreatureSetStorage(cid, config.storage, getCreatureHealth(cid))
 -- addEvent(heal, 2000, cid, bloodItem)
 heal(cid, bloodItem)
  doRemoveItem(item.uid, 1)
  return true
end


