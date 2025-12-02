dofile("data/lib/old/npc_system.lua")

local players = {}
local InfoOpcode = 165

local function getColdownPassive(cid)
  local time = getPlayerStorageValue(cid, "hasPassiveDeathActive")
  if time > os.time() then
    local stringTime = getSecsString(time-os.time())
    return getLangString(cid, "\nPassive Resurrection: "..stringTime..".", "\nPassiva de Ressurreição: "..stringTime..".")
  end

  return getLangString(cid, "\nPassive Resurrection: Ready.", "\nPassiva de Ressurreição: Ativa.")
end

local function getPotionExpString(cid)
  local time = getPlayerStorageValue(cid, "hasInPotionExp")

  if time > os.time() then
    local stringTime = getSecsString(time-os.time())

    return getLangString(cid, "\nPotion Exp active: "..stringTime.." left.", "\nPotion Exp ativa: "..stringTime.." restante.")
  else
    return ""
  end
end

local function getPotionRedString(cid)
  local time = getPlayerStorageValue(cid, "timeInEffectCdReduction")

  if time > os.time() then
    local stringTime = getSecsString(time-os.time())

    return getLangString(cid, "\nPotion Reduction active: "..stringTime.." left.", "\nPotion Reduction ativa: "..stringTime.." restante.")
  else
    return ""
  end
end

local function stringToPlural(stringNormal, stringPlural, number)
  if number > 1 then
    return stringPlural
  else
    return stringNormal
  end
end

local function getArchangelString(cid)
  return exhaustion.check(cid, "Archangel") and "\nBenção do Arcanjo: "..getSecsString(exhaustion.get(cid, "Archangel")).."" or ""
end

local function getBlessString(cid)
  if getPlayerStorageValue(cid, "playerWithSupremeBless") == 1 then
    return "Ativa (Bless Suprema)"
  end
  return getPlayerStorageValue(cid, "playerWithBless") == 1 and "Ativa" or "Sem proteção"
end

function onSay(player, words, param, channel)
  local cid = player:getId()
  if not players[cid] then
    local health, mana, bend, dodge = getPointsUsedInSkill(cid, "health"), getPointsUsedInSkill(cid, "mana"), getPointsUsedInSkill(cid, "bend"), getPointsUsedInSkill(cid, "dodge")
    local priceHealth, priceMana, priceBend, priceDodge = getPointsWasted(cid, "health"), getPointsWasted(cid, "mana"), getPointsWasted(cid, "bend"), getPointsWasted(cid, "dodge")
    local points = getPlayerElementPoints(cid, getPlayerElement(cid))
    local coins = getPlayerCoins(cid)

    local upgradeStones = getDobrasLevel(cid)
    local playerLevel = getPlayerVocation(cid)

    local lastDobra = ""
    if (upgradeStones == 0) then
      lastDobra = "Você ainda não aprimorou nenhuma dobra"
    elseif ((upgradeStones == 1) and playerLevel == 1) then
      lastDobra = "Fire Whip"
    elseif ((upgradeStones == 2) and playerLevel == 1) then
      lastDobra = "Fire Kick"
    elseif ((upgradeStones == 3) and playerLevel == 1) then
      lastDobra = "Fire Skyfall"
    elseif ((upgradeStones == 4) and playerLevel == 1) then
      lastDobra = "Fire Jump"
    elseif ((upgradeStones == 5) and playerLevel == 1) then
      lastDobra = "Fire Impulse"
    elseif ((upgradeStones == 6) and playerLevel == 1) then
      lastDobra = "Fire Bolt"
    elseif ((upgradeStones == 7) and playerLevel == 1) then
      lastDobra = "Fire Res"
    elseif ((upgradeStones == 8) and playerLevel == 1) then
      lastDobra = "Fire Star"
    elseif ((upgradeStones == 9) and playerLevel == 1) then
      lastDobra = "Fire Cannon"
    elseif ((upgradeStones == 10) and playerLevel == 1) then
      lastDobra = "Fire Wrath"
    elseif ((upgradeStones == 11) and playerLevel == 1) then
      lastDobra = "Fire Focus"
    elseif ((upgradeStones == 12) and playerLevel == 1) then
      lastDobra = "Fire Lightning"
    elseif ((upgradeStones == 13) and playerLevel == 1) then
      lastDobra = "Fire Bomb"
    elseif ((upgradeStones == 14) and playerLevel == 1) then
      lastDobra = "Fire Clock"
    elseif ((upgradeStones == 15) and playerLevel == 1) then
      lastDobra = "Fire Thunderbolt"
    elseif ((upgradeStones == 16) and playerLevel == 1) then
      lastDobra = "Fire Meteor"
    elseif ((upgradeStones == 17) and playerLevel == 1) then
      lastDobra = "Fire Striker"
    elseif ((upgradeStones == 18) and playerLevel == 1) then
      lastDobra = "Fire Overload"
    elseif ((upgradeStones == 19) and playerLevel == 1) then
      lastDobra = "Fire Explosion"
    elseif ((upgradeStones == 20) and playerLevel == 1) then
      lastDobra = "Fire Voltage"
    elseif ((upgradeStones == 21) and playerLevel == 1) then
      lastDobra = "Fire Thunderstorm"
    elseif ((upgradeStones == 22) and playerLevel == 1) then
      lastDobra = "Fire Discharge"
    elseif ((upgradeStones == 23) and playerLevel == 1) then
      lastDobra = "Fire Conflagration"
    elseif ((upgradeStones == 1) and playerLevel == 2) then
      lastDobra = "Water Whip"
    elseif ((upgradeStones == 2) and playerLevel == 2) then
      lastDobra = "Water Explosion"
    elseif ((upgradeStones == 3) and playerLevel == 2) then
      lastDobra = "Water Heal"
    elseif ((upgradeStones == 4) and playerLevel == 2) then
      lastDobra = "Water Jump"
    elseif ((upgradeStones == 5) and playerLevel == 2) then
      lastDobra = "Water IceSpikes"
    elseif ((upgradeStones == 6) and playerLevel == 2) then
      lastDobra = "Water Res"
    elseif ((upgradeStones == 7) and playerLevel == 2) then
      lastDobra = "Water Shards"
    elseif ((upgradeStones == 8) and playerLevel == 2) then
      lastDobra = "Water Surf"
    elseif ((upgradeStones == 9) and playerLevel == 2) then
      lastDobra = "Water Cannon"
    elseif ((upgradeStones == 10) and playerLevel == 2) then
      lastDobra = "Water Regen"
    elseif ((upgradeStones == 11) and playerLevel == 2) then
      lastDobra = "Water BloodControl"
    elseif ((upgradeStones == 12) and playerLevel == 2) then
      lastDobra = "Water Punch"
    elseif ((upgradeStones == 13) and playerLevel == 2) then
      lastDobra = "Water Dragon"
    elseif ((upgradeStones == 14) and playerLevel == 2) then
      lastDobra = "Water Rain"
    elseif ((upgradeStones == 15) and playerLevel == 2) then
      lastDobra = "Water Bubbles"
    elseif ((upgradeStones == 16) and playerLevel == 2) then
      lastDobra = "Water Protect"
    elseif ((upgradeStones == 17) and playerLevel == 2) then
      lastDobra = "Water IceBolt"
    elseif ((upgradeStones == 18) and playerLevel == 2) then
      lastDobra = "Water Flow"
    elseif ((upgradeStones == 19) and playerLevel == 2) then
      lastDobra = "Water IceGolem"
    elseif ((upgradeStones == 20) and playerLevel == 2) then
      lastDobra = "Water Tsunami"
    elseif ((upgradeStones == 21) and playerLevel == 2) then
      lastDobra = "Water Clock"
    elseif ((upgradeStones == 22) and playerLevel == 2) then
      lastDobra = "Water Blizzard"
    elseif ((upgradeStones == 23) and playerLevel == 2) then
      lastDobra = "Water BloodBending"
    elseif ((upgradeStones == 1) and playerLevel == 3) then
      lastDobra = "Air Ball"
    elseif ((upgradeStones == 2) and playerLevel == 3) then
      lastDobra = "Air Burst"
    elseif ((upgradeStones == 3) and playerLevel == 3) then
      lastDobra = "Air Run"
    elseif ((upgradeStones == 4) and playerLevel == 3) then
      lastDobra = "Air Jump"
    elseif ((upgradeStones == 5) and playerLevel == 3) then
      lastDobra = "Air Force"
    elseif ((upgradeStones == 6) and playerLevel == 3) then
      lastDobra = "Air Gust"
    elseif ((upgradeStones == 7) and playerLevel == 3) then
      lastDobra = "Air Gale"
    elseif ((upgradeStones == 8) and playerLevel == 3) then
      lastDobra = "Air Boost"
    elseif ((upgradeStones == 9) and playerLevel == 3) then
      lastDobra = "Air Fan"
    elseif ((upgradeStones == 10) and playerLevel == 3) then
      lastDobra = "Air Wings"
    elseif ((upgradeStones == 11) and playerLevel == 3) then
      lastDobra = "Air Suffocation"
    elseif ((upgradeStones == 12) and playerLevel == 3) then
      lastDobra = "Air Hurricane"
    elseif ((upgradeStones == 13) and playerLevel == 3) then
      lastDobra = "Air Tempest"
    elseif ((upgradeStones == 14) and playerLevel == 3) then
      lastDobra = "Air Windblast"
    elseif ((upgradeStones == 15) and playerLevel == 3) then
      lastDobra = "Air Tornado"
    elseif ((upgradeStones == 16) and playerLevel == 3) then
      lastDobra = "Air Barrier"
    elseif ((upgradeStones == 17) and playerLevel == 3) then
      lastDobra = "Air Trap"
    elseif ((upgradeStones == 18) and playerLevel == 3) then
      lastDobra = "Air Doom"
    elseif ((upgradeStones == 19) and playerLevel == 3) then
      lastDobra = "Air Bomb"
    elseif ((upgradeStones == 20) and playerLevel == 3) then
      lastDobra = "Air Windstorm"
    elseif ((upgradeStones == 21) and playerLevel == 3) then
      lastDobra = "Air Stormcall"
    elseif ((upgradeStones == 22) and playerLevel == 3) then
      lastDobra = "Air Vortex"
    elseif ((upgradeStones == 23) and playerLevel == 3) then
      lastDobra = "Air Deflection"
    elseif ((upgradeStones == 1) and playerLevel == 4) then
      lastDobra = "Earth Crush"
    elseif ((upgradeStones == 2) and playerLevel == 4) then
      lastDobra = "Earth Punch"
    elseif ((upgradeStones == 3) and playerLevel == 4) then
      lastDobra = "Earth Rock"
    elseif ((upgradeStones == 4) and playerLevel == 4) then
      lastDobra = "Earth Jump"
    elseif ((upgradeStones == 5) and playerLevel == 4) then
      lastDobra = "Earth Pull"
    elseif ((upgradeStones == 6) and playerLevel == 4) then
      lastDobra = "Earth Growth"
    elseif ((upgradeStones == 7) and playerLevel == 4) then
      lastDobra = "Earth Collapse"
    elseif ((upgradeStones == 8) and playerLevel == 4) then
      lastDobra = "Earth Track"
    elseif ((upgradeStones == 9) and playerLevel == 4) then
      lastDobra = "Earth Petrify"
    elseif ((upgradeStones == 10) and playerLevel == 4) then
      lastDobra = "Earth Fury"
    elseif ((upgradeStones == 11) and playerLevel == 4) then
      lastDobra = "Earth Control"
    elseif ((upgradeStones == 12) and playerLevel == 4) then
      lastDobra = "Earth Leech"
    elseif ((upgradeStones == 13) and playerLevel == 4) then
      lastDobra = "Earth Smash"
    elseif ((upgradeStones == 14) and playerLevel == 4) then
      lastDobra = "Earth Ingrain"
    elseif ((upgradeStones == 15) and playerLevel == 4) then
      lastDobra = "Earth Fists"
    elseif ((upgradeStones == 16) and playerLevel == 4) then
      lastDobra = "Earth Arena"
    elseif ((upgradeStones == 17) and playerLevel == 4) then
      lastDobra = "Earth Curse"
    elseif ((upgradeStones == 18) and playerLevel == 4) then
      lastDobra = "Earth Quake"
    elseif ((upgradeStones == 19) and playerLevel == 4) then
      lastDobra = "Earth Cataclysm"
    elseif ((upgradeStones == 20) and playerLevel == 4) then
      lastDobra = "Earth Aura"
    elseif ((upgradeStones == 21) and playerLevel == 4) then
      lastDobra = "Earth Armor"
    elseif ((upgradeStones == 22) and playerLevel == 4) then
      lastDobra = "Earth Lavaball"
    elseif ((upgradeStones == 23) and playerLevel == 4) then
      lastDobra = "Earth Metalwall"
    else
      lastDobra = "Error - Reportar à administração do jogo."
    end

    local stringEN = "Paragon: "..getPlayerResets(cid)..".\nElemental Coins: "..coins..".\nBlessing: "..getBlessString(cid)..""..getArchangelString(cid)..".\nÚltima dobra aprimorada: "..lastDobra.."."
    local CDPassive, potExp, potRed = getColdownPassive(cid), getPotionExpString(cid), getPotionRedString(cid)
    local info = stringEN..CDPassive..potExp..potRed

    doSendPlayerExtendedOpcode(cid, InfoOpcode, info)

    players[cid] = true
    addEvent(function(cid) players[cid] = nil end, 5000, cid)
  else
    doPlayerSendCancel(cid, getLangString(cid, "You need wait a few moments to use it again.", "Você precisa esperar alguns instantes para usar isso novamente."))
  end
  return true
end