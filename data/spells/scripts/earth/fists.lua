local spellName = "earth fists"
local cf = {atk = spellsInfo[spellName].atk}


local MyLocal = {}
MyLocal.players = {}
MyLocal.positions = {}
positionsimune = {}

local effects = {
[0] = 99, -- efeito pra /\
[1] = 97, -- efeito pra > 
[2] = 100, -- efeito pra \/
[3] = 98 -- efeito pra <
}
local xizes = {
[0] = 0,
[1] = 3,
[2] = 0,
[3] = -1,
}
local yizes = {
[0] = -1,
[1] = 0,
[2] = 3,
[3] = 0
}
local xizes2 = {
[0] = 1,
[1] = 3,
[2] = 1,
[3] = -1,
}
local yizes2 = {
[0] = -1,
[1] = 1,
[2] = 3,
[3] = 1
}
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatArea(combat, createCombatArea(
      {
      {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 3, 1, 0, 0}
      }))

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatArea(combat2, createCombatArea(
      {
      {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 1, 1, 0, 0},
          {0, 0, 1, 3, 1, 0, 0}
      }))
      
local combats = {combat, combat2}

for x = 1, #combats do
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level+(magLevel/5)*6.5)+math.random(35, 45)
        local max = (level+(magLevel/5)*7.5)+math.random(45, 60)
      if x > 0 then 
        min = min*1.5
		max = max*1.5
      end 
      if getPlayerInWaterWithUnderwater(cid) then 
        min = min*0.6 
        max = max*0.6
      end 

	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
    end
setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end


function onTargetCreature(creature, target)
  local cid = creature:getId()
 return doSlow(cid, target, 40, 3000)
end

setCombatCallback(combat2, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function removeTable(cid)
    MyLocal.players[cid] = nil
end



function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
    if getPlayerExaust(cid, "earth", "fists") == false then
        return false
    end
    if MyLocal.players[cid] == nil then
     positionsimune = {}
		if getDobrasLevel(cid) >= 15 then
         doPlayerAddExaust(cid, "earth", "fists", earthExausted.fists-3)
		else
         doPlayerAddExaust(cid, "earth", "fists", earthExausted.fists)
		 end
            if getPlayerHasStun(cid) then
                workAllCdAndAndPrevCd(cid, "earth", "fists", nil, 1)
                return true
            end
            MyLocal.players[cid] = 0
            addEvent(removeTable, 260, cid)
      --setCreatureNoMoveTime(cid, 260)
            workAllCdAndAndPrevCd(cid, "earth", "fists", nil, 1)
      local mypos = getCreaturePosition(cid)
      local dir = getCreatureLookDirection(cid)
      doSendMagicEffect({x=mypos.x+xizes[dir], y=mypos.y+yizes[dir], z=mypos.z}, effects[dir])
      doSendMagicEffect({x=mypos.x+xizes2[dir], y=mypos.y+yizes2[dir], z=mypos.z}, effects[dir])
      addEvent(function ()  if isCreature(cid) and not isInPz(cid) then 
                    doCombat(cid, combat2, var) 
                  end 
          end, 250)
            return doCombat(cid, combat, var)
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end
