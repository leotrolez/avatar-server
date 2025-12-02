dofile("data/lib/old/npc_task_system.lua")

local config = {
  delayToOpenAgain = 15, -- in minutes
  bossName = "Devil Skeleton",
  gatePos = {x=448,y=543,z=7},
  monsterPos = {x=450,y=545,z=7},
  gateId = 1547,
  levelMin = 40,
  currentMonster = 0,
  currentEvent = 0,
  effect = 15,
  delayToDoAgain = 12 --in hours
}

local function cleanUpRoom(uid)
  local item = getTileItemById(config.gatePos, config.gateId)

  if item.uid > 0 then
    doRemoveItem(item.uid, 1)
  end

  if isCreature(uid) then
    doRemoveCreature(uid)
  end

  stopEvent(config.currentEvent)
end

local function loop()
  if isCreature(config.currentMonster) then
    addEvent(loop, 1000, nil)
  else
    cleanUpRoom(config.currentMonster)
  end
end

local function start(cid)
  config.currentMonster = doCreateMonster(config.bossName, config.monsterPos, nil, true)
  sendBlueMessage(cid, getLangString(cid, "Now you need defeat this boss to get your reward!", "Voc� deve derrotar o boss para pegar sua recompensa!"))
  startTaskInPlayer(cid, 8, "Demoniac Quest")
  doCreateItem(config.gateId, config.gatePos)
  doSendMagicEffect(config.monsterPos, config.effect)
  loop()
  currentEvent = addEvent(cleanUpRoom, config.delayToOpenAgain*60*1000, config.currentMonster)
  setPlayerStorageValue(cid, "timeToDoSkeletonQuestAgain", os.time()+(60*60*config.delayToDoAgain))  
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid

  if not isCreature(config.currentMonster) then
    if getPlayerLevel(cid) < config.levelMin then
      doPlayerSendCancel(cid, getLangString(cid, "Sorry, you need have level "..config.levelMin.." to start this quest.", "Desculpe, voc� precisa ter no min level "..config.levelMin.." para come�ar essa quest."))
      return true
    end

    if getPlayerHasEndTask(cid, 8) then --terminou quest
      doPlayerSendCancel(cid, getLangString(cid, "Sorry, you already did this quest.", "Desculpe, voc� j� completou essa quest."))
      return true
    end

    local timeLeft = getPlayerStorageValue(cid, "timeToDoSkeletonQuestAgain")
    if timeLeft > os.time() then
      doPlayerSendCancel(cid, getLangString(cid, "You need wait "..getSecsString(timeLeft-os.time()).." to start this quest again.", "Voc� precisa aguardar "..getSecsString(timeLeft-os.time()).." para come�ar essa quest novamente."))
      return true
    end

    doTransformLever(item)
    start(cid)
  else
    doPlayerSendCancel(cid, getLangString(cid, "First you need defeat this current boss.", "Primeiro voc� deve matar o boss j� spamado."))
  end
  
  return true
end