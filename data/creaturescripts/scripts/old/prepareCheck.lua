local function isSamePosition(pos1, pos2)
	if pos1.x ~= pos2.x then
		return false
	elseif pos1.y ~= pos2.y then
		return false
	elseif pos1.z ~= pos2.z then
		return false
	end
	return true
end

function onPrepareDeath(cid, deathList)
 if castleWar.isOnCastle(cid) then 
  doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid), true)
  doCreatureAddMana(cid, getCreatureMaxMana(cid)-getCreatureMana(cid))
	if not getTileInfo(getCreaturePosition(cid)).hardcore then
    setCreatureNoMoveTime(cid, 5000)
  doPlayerSetPzLocked(cid, false)
		return false
	end
	
	addEvent(function() if isCreature(cid) then doTeleportThing(cid, {x=1152, y=941, z=7}) end end, 50)
    setCreatureNoMoveTime(cid, 5000)
  doPlayerSetPzLocked(cid, false)
	return true
 end 
 if isSamePosition(getCreaturePosition(cid), getTownTemplePosition(getPlayerTown(cid))) then
  doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid), true)
  doCreatureAddMana(cid, getCreatureMaxMana(cid)-getCreatureMana(cid))
	return false
 end
 if getTileInfo(getThingPos(cid)).optional then 
    if isInArea(getThingPos(cid), bloodconfig.fromPos, bloodconfig.toPos) then
		  local bloodKills = bloodGetKills(cid)
		  if bloodKills <= 0 then 
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você não matou monstros no Blood Castle, portanto não receberá recompensa. Boa sorte na próxima vez!")
			else 
				local myLevel = getPlayerLevel(cid)
				local finalExp = myLevel * 30
				finalExp = finalExp * (bloodKills+5)
				doPlayerAddExperience(cid, finalExp)
				doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você derrotou "..bloodKills.." monstros no Blood Castle e recebeu um bônus de "..finalExp.." pontos de EXP!")
		  end 
	end
  doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid), true)
  doCreatureAddMana(cid, getCreatureMaxMana(cid)-getCreatureMana(cid))
  doTeleportThing(cid, bloodconfig.templo)

  return false
 end 
 if isInWarGround(cid) then 
	doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid), true)
	doCreatureAddMana(cid, getCreatureMaxMana(cid)-getCreatureMana(cid))
	addEvent(function() if isCreature(cid) then doTeleportThing(cid, bloodconfig.templo) end end, 50)
	
	setPlayerStorageValue(cid, "timeWar", 0)
	local warKills = getPlayerStorageValue(cid, "warKills")
	if warKills <= 50000 then 
		--doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você não matou ninguém no War Ground, portanto não receberá recompensa. Boa sorte na próxima vez!")
		local myLevel = getPlayerLevel(cid)
		local finalExp = myLevel * 35
		finalExp = finalExp * 57
		doPlayerAddExperience(cid, finalExp)
		doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Pela sua participação no War Ground, você recebeu "..finalExp.." pontos de EXP!")
	else 
		local myLevel = getPlayerLevel(cid)
		local finalExp = myLevel * 35
		finalExp = finalExp * (warKills+5)
		doPlayerAddExperience(cid, finalExp)
		doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você derrotou "..warKills.." jogadores no War Ground e recebeu "..finalExp.." pontos de EXP!")
	 end 
	if getPlayerStorageValue(cid, "estavaNon") == 1 then 
		setPlayerStorageValue(cid, "estavaNon", 0)
		setPlayerStorageValue(cid, "Archangel", 1)
		setPlayerStorageValue(cid, "canAttackable", 1)
	end 
	if isInParty(cid) then 
		doPlayerLeaveParty(cid, true)
	end
	-- doRemoveCondition(cid, CONDITION_INFIGHT)
	--[[ if deathList and #deathList > 0 then 
		for i = 1, #deathList do 
			if isCreature(deathList[i]) and isPlayer(deathList[i]) and getPlayerStorageValue(deathList[i], "timeWar") ~= getPlayerStorageValue(cid, "timeWar") then
				warKill(deathList[i], cid)
			end
		end 
	end ]]
	doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid))
			doPlayerSetPzLocked(cid, false)
			doCreatureSetNoMove(cid, false)
	addEvent(checkWarEnd, 100)
  return true
 end 
    return true
end