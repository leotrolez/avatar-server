local cf = {}
cf.cooldown = 1
cf.ticks = 20
cf.interval = 100

local area = createCombatArea{{3}}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 50)

local function getDmg(cid)
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
	
	local dano = remakeValue(3, math.random(min, max), cid)	
return dano
end

local function burnSteps(cid, times, oldpos, target)


	local old = {x=oldpos.x,y=oldpos.y,z=oldpos.z}
	local pos = getCreaturePosition(target)
	local new = {x=pos.x,y=pos.y,z=pos.z}
	
	if (old.x ~= new.x) or (old.y ~= new.y) or (old.z ~= new.z) then
		for i=1,3 do
			doSendMagicEffect(pos, 50)		
			addEvent(function()
			if isCreature(target) then
			doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -getDmg(cid), -getDmg(cid), 50)
			end
			end, 500)			
		end	
	end
	
	if times < cf.ticks then	
		times = times + 1
		addEvent(function ()
		if isCreature(target) then
		burnSteps(cid, times, pos, target)
		end 
		end, cf.interval)
	end
	
end

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "torment") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "torment", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	local target = variantToNumber(var)
	local oldpos = getCreaturePosition(target)
	doSendAnimatedText(getCreaturePosition(target), "Tormented!", 215)
	addEvent(burnSteps, 500, cid, 1, oldpos, target)
	return true
end