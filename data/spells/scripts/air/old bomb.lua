local spellName = "air bomb"
local cf = {atk = spellsInfo[spellName].atk, segundosParaExplosao = spellsInfo[spellName].segundosParaExplosao}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 42)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combat2, COMBAT_PARAM_EFFECT, 2)
setCombatArea(combat2, createCombatArea(
      {
      {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 2, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0}
      }))


function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.16)+10
    local max = (level+(magLevel/3)*2.4)+10
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.16)+10
    local max = (level+(magLevel/3)*2.4)+10
	local dano = math.random(min, max)
	local atk = spellsInfo["air bomb"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
    return -dano, -dano
end
setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
  local random = math.random(0, 3)
  for i = 1, 2 do 
    addEvent(function() if isCreature(cid) and isCreature(target) then doPushCreature(target, random, nil, nil, nil, isPlayer(cid)) end 
      end, i*50)
  end 
 return doPushCreature(target, random, nil, nil, nil, isPlayer(cid))
end

setCombatCallback(combat2, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")



local function doBomb(cid, combat, var, times)
times = times or cf.segundosParaExplosao
local target = variantToNumber(var)
if not isCreature(cid) or not isCreature(target) then return false end
  if times < 1 then
    if isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) then 
      doCombat(cid, combat, var)
      doCombat(cid, combat2, var)
      local targpos = getCreaturePosition(target)
      doSendAnimatedText(targpos, "Booom!", 215)
      doSendMagicEffect({x=targpos.x+1, y=targpos.y+1, z=targpos.z}, 122)
      doSendMagicEffect({x=targpos.x, y=targpos.y, z=targpos.z}, 126)
    end
    return false 
  else 
	local targpos = getCreaturePosition(target)
    addEvent(doSendAnimatedText, 50, targpos, ""..times.."", 215)
  end 
return isCreature(cid) and isCreature(target) and not isInPz(cid) and not isInPz(target) and addEvent(doBomb, 1000, cid, combat, var, times-1)
end
function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
  if getPlayerExaust(cid, "air", "bomb") == false then
    return false
  end
	if getDobrasLevel(cid) >= 12 then
		doPlayerAddExaust(cid, "air", "bomb", airExausted.bomb-2)
	else
		doPlayerAddExaust(cid, "air", "bomb", airExausted.bomb)
	end
  if getPlayerHasStun(cid) then
        return true
    end
  
  doCombat(cid, combat, var)
  doSendDistanceShoot(getThingPos(cid), getThingPos(variantToNumber(var)), 42)
  doBomb(cid, combat, var) 
  return true 
end
