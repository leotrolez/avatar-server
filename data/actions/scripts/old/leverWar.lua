local winnerStorage = 391893
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
local toPosition = {x=1153, y=938, z=4}
if getPlayerGuildId(cid) == 0 then 
	doCreatureSay(cid, "Você não participa de nenhuma guild.", TALKTYPE_ORANGE_1, false, cid)
	return false 
elseif not castleWar.isRunning() then 
	doCreatureSay(cid, "Você só pode dominar o castelo enquanto o evento estiver aberto.", TALKTYPE_ORANGE_1, false, cid)
	return false 
elseif getPlayerGuildName(cid) == getStorage(winnerStorage) then 
	doCreatureSay(cid, "Sua guild já está dominando o castelo!", TALKTYPE_ORANGE_1, false, cid)
	return false 
end 
if item.itemid == 9826 then 
	doCreatureSay(cid, "A alavanca poderá ser puxada novamente em poucos segundos.", TALKTYPE_ORANGE_1, false, cid)
	return false 
end 
castleWar.makeOwner(cid)
doTransformItem(item.uid, 9826)
addEvent( function () 
						doTransformItem(getTileItemById({x=1153, y=938, z=4}, 9826).uid, 9825)
		end, 10000)
doSendMagicEffect(getCreaturePosition(cid), 28)
doCreatureSay(cid, "O castelo foi dominado pela guild "..getPlayerGuildName(cid).."!", TALKTYPE_ORANGE_1, false, 0, toPosition)
doSetItemText(getTileItemById({x=1153, y=937, z=4}, 1441).uid, getPlayerGuildName(cid))
return true 
end 