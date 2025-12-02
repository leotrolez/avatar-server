local spellName = "earth whip"
local cf = {atk = spellsInfo[spellName].atk}

--focus ready--

local MyLocal = {}
MyLocal.areas = {}
MyLocal.players = {}
MyLocal.removeEvent = {}

local combat1Focus = createCombatObject()
setCombatParam(combat1Focus, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat5 = createCombatObject()
setCombatParam(combat5, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat6 = createCombatObject()
setCombatParam(combat6, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat7 = createCombatObject()
setCombatParam(combat7, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combat8 = createCombatObject()
setCombatParam(combat8, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)

local combats = {combat1Focus, combat1, combat2, combat3, combat4, combat5, combat6, combat7, combat8}

for x = 1, #combats do
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local multipler = 1
        local min = (level*2)+(magLevel/3)*2
        local max = (level*2.5)+(magLevel/3)*3
        if x == 1 then
            multipler = 2
        end
		if getPlayerInWaterWithUnderwater(cid) then 
			multipler = multipler*0.5
		end
	local dano = math.random(min, max) + math.random(8, 16)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
        return -dano*multipler, -dano*multipler
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
end

MyLocal.areas[1] = {{1, 3, 1}}
MyLocal.areas[2] = {{1, 2},
          {1, 0},
          {1, 0}}
MyLocal.areas[3] = {{2, 1},
          {0, 1},
          {0, 1}}
MyLocal.areas[4] = {{0, 2, 0},
          {0, 0, 0},
          {1, 1, 1}}

MyLocal.areas[5] = {{1, 3, 1}}
MyLocal.areas[6] = {{0, 2},{1, 0},{0, 0}}
MyLocal.areas[7] = {{2, 0},{0, 1},{0, 0}}
MyLocal.areas[8] = {{0, 2, 0},{0, 0, 0},{1, 1, 1}}
setCombatArea(combat1Focus, createCombatArea(MyLocal.areas[1]))

for x = 1, #MyLocal.areas do
  local combats = {combat1, combat2, combat3, combat4, combat5, combat6, combat7, combat8}
  setCombatArea(combats[x], createCombatArea(MyLocal.areas[x]))
end

local function removeTable(cid)
  MyLocal.players[cid] = nil
end

local effects = {
    {eff=215, desl = {x=1,y=0}}, 
    {eff=217, desl = {x=0,y=1}},
    {eff=216, desl = {x=1,y=0}},
    {eff=218, desl = {x=0,y=1}}
}

local function doCalculateEffect(cid, dir, isRedor)
    local posToEffect = getPositionByDirection(getThingPos(cid), dir)
	local posEff = {x=posToEffect.x+effects[dir+1].desl.x, y=posToEffect.y+effects[dir+1].desl.y, z=posToEffect.z}
	if isRedor then 
		if dir == 1 then 
			posEff.x = posEff.x+1
		elseif dir == 2 then 
			posEff.y = posEff.y+1
		end 
	end 
    doSendMagicEffect(posEff, effects[dir+1].eff)
end

function onCastSpell(creature, var)
  local cid = creature:getId()
  local combats = {combat1, combat2, combat3, combat4, combat5, combat6, combat7, combat8}

  if getSpellCancels(cid, "earth") == true then
    return false
  end
  if doPlayerAddExaust(cid, "earth", "whip", fireExausted.whip) == false then
    return false
  end
  if getPlayerHasStun(cid) then
    workAllCdAndAndPrevCd(cid, "earth", "whip", nil, 1)
    return true
  end

  if getPlayerOverPower(cid, "earth", true, true) then
    workAllCdAndAndPrevCd(cid, "earth", "whip", nil, 1)
    doCalculateEffect(cid, getCreatureLookDirection(cid))
    return doCombat(cid, combat1Focus, var)
  end
  if MyLocal.players[cid] ~= nil or getDobrasLevel(cid) >= 1 then
    for i = 1, 4 do
      doCalculateEffect(cid, i-1, true)
      doCombat(cid, combats[i+4], var)
      if MyLocal.removeEvent[cid] ~= nil then
        stopEvent(MyLocal.removeEvent[cid])
        MyLocal.removeEvent[cid] = addEvent(function() removeTable(cid) MyLocal.removeEvent[cid] = nil end, 3000)
      end
    end
    return true
  else
    MyLocal.players[cid] = true
    MyLocal.removeEvent[cid] = addEvent(function() removeTable(cid) MyLocal.removeEvent[cid] = nil end, 3000)
    doCalculateEffect(cid, getCreatureLookDirection(cid))
    return doCombat(cid, combats[1], var)
  end
end