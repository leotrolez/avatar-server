--[[
 * File destinado aos Exausted, separado por tables.
]]--

-- Atk = porcentagem do dano. 100 = dano original da fórmula, 70 = 30% menor do que o dano original da fórmula. Se colocar 0, só irá tirar 1 de dano
-- "heal" funciona igual o atk, só muda nome pra informar que muda a cura 
spellsInfo =
{
  ["air whip"] = {atk = 115},
  ["air ball"] = {atk = 120},
  ["air barrier"] = {atk = 70, slowPercent = 30, slowTempo = 1000, duracao = 5000},
  ["air bomb"] = {atk = 840, segundosParaExplosao = 3},
  ["air boost"] = {segundos = 30},
  ["air burst"] = {atk = 120},
  ["air deflection"] = {atk = 200},
  ["air doom"] = {atk = 156},
  ["air fan"] = {atk = 130},
  ["air force"] = {atk = 430},
  ["air gust"] = {atk = 125},
  ["air gale"] = {atk = 345},
  ["air hurricane"] = {atk = 140},
  ["air icywind"] = {atk = 200, frozzenTime = 2000},
  ["air jail"] = {segundos = 4},
  ["air suffocation"] = {atk = 35, segundos = 3},
  ["air jump"] = {duracao = 5000},
  ["air run"] = {duracao = 30000},
  ["air stormcall"] = {atk = 100},
  ["air tempest"] = {atk = 110},
  ["air tornado"] = {atk = 200, segundos = 2},
  ["air trap"] = {segundos = 15},
  ["air vortex"] = {atk = 100},
  ["air windblast"] = {atk = 84},
  ["air windstorm"] = {atk = 100},
  ["air wings"] = {atk = 125},
  ["earth whip"] = {atk = 115},
  ["earth arena"] = {duracao = 8000},
  ["earth aura"] = {atk = 51, duracao = 4000},
  ["earth armor"] = {duracao = 10000},
  ["earth cataclysm"] = {atk = 350},
  ["earth collapse"] = {atk = 250},
  ["earth control"] = {atk = 115},
  ["earth crush"] = {atk = 110},
  ["earth curse"] = {atk = 650},
  ["earth fists"] = {atk = 132},
  ["earth growth"] = {atk = 290},
  ["earth ingrain"] = {heal = 100, segundos = 7},
  ["earth jump"] = {duracao = 5000},
  ["earth fury"] = {atk = 144},
  ["earth lavaball"] = {atk = 100},
  ["earth leech"] = {atk = 300},
  ["earth metalwall"] = {atk = 100},
  ["earth petrify"] = {atk = 260, segundos = 4},
  ["earth pull"] = {atk = 350},
  ["earth punch"] = {atk = 195},
  ["earth quake"] = {atk = 104},
  ["earth rock"] = {atk = 170},
  ["earth smash"] = {atk = 182},
  ["earth storm"] = {atk = 60},
  ["earth track"] = {segundos = 30},
  ["earth wall"] = {segundos = 10},
  ["fire blast"] = {atk = 130},
  ["fire bolt"] = {atk = 126},
  ["fire bomb"] = {atk = 180},
  ["fire cannon"] = {atk = 100},
  ["fire conflagration"] = {atk = 120},
  ["fire clock"] = {atk = 37},
  ["fire discharge"] = {atk = 100},
  ["fire explosion"] = {atk = 200},
  ["fire impulse"] = {segundos = 30},
  ["fire kick"] = {atk = 300},
  ["fire jump"] = {duracao = 5000},
  ["fire lightning"] = {atk = 455},
  ["fire meteor"] = {atk = 100},
  ["fire overload"] = {atk = 96},
  ["fire res"] = {segundos = 60},
  ["fire skyfall"] = {atk = 230},
  ["fire star"] = {atk = 60},
  ["fire striker"] = {atk = 130},
  ["fire thunderbolt"] = {atk = 145},
  ["fire thunderstorm"] = {atk = 350},
  ["fire voltage"] = {segundos = 60},
  ["fire wave"] = {atk = 220},
  ["fire whip"] = {atk = 115},
  ["fire wrath"] = {segundos = 2},
  ["water blizzard"] = {atk = 100},
  ["water bloodbending"] = {atk = 100},
  ["water bloodcontrol"] = {atk = 95},
  ["water bubbles"] = {atk = 90, bolhas = 5},
  ["water cannon"] = {atk = 125},
  ["water clock"] = {atk = 200},
  ["water dragon"] = {atk = 192, chanceFrozzen = 35},
  ["water explosion"] = {atk = 100},
  ["water heal"] = {heal = 300},
  ["water flow"] = {atk = 100},
  ["water jump"] = {duracao = 5000},
  ["water sheal"] = {heal = 300},
  ["water icebeam"] = {atk = 150, frozzenTime = 2000, frozzenChance = 70},
  ["water icebolt"] = {atk = 300, frozzenTime = 3000},
  ["water icegolem"] = {segundos = 60},
  ["water icespikes"] = {atk = 215},
  ["water protect"] = {duracao = 4000},
  ["water punch"] = {atk = 240, slowPercent = 50, slowTempo = 3000},
  ["water rain"] = {atk = 110},
  ["water regen"] = {segundos = 60, quantia = 50},
  ["water sregen"] = {segundos = 60, quantia = 55},
  ["water res"] = {segundos = 60},
  ["water shards"] = {atk = 30},
  ["water surf"] = {segundos = 30},
  ["water tsunami"] = {atk = 165},
  ["water wave"] = {atk = 115},
  ["water whip"] = {atk = 115}
}

