local cf = {}
cf.cooldown = 11
cf.ticks = 40
cf.interval = 250

local area = createCombatArea{{3}}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)

local function getDmg(cid)
	local vitality = getPlayerStorageValue(cid, "healthvalue")
	if not vitality then vitality = 0 end
	local mana = getPlayerStorageValue(cid, "manavalue")
	if not mana then mana = 0 end
	local dodge = getPlayerStorageValue(cid, "dodgevalue")
	if not dodge then dodge = 0 end
	local level = getPlayerLevel(cid)
	local magLevel = getPlayerMagLevel(cid)
	
    local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0) + 5)
    local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0) + 25)
	
	local total = remakeValue(1, math.random(min, max), cid)		
	return total, total
end

local function burnSteps(cid, times, oldpos)
	if not isCreature(cid) then
		return false
	end	
	local old = {x=oldpos.x,y=oldpos.y,z=oldpos.z}
	local look = getCreatureLookDirection(cid)
	local pos = getCreaturePosition(cid)
	local new = {x=pos.x,y=pos.y,z=pos.z}
	
	local lookpos = {
	[0]={{x = pos.x + 1, y = pos.y, z = pos.z},{x = pos.x - 1, y = pos.y, z = pos.z},{x = pos.x, y = pos.y + 1, z = pos.z},{pos},129},
	[1]={{x = pos.x, y = pos.y - 1, z = pos.z},{x = pos.x, y = pos.y + 1, z = pos.z},{x = pos.x - 1, y = pos.y, z = pos.z},{pos},129},
	[2]={{x = pos.x - 1, y = pos.y, z = pos.z},{x = pos.x + 1, y = pos.y, z = pos.z},{x = pos.x, y = pos.y - 1, z = pos.z},{pos},129},
	[3]={{x = pos.x, y = pos.y + 1, z = pos.z},{x = pos.x, y = pos.y - 1, z = pos.z},{x = pos.x + 1, y = pos.y, z = pos.z},{pos},129}}
	
	if (old.x ~= new.x) or (old.y ~= new.y) or (old.z ~= new.z) then
		for i=1,4 do
			if not (isPzPos(lookpos[look][i])) then
				doSendMagicEffect(lookpos[look][i], 5)
				doCombatAreaHealth(cid, COMBAT_FIREDAMAGE, lookpos[look][i], area, -getDmg(cid), -getDmg(cid), lookpos[look][5])
				addEvent(function()
				if isCreature(cid) then
				doCombatAreaHealth(cid, COMBAT_FIREDAMAGE, lookpos[look][i], area, -getDmg(cid), -getDmg(cid), lookpos[look][5])
				end end,250)
				addEvent(function()
				if isCreature(cid) then
				doCombatAreaHealth(cid, COMBAT_FIREDAMAGE, lookpos[look][i], area, -getDmg(cid), -getDmg(cid), lookpos[look][5])
				end end,1000)
			end
		end	
	end
	
	if times < cf.ticks then	
		times = times + 1
		addEvent(burnSteps, cf.interval, cid, times, pos)
	end
end

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "fire") == true then
		return false
	end
	if getPlayerExaust(cid, "fire", "burnsteps") == false then
		return false
	end
	doPlayerAddExaust(cid, "fire", "burnsteps", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	local oldpos = getCreaturePosition(cid)
	doSendMagicEffect(oldpos, 185)
	addEvent(burnSteps, 500, cid, 1, oldpos)
	return true
end