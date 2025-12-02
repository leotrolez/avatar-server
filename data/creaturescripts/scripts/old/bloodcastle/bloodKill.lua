
function onKill(cid, target, lastHit)
	if isMonster(target) then
		if isSummon(target) then
			return true
		end
		bloodAddKills(cid, 1)
	end
  return true
end