earthExausted = {
  whip = 2,
  arena = 45,
  armor = 70,
  lavaball = 60,
  metalwall = 90,
  wall = 1,
  control = 30,
  crush = 3,
  cataclysm = 45,
  collapse = 10,
  curse = 30,
  growth = 9,
  ingrain = 40,
  jump = 12,
  fury = 14,
  petrify = 30,
  pull = 4,
  punch = 4,
  push = 2,
  quake = 45,
  rock = 3,
  aura = 45,
  fists = 15,
  recover = 2,
  storm = 45,
  smash = 7,
  spikes = 5,
  leech = 3,
  track = 30,
  searcher = 5
}

fireExausted = {
  whip = 2,
  recover = 2,
  lightning = 8,
  thunderbolt = 12,
  explosion = 25,
  thunderstorm = 30,
  wave = 3,
  blast = 2,
  bolt = 10,
  jump = 12,
  skyfall = 10,
  star = 25,
  impulse = 30,
  focus = 60,
  meteor = 45,
  bomb = 20,
  overload = 30,
  wrath = 20,
  cannon = 8,
  striker = 45,
  discharge = 60,
  conflagration = 90,
  res = 60,
  voltage = 120,
  kick = 3,
  clock = 20,
  searcher = 5
}

waterExausted = {
  whip = 2,
  recover = 2,
  explosion = 2,
  heal = 3,
  iceSpikes = 15,
  clock = 45,
  blizzard = 60,
  bloodBending = 90,
  icebolt = 20,
  jump = 12,
  wave = 3,
  fang = 1,
  cannon = 8,
  regen = 45,
  mregen = 15,
  flow = 30,
  iceBeam = 10,
  iceGolem = 120,
  surf = 30,
  punch = 6,
  bloodControl = 45,
  dragon = 25,
  rain = 45,
  protect = 65,
  tsunami = 45,
  res = 60,
  bubbles = 12,
  searcher = 5,
  shards = 12
}
 
airExausted = {
  whip = 2,
  recover = 2,
  run = 40,
  ball = 1,
  burst = 2,
  force = 4,
  windstorm = 45,
  barrier = 40,
  bomb = 30,
  gust = 6,
  fan = 30,
  wings = 14,
  icywind = 20,
  gale = 15,
  jump = 12,
  jail = 35,
  suffocation = 35,
  boost = 30,
  hurricane = 13,
  trap = 12,
  doom = 45,
  stormcall = 45,
  vortex = 60,
  deflection = 90,
  searcher = 5,
  tornado = 20,
  tempest = 25,
  windblast = 20
}

