local spellName = "water heal"
local cf = {heal = spellsInfo[spellName].heal}

local function purify(cid)
  local conditions = {CONDITION_FIRE, CONDITION_POISON, CONDITION_ENERGY, CONDITION_LIFEDRAIN, CONDITION_PARALYZE, CONDITION_DROWN, CONDITION_DRUNK}
  local hasPurify = 0
  for x = 1, #conditions do
    if (hasCondition(cid, conditions[x])) then
      doRemoveCondition(cid, conditions[x])
      hasPurify = 1
    end
  end
  if hasPurify == 1 then
    doSendAnimatedText(getCreaturePosition(cid), "Purified!", 52)
  end
end

local function doSendHealth(cid, target)
  if isPlayer(target) then
    local heal = getPlayerMagLevel(cid) + (getPlayerLevel(cid)/2)
    heal = heal + math.random(15, 30)
    --		local heal = (maxHealth*0.13+(maglevel*2))*0.72
    local atk = cf.heal
    if atk and type(atk) == "number" then
      heal = heal * (atk/100)
      heal = heal+1
    end
    if target ~= cid then
      heal = heal*1.2
    else
      heal = heal*0.8
    end
    if not exhaustion.check(target, "isInCombat") then
      heal = heal*1.5
    end
    if getDobrasLevel(cid) >= 3 then
      heal = heal*1.2
    end
    doCreatureAddHealth(target, heal)
    doSendMagicEffect(getThingPos(target), CONST_ME_MAGIC_BLUE)
    purify(target)
    return true
  end
end

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
local function isNonPvp(cid)
  return getPlayerLevel(cid) < 50
end

function onSay(cid, words, param, channel)
  if not param then
    return false
  end
  if not isWaterHeal(param) then
    return  false
  end
  local mypos = getCreaturePosition(cid)
  if getPlayerAccess(cid) == 3 then
    return true
  elseif getPlayerVocation(cid) ~= 2 and getPlayerAccess(cid) < 4 then
    doPlayerSendCancel(cid, "Your vocation cannot use this spell.")
    doSendMagicEffect(mypos, CONST_ME_POFF)
    return false
  elseif getPlayerLevel(cid) < 12 then
    doPlayerSendCancel(cid, "You do not have enough level.")
    doSendMagicEffect(mypos, CONST_ME_POFF)
    return false
  elseif getCreatureMana(cid) < 12 then
    doPlayerSendCancel(cid, "You do not have enough mana.")
    doSendMagicEffect(mypos, CONST_ME_POFF)
    return false
  end
  if getPlayerExaust(cid, "water", "heal") == false then
    return false
  end

  local playeralvo = getPlayerAlvo(param)
  playeralvo = getPlayerByNameWildcard(playeralvo)
  if playeralvo == cid then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You need to use Water Sheal to heal yourself.")
    doSendMagicEffect(mypos, CONST_ME_POFF)
    return true
  end
  if playeralvo and isNonPvp(cid) and not isNonPvp(playeralvo) and exhaustion.check(playeralvo, "isInCombat") then
    doPlayerSendCancel(cid, "You can't heal PvP combat players while you're a non-PvP (protected until level 50).")
    doSendMagicEffect(mypos, CONST_ME_POFF)
    return true
  end
  if playeralvo and isInWarGround(cid) and not isSameWarTeam(cid, playeralvo) then
    doPlayerSendCancel(cid, "You can't heal players from the enemy team.")
    doSendMagicEffect(mypos, CONST_ME_POFF)
    return true
  end
  if playeralvo and getDistanceBetween(getCreaturePosition(playeralvo), mypos) < 6 and isSightClear(getCreaturePosition(playeralvo), mypos, true) and getPlayerAccess(playeralvo) < 3 then
    if getSpellCancels(cid, "water") == true then
      return false
    end
    if canUseWaterSpell(cid, 1, 3, false) then
      workAllCdAndAndPrevCd(cid, "water", "heal", nil, 1)
      if getPlayerHasStun(cid) then
        return true
      end
      if doPlayerAddExaust(cid, "water", "heal", waterExausted.heal) == false then
        return false
      end
      doSendHealth(cid, playeralvo)
      words = words .. " "..param..""
      words = string.lower(words)
      doCreatureSay(cid, words, TALKTYPE_ORANGE_1)
      doCreatureAddMana(cid, -12, false)
    end
  else
    doPlayerSendCancel(cid, "Player not found.")
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
  end

  return true
end