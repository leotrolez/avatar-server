local restrictions = {
  {top = {x=698,y=238,z=13}, under = {x=746,y=280,z=13}}, --GM Place
  {top = {x=768,y=247,z=9}, under = {x=788,y=256,z=9}}, --Anihilator
  {top = {x=446,y=544,z=7}, under = {x=450,y=546,z=7}}, --Quest DemonSkeleton
}

local function canSave(cid)
  if getPlayerStorageValue(cid, "hasActiveInQuest") == 1 then 
    return false
  end

  for x = 1, #restrictions do
    if getPlayerInPos(cid, restrictions[x].under, restrictions[x].top, restrictions[x].under.z) then
      return false
    end
  end

  local playerPos = getThingPos(cid)

  if not getPlayerCanWalk({player = cid, position = playerPos, checkPZ = true, checkHouse = true}) then
    return false
  end

  local tileInfo = getTileInfo(playerPos)

  if tileInfo.noLogout or tileInfo.hardcore or tileInfo.optional then
    return false
  end

  if hasSqm(playerPos, 460) then
    return false
  end

  return true
end

local function canStartTeleport(cid)
  if getPlayerStorageValue(cid, "hasActiveInQuest") == 1 then 
    return false
  end

  if isPlayerBattle(cid) then
    return false
  end

  return true
end

local function canTeleport(cid, finalPos)
  if math.random(1, 100) <= 10 then --10% chance de falha
    return false
  end

  if getPlayerStorageValue(cid, "hasActiveInQuest") == 1 then 
    return false
  end

  for x = 1, #restrictions do
    if getPlayerInPos(finalPos, restrictions[x].under, restrictions[x].top, restrictions[x].under.z) then
      return false
    end
  end

  if not getPlayerCanWalk({player = cid, position = finalPos, checkPZ = true, checkHouse = true, checkWater = false}) then
    return false
  end

  local tileInfo = getTileInfo(finalPos)

  if tileInfo.noLogout or tileInfo.hardcore or tileInfo.optional then
    return false
  end

  if hasSqm(finalPos, 460) then
    return false
  end

  return true
end

local maxLoads = 10

local function loadTeleport(cid, current)
  if isCreature(cid) then
    doSendMagicEffect(getThingPos(cid), 10)

    if current == maxLoads then
      local finalPos = getPosInStorage(cid, "teleportPos")

      if canTeleport(cid, finalPos) then
        doTeleportCreature(cid, finalPos, 10)
        sendBlueMessage(cid, getLangString(cid, "You have been teleported successfully.", "Você foi teleportado com sucesso."))
        doSendAnimatedText(finalPos, "Wooop!", TEXTCOLOR_WHITE)
      else
        doPlayerSendCancel(cid, getLangString(cid, "The teleport failed.", "O teleport falhou."))
      end

      doCreatureSetNoMove(cid, false)
    end
  end
end


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if getPlayerStorageValue(cid, "statsTeleport") == -1 then
    --Salvar
    if not canSave(cid) then
      doPlayerSendCancelEf(cid, getLangString(cid, "You can't save this here.", "Você não pode salvar essa posição."))
    else
      sendBlueMessage(cid, getLangString(cid, "Position saved successfully.", "Posição salva com sucesso."))
      doSendMagicEffect(getThingPos(cid), 12)
      setPlayerStorageValue(cid, "statsTeleport", 1)
      registerPosInStorage(cid, "teleportPos", getThingPos(cid))
    end
  else
    if not canStartTeleport(cid) then
      doPlayerSendCancelEf(cid, getLangString(cid, "You can't teleport now.", "Você não pode teleportar agora."))
    else
      for x = 1, maxLoads do
        doCreatureSetNoMove(cid, true)
        addEvent(loadTeleport, x*1000, cid, x)
      end

      doPlayerSendCancel(cid, getLangString(cid, "Starting teleport...", "Iniciando teleport..."))
      setPlayerStorageValue(cid, "statsTeleport", -1)
      doRemoveItem(item.uid, 1)
    end
  end
  
  return true
end