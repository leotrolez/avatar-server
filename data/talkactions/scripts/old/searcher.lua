local nomes = {"fire", "water", "air", "earth"}

local function isWaterHeal(p)
  local m = ""
  m = string.sub(p, 1, 1)
  if m == '"' then
    return true
  end
  return false
end
local function lastcheck(p)
  local m = ""
  m = string.sub(p, string.len(p), string.len(p))
  if m == '"' then
    return true
  end
  return false
end
local function getPlayerAlvo(p)
  local m = ""
  m = string.sub(p, 2, -1)
  if lastcheck(p) then
    m = string.sub(p, 2, -2)
  end
  return m
end
function searcherAlvo(cid, targetPlayer)
  local effects = {5, 86, 76, 34}
  local currentEffect = effects[getPlayerVocation(cid)]

  if currentEffect then
    local mypos = getThingPos(cid)
    local hispos = getThingPos(targetPlayer)
    if getPlayerStorageValue(targetPlayer, "isAvatar") == 1 then
      hispos = {x=math.random(263,972), y=math.random(100, 734), z=7}
    end
    local totalPoses = getPoses(mypos, hispos)
    local currentZPos = getThingPos(cid).z

    if totalPoses ~= true then
      for x = 1, #totalPoses do
        totalPoses[x].z = currentZPos
        doSendMagicEffect(totalPoses[x], currentEffect, cid)
        if x >= 15 then
          break
        end
      end
    end
    local andaresStr = "no mesmo andar que você"
    if hispos.z < mypos.z then
      local dif = mypos.z - hispos.z
      local difStr = dif == 1 and "andar" or "andares"
      andaresStr = dif .. " "..difStr.." acima de você"
    elseif hispos.z > mypos.z then
      local dif = hispos.z - mypos.z
      local difStr = dif == 1 and "andar" or "andares"
      andaresStr = dif .. " "..difStr.." abaixo de você"
    end
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, ""..getCreatureName(targetPlayer).." está à "..getDistanceBetween(hispos, mypos).."sqm de distância e "..andaresStr..".")
  else
    sendBlueMessage(cid, "Error 1872 please send it to gamemaster.")
  end
end

function onSay(cid, words, param, channel)
  if getPlayerStorageValue(cid, "isAvatar") ~= 1 then
    doPlayerSendCancel(cid, getLangString(cid, "Only the Avatar can use the Searcher.", "Somente o Avatar pode utilizar o Searcher."))
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
    return true
  end
  if exhaustion.check(cid, "searcherCdown") then
    doPlayerSendCancel(cid, "You are exhausted. Please wait "..tonumber(exhaustion.get(cid, "searcherCdown")).." seconds to use search again.")
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
    return true
  end
  if not param then
    doPlayerSendCancel(cid, "Wrong target name.")
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
    return true
  end
  if not isWaterHeal(param) then
    doPlayerSendCancel(cid, "Wrong target name.")
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
    return true
  end
  local mypos = getCreaturePosition(cid)
  if getPlayerLevel(cid) < 20 then
    doPlayerSendCancel(cid, "You do not have enough level. You need level 20.")
    doSendMagicEffect(mypos, CONST_ME_POFF)
    return true
  end

  local playeralvo = getPlayerAlvo(param)
  playeralvo = getPlayerByNameWildcard(playeralvo)
  if playeralvo and getPlayerAccess(playeralvo) < 3 and playeralvo ~= cid then
    searcherAlvo(cid, playeralvo)
    doCreatureSay(cid, words, TALKTYPE_ORANGE_1)
    exhaustion.set(cid, "searcherCdown", 6)
  else
    doPlayerSendCancel(cid, "Player not found.")
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
  end
  return true
end