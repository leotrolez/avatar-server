local MyLocal = {}
MyLocal.players = {}

MyLocal.potions = {
  [7620] = {delayTime = 2000, times = 3, manaEachTime = 35, animation = "Aaaah..."},
  [7589] = {delayTime = 2000, times = 3, manaEachTime = 70, animation = "Aaaah..."},
  [7590] = {delayTime = 2000, times = 3, manaEachTime = 140, animation = "Aaaah..."}
}

local function removeTable(cid)
  MyLocal.players[cid] = nil
end

local function healPlayer(cid, mana, speed, times, totalTimes)
  if not isPlayer(cid) then
    return true
  end

 -- if getCreatureHealth(cid) < getPlayerStorageValue(cid, "ManaBeforePotion")  then
 --   doSendAnimatedText(getThingPos(cid), "Fail!", COLOR_RED)
 --   removeTable(cid)
  --  return true
  --end

  doCreatureAddMana(cid, mana)
  doSendMagicEffect(getThingPos(cid), 12)

  if totalTimes > times then
    addEvent(healPlayer, speed, cid, mana, speed, times+1, totalTimes)
  else
    removeTable(cid)
  end
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local itemId = item.itemid
  local potion = MyLocal.potions[itemId]

  if MyLocal.players[cid] == nil then
  --  doCreatureSetStorage(cid, "ManaBeforePotion", getCreatureHealth(cid))
    doCreatureSay(cid, potion.animation, TALKTYPE_MONSTER)
    MyLocal.players[cid] = true
    doRemoveItem(item.uid, 1)
    healPlayer(cid, potion.manaEachTime, potion.delayTime, 1, potion.times)
  else
    doPlayerSendCancel(cid, "You're already on the effect of this potion, try again later.")
  end

  return true
end
