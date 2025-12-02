local spellName = "air tempest"
local cf = {atk = spellsInfo[spellName].atk}


local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
--setCombatParam(combat, COMBAT_PARAM_EFFECT, 2)

function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = level+(magLevel/4)*0.3
    local max = level+(magLevel/4)*0.7
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeAirEarth(cid, dano)
    return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")


local arr ={{1, 1, 1},
           {1, 3, 1},
           {1, 1, 1}}

 setCombatArea(combat, createCombatArea(arr))


function onTargetCreature(creature, target)
  local cid = creature:getId()
	local tempest = getPlayerStorageValue(cid, "tempestAlvo")
	if isCreature(tempest) then 
		if tempest ~= target:getId() then
			doPushCreature(target, getDirectionTo(getCreaturePosition(tempest), getThingPos(target)), nil, nil, nil, isPlayer(tempest))
		end
	end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function removeTable(cid, exaust)
    if not isCreature(cid) then
        return true
    end
    if exaust then
        doPlayerAddExaust(cid, "air", "tempest", airExausted.tempest)
    end
    MyLocal.players[cid] = nil
end

local destsOne = {{-1, -1}, {0, -1}, {1, -1}, {-1, 0}}
local destsTwo = {{1, 1}, {0, 1}, {-1, 1}, {1, 0}}

local function sendCombat(cid, target, combatId, final)
    if not isCreature(cid) or not isCreature(target) then
        return true
    end
	local cidPos = getCreaturePosition(cid)
	local tgPos = getCreaturePosition(target)
	if getTileInfo(cidPos).protection or getTileInfo(tgPos).protection then return false end
    doCombat(cid, combatId, {type=2, pos=tgPos})
	doSendMagicEffect(tgPos, 120)
	local theRand = math.random(1, 4)
	if math.random(1, 2) == 1 then
		doSendDistanceShoot({x = tgPos.x+destsOne[theRand][1], y = tgPos.y+destsOne[theRand][2], z = tgPos.z}, {x = tgPos.x+destsTwo[theRand][1], y = tgPos.y+destsTwo[theRand][2], z = tgPos.z}, 45)
	else
		doSendDistanceShoot({x = tgPos.x+destsTwo[theRand][1], y = tgPos.y+destsTwo[theRand][2], z = tgPos.z}, {x = tgPos.x+destsOne[theRand][1], y = tgPos.y+destsOne[theRand][2], z = tgPos.z}, 45)
	end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "air") == true then
        return false
    end
  if getPlayerExaust(cid, "air", "tempest") == false then
    return false
  end
	local target = cid
	local mypos = getCreaturePosition(cid)
	local tgpos = {x=mypos.x,y=mypos.y,z=mypos.z}
	if getCreatureTarget(cid) > 0 then
		target = getCreatureTarget(cid)
		mypos = getCreaturePosition(cid)
		tgpos = getCreaturePosition(target)
		if not isSightClear(mypos, tgpos, true) or getDistanceBetween(mypos, tgpos) > 4 then
			if isPlayer(cid) then
				doPlayerSendCancel(cid, "Creature is not reachable.")
				doSendMagicEffect(mypos, 2, cid)
			end
			return false
		end
	end

	if getDobrasLevel(cid) >= 13 then
		doPlayerAddExaust(cid, "air", "tempest", airExausted.tempest-5)
	else
		doPlayerAddExaust(cid, "air", "tempest", airExausted.tempest)
	end
  if getPlayerHasStun(cid) then
        return true
    end
	setPlayerStorageValue(cid, "tempestAlvo", target)
	if target ~= cid then
		doSendDistanceShoot(mypos, tgpos, 48)
	end
    for x = 0, 10 do
        addEvent(sendCombat, 300*x, cid, target, combat, x == 10)
    end
	if isPlayer(cid) and getPlayerStorageValue(cid, "nuncaUsouTempest") ~= 1 then
		setPlayerStorageValue(cid, "nuncaUsouTempest", 1)
		sendBlueMessage(cid, "Dica: Existe duas vers�es da dobra Air Tempest. Utilize sem um alvo para afastar inimigos pr�ximos e com um alvo para usar de forma ofensiva.")
	end
	return true
end
