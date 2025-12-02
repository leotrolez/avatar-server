local spellName = "fire overheat"
local cf = {}
cf.cooldown = 5

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 148)
setCombatArea(combat, createCombatArea(AREA_SQUARE1X1))

function onGetPlayerMinMaxValues(cid, level, magLevel)
	local vitality = getPlayerStorageValue(cid, "healthvalue")
	if not vitality then vitality = 0 end
	local mana = getPlayerStorageValue(cid, "manavalue")
	if not mana then mana = 0 end
	local dodge = getPlayerStorageValue(cid, "dodgevalue")
	if not dodge then dodge = 0 end
	local level = getPlayerLevel(cid)
	local magLevel = getPlayerMagLevel(cid)
	
    local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
    local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
	
	local dano = remakeValue(1, math.random(min, max), cid)	
return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

local config = {
	effectx = 3, --- efeito de distancia
	percent = 80, --- porcentagem de ir pra outro target apos hitar
	delay = 120 --- velocidade com que se move (milisegundos)
}

local function doBlastA(uid, target, delay, effectx, effectz, hits, fromPos, n)
	if fromPos ~= nil and (fromPos.x ~= getCreaturePosition(target).x or fromPos.y ~= getCreaturePosition(target).y) then
		doSendDistanceShoot(fromPos, getCreaturePosition(target), effectx)
		fromPos = (fromPos.x ~= getCreaturePosition(target).x or fromPos.y ~= getCreaturePosition(target).y) and getCreaturePosition(target) or nil
	else
		fromPos = getCreaturePosition(target)
	end	
	doCombat(uid, combat, {type=3, pos=fromPos})
	n = n or 1
	possible = {}
	for _, possivel in ipairs(getSpectators(fromPos, 2, 2)) do
		if isSightClear(fromPos, getCreaturePosition(possivel), true) and not isInPz(possivel) and not isImune(uid, possivel) and possivel ~= target and possivel ~= uid then
			table.insert(possible, possivel)
		end
	end
	target = #possible > 0 and possible[math.random(#possible)] or uid
	local range = getDistanceBetween(fromPos, getCreaturePosition(target))
	range = range > 0 and range or 1
	if n < hits then
		addEvent(function()
		if isCreature(uid) and isCreature(target) then
			doBlastA(uid, target, delay, effectx, effectz, hits, fromPos, (n + 1))
		end
		end, delay*range)
	end

return true
end

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "fire") == true then
       return false
	end
	if doPlayerAddExaust(cid, "fire", "overheat", cf.cooldown) == false then
       return false
	end
	if getPlayerHasStun(cid) then
       return true
	end
	local target = getCreatureTarget(cid)
	if getPlayerOverPower(cid, "fire", true, true) then
		doBlastA(cid, target, config.delay, config.effectx, config.effectz, 5, getCreaturePosition(cid), nil)
	end
	
	doBlastA(cid, target, config.delay, config.effectx, config.effectz, 5, getCreaturePosition(cid), nil)
return true
end