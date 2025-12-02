local cf = {}
cf.cooldown = 4 -- cooldown
cf.effectx = 62 --DistanceEffect
cf.effectz = 178 --Effect

local function doTunnel(cid, time, beforeTarget)
	local nowTarget = getCreatureTarget(cid)
	if isCreature(cid) then
		if nowTarget == beforeTarget then
			local nowTargetPos = getCreaturePosition(nowTarget)
			local cidPos = getCreaturePosition(cid)
			if time < 8 then
				doSendDistanceShoot(cidPos, nowTargetPos, cf.effectx)
				doSendDistanceShoot(nowTargetPos, cidPos, cf.effectx)
				doSendMagicEffect({ x = cidPos.x + 5, y = cidPos.y + 3, z = cidPos.z }, cf.effectz)
				doSendMagicEffect({ x = nowTargetPos.x + 5, y = nowTargetPos.y + 3, z = nowTargetPos.z }, cf.effectz)
				addEvent(doTunnel, 250, cid, time+1, nowTarget)
			elseif time == 8 then
				doTeleportThing(cid, nowTargetPos)
				doTeleportThing(nowTarget, cidPos)	
				doSendMagicEffect({ x = cidPos.x + 5, y = cidPos.y + 3, z = cidPos.z }, cf.effectz)
				doSendMagicEffect({ x = nowTargetPos.x + 5, y = nowTargetPos.y + 3, z = nowTargetPos.z }, cf.effectz)
			end
		else
			doPlayerSendCancel(cid, "Target lost.")
		end
	end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "earth") == true then
		return false
	end
	  if getPlayerExaust(cid, "earth", "tunnel") == false then
		return false
	  end
	doPlayerAddExaust(cid, "earth", "tunnel", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	doTunnel(cid, 0, getCreatureTarget(cid))
	return true
end