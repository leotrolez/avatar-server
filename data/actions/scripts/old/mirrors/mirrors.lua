function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid

	local currentPos = getCreaturePosition(cid)
	local monsterName = "Nightmare"
	local mirrors = {gate1 = 20389, gate = 20390, randomMirrors = 20391, backMirrors = 20392, questMirror = 20393}
	local mirrorsPosition = {
								gateEnterPos = {x=253, y=812, z=8},
								gateLeavePos = {x=238, y=657, z=9},
								firstRoom = {x=253, y=812, z=8},
								clockRoom = {x=230, y=842, z=8},
								questRoom = {x=230, y=891, z=8}
							}

	-- Gate
	if item.actionid == mirrors.gate then
			doCreatureSetStorage(cid, "onMirrors", 1)
			doTeleportCreature(cid, mirrorsPosition.gateEnterPos, 10)
			sendBlueMessage(cid, getLangString(cid, "Use a mirror and change your life.", "Use um espelho e mude a sua vida."))
	elseif item.actionid == mirrors.gate1 then
			doTeleportCreature(cid, mirrorsPosition.gateLeavePos, 10)
			sendBlueMessage(cid, getLangString(cid, "Back to almost-normal life.", "De volta à vida quase normal."))
	end

	-- Random Mirrors
	if item.actionid == mirrors.randomMirrors then
		local rand = math.random(1,10)
		if rand == 2 or rand == 3 then
			doTeleportCreature(cid, mirrorsPosition.clockRoom, 10)
			sendBlueMessage(cid, getLangString(cid, "Run to the gold mirror!", "Corra para o espelho dourado!"))
		elseif rand == 4 then
			doCreateMonster(monsterName, currentPos)
			doSendMagicEffect(cid, 2)
			sendBlueMessage(cid, getLangString(cid, "You freed spirits of darkness.", "Você libertou espíritos das trevas."))
		else
			sendBlueMessage(cid, getLangString(cid, "Sorry, for now nothing.", "Desculpe, por enquanto nada."))
			doSendMagicEffect(cid, 2)
		end
	end

	-- Back Mirrors
	if item.actionid == mirrors.backMirrors then
		doTeleportCreature(cid, mirrorsPosition.firstRoom, 10)
	end

	--Quest Mirrors
	if item.actionid == mirrors.questMirror then
		doTeleportCreature(cid, mirrorsPosition.questRoom, 10)
		sendBlueMessage(cid, getLangString(cid, "Be careful with Energy Rarod.", "Tenha cuidado com o Energy Rarod."))
	end

	return true
end