function blockPlayerUseMagic(cid, time)
  return setPlayerStorageValue(cid, "playerBlockMagic", os.time()+time)
end

function getPlayerBlockMagic(cid)
  return getPlayerStorageValue(cid, "playerBlockMagic") > os.time()
end

--[[function getPlayerExaust(cid, element, spellName)
  if isMonster(cid) then
    return true
  end

  local storageString, strError = "exausted"..element..spellName, nil
  local currentTime, delayTime = os.time(), getPlayerStorageValue(cid, storageString)

  if delayTime >= currentTime then
    local stringTime = getSecsString(delayTime-currentTime)
    local tableTime = getTimeInString(delayTime)

    if tonumber(tableTime.second) >= 1 then
      strError = getLangString(cid, "You need wait "..stringTime.." to use this fold again.", "Você precisa esperar "..stringTime.." para usar essa dobra novamente.")
    else
      strError = getLangString(cid, "You need wait a few moments to use this fold again.", "Você precisa esperar alguns instantes para usar essa dobra novamente.")
    end

    doPlayerSendCancelEf(cid, strError)
    return false
  end
  return true
end]]--

function doPlayerAddExaust(cid, element, spellName, time)
  if isMonster(cid) then
    return true
  end

 --[[ if getPlayerSkullType(cid) > 3 then
    if time == 0 then
      time = 1
    end
    time = time*2
  end]]

  if getPlayerStorageValue(cid, "timeInEffectCdReduction") > os.time() then
    if time >= 5 then
      time = math.ceil(time-(time*0.3))
    end
  end
  
  if getPlayerStorageValue(cid, 13403) == 1 then
    if time >= 5 then
      time = math.ceil(time-(time*0.08))
    end
  end

  if time == nil then
    print("problem with spellExausted name "..spellName.." in element "..element)
    doPlayerSendCancelEf(cid, "Error with this spell, report to gameMaster.")
    sendBlueMessage(cid, "Error with this spell, report to gameMaster." )
    return false
  elseif time == 0 then
    sendCDToClient(cid, element, spellName, 1)
    return true
  end

  if not getPlayerExaust(cid, element, spellName) then
    return false
  end

  sendCDToClient(cid, element, spellName, time)
  setPlayerStorageValue(cid, "exausted"..element..spellName, os.time()+time)
  sendSpellCooldown(cid, string.format("%s %s", element, spellName), time)
  return true
end

function canUseWaterSpell(cid, countWater, distance, onlyAmbient)
  local fullPouchId = 4864
  local emptyPouchId = 4863
  
  if isMonster(cid) then
    return true
  end

  if getPlayerCanUseAmbientWater(cid, distance) == true then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, getLangString(cid, "Using ambient water.", "Usando água ambiente."))
    return true
  end

  if onlyAmbient == true then
    doPlayerSendCancelEf(cid, getLangString(cid, "This fold requires a lot of water, only ambient water.", "Essa dobra requer uma grande quantidade de água, apenas água ambiente."))
    return false
  end

--  local waterPouch, pouchWater = getPlayerSlotItem(cid, 10), nil
  local waterPouch, pouchWater = getPlayerItemById(cid, true, 4864), nil
  
  if waterPouch.uid > 0 then
    pouchWater = getItemAttribute(waterPouch.uid, "water")
  end

  if pouchWater == nil then
    if waterPouch.uid > 0 and (waterPouch.itemid == fullPouchId or waterPouch.itemid == emptyPouchId) then
      doItemSetAttribute(waterPouch.uid, "water", 0)
    end
    doPlayerSendCancelEf(cid, getLangString(cid, "To use this fold you need a water source.", "Para usar essa dobra, você precisa de uma fonte de água."))
    return false
  end
  local waterPouchCount = getPlayerItemCount(cid, 4864)
  if waterPouch.itemid == fullPouchId then
    if pouchWater < countWater then
      setWaterOnPounchPlayer(cid, 0, waterPouch)
      doPlayerSendCancel(cid, getLangString(cid, "The water we had was not enough to fold and was discarded.", "Essa água não serve para essa dobra, portanto, ela foi descartada."))
      doDecayItem(doCreateItem(2017, getCreaturePosition(cid)))
      return false
    elseif pouchWater == countWater then
      setWaterOnPounchPlayer(cid, 0, waterPouch)
    if waterPouchCount <= 1 then 
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "Using water pounch, your water pouch dried.", "Usando water pouch, acabou a água."))
    else
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "One water pouch dried, you now have "..(waterPouchCount-1).." more.", "Um water pouch secou, você tem mais "..(waterPouchCount-1).."."))
    end 
      return true
    else
      setWaterOnPounchPlayer(cid, pouchWater-countWater, waterPouch)
      if waterPouchCount <= 1 then 
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "Using last water pounch ("..pouchWater.."%).", "Usando último water pouch ("..pouchWater.."%)."))
    else 
      doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, getLangString(cid, "Using one ("..pouchWater.."%) of "..waterPouchCount.." water pounchs.", "Usando um ("..pouchWater.."%) de "..waterPouchCount.." water pouchs."))
    end 
      return true
    end
  else
    doPlayerSendCancelEf(cid, getLangString(cid, "To use this fold you need a water source.", "Para usar essa dobra, você precisa de uma fonte de água."))
    return false
  end
end

function getSpellCancels(cid, spellName, isFury, isDash)
  if isMonster(cid) then
    return false
  end
 
  if getCreatureNoMove(cid) or exhaustion.check(cid, "airtrapped") then
    doPlayerSendCancelEf(cid, getLangString(cid, "You are unable to bend now.", "Você não pode dobrar agora."))  
    return true
  end
  if getPlayerStorageValue(cid, "playerCantDown") == 1 and not isFury then 
    doPlayerSendCancelEf(cid, getLangString(cid, "You are unable to bend flying.", "Você não pode dobrar voando."))  
    return true
  end

  if isDash then
    return false
  end

  if spellName == "earth" or spellName == "fire" or spellName == "water" then
    local currentPosition = getCreaturePosition(cid)
    local groundItem = getThingFromPos({x=currentPosition.x, y=currentPosition.y, z=currentPosition.z, stackpos=0})
    local isSqmFlying = not groundItem or groundItem.itemid == 1 or groundItem.id == 460

    if getPlayerStorageValue(cid, "playerOnAir") == 1 or isSqmFlying then
      doPlayerSendCancelEf(cid, getLangString(cid, "You can't use this bend on air.", "Você não pode usar essa dobra no ar."))
      return true
    end

    return false
  elseif spellName == "air" then
    return false
  end
end

function setPlayerOverPower(cid, element, time)
  setPlayerStorageValue(cid, element.."overPower", os.time()+time)
end

function getPlayerOverPower(cid, element, disable, animatedText)
  if isMonster(cid) then
    return false
  end

  local time = getPlayerStorageValue(cid, element.."overPower")
  if disable == true then
    setPlayerStorageValue(cid, element.."overPower", 0)
  end
  if os.time() < time then
    if animatedText == true then
      doSendAnimatedText(getThingPos(cid), "Focused!", COLOR_DARKRED)
    end
    return true
  else
    return false
  end
end

function setPlayerStuned(cid, time)
  if time == nil or time == 0 or time == false then
    setPlayerStorageValue(cid, "playerHasStun", 0)
  else
    setPlayerStorageValue(cid, "playerHasStun", os.time()+time)
  end
end

function getPlayerHasStun(cid)
  if getPlayerStorageValue(cid, "playerHasStun") >= os.time() then
    if math.random(1, 6) ~= 6 then
      doSendAnimatedText(getThingPos(cid), "Miss!", COLOR_WHITE)
      return true
    else
      return false
    end
  else
    return false
  end
end

function cleanAllCds(cid, element)
  local tableElement = {
  ["fire"] = fireSpells, 
  ["water"] = waterSpells,
  ["earth"] = earthSpells,
  ["air"] = airSpells
  }

  if tableElement[element] ~= nil then
    for x = 1, #tableElement[element] do
      setPlayerStorageValue(cid, "exausted"..tableElement[element][x], -1)
    end
    sendAllCdToClient(cid, element)
    return true
  end
  return false
end