local spellName = "air barrier"
local cf = {atk = spellsInfo[spellName].atk, potencia = spellsInfo[spellName].slowPercent, tempo = spellsInfo[spellName].slowTempo, duracao = spellsInfo[spellName].duracao}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
setCombatArea(combat, createCombatArea(
		  {
		  {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 3, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0}
		  }))


function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/3)*2.7)+5
    local max = (level+(magLevel/3)*3.0)+5
	local dano = math.random(min, max)
	local atk = spellsInfo["air barrier"].atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
function onTargetCreature(creature, target)
 	local cid = creature:getId()
	return doSlow(cid, target, cf.potencia, cf.tempo)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")


local function effects(cid, pos, times)
if not isCreature(cid) or isInPz(cid) then return false end
local oldpos = getThingPos(cid)
if oldpos.x ~= pos.x or oldpos.y ~= pos.y or oldpos.z ~= pos.z then 
	doSendMagicEffect({x=oldpos.x+1, y=oldpos.y+1, z=oldpos.z}, 134)
end 
if times > 1 then 
addEvent(effects, 50, cid, oldpos, times-1)
end 
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
  if getPlayerExaust(cid, "air", "barrier") == false then
    return false
  end
    doPlayerAddExaust(cid, "air", "barrier", airExausted.barrier)
  if getPlayerHasStun(cid) then
        return true
    end
	local duracao = cf.duracao
	if getDobrasLevel(cid) >= 16 then
		duracao = duracao+2000
	end
	--doSlow(cid, cid, -25, duracao)
	exhaustion.set(cid, "AirBarrierReduction", duracao/1000)
		for i = 0, (duracao/500) do 
			addEvent(function()
				if isCreature(cid) and not isInPz(cid) then 
					local pos = getThingPos(cid)
					doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, 134)
					if i % 2 == 0 then 
						doCombat(cid, combat ,var)
					end
				end 
			end, 500*i)
		
		end 
		effects(cid, getThingPos(cid), duracao/50)
  return true 
end
