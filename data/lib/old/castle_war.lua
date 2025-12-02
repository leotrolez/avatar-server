-- CASTLE WAR SYSTEM BY DANVES, 2015
-- FUNCTIONS LIST
-- castleWar.init() - inicia o evento
-- castleWar.close() - termina o evento, usado quando acaba o tempo
-- castleWar.makeOwner(cid) - torna a guild do cid a nova dona do castelo 
-- castleWar.isOnCastle(cid) - verifica se o usu?rio est? dentro da ilha(andar 7 ou voando)
-- castleWar.removeEnemies() - remove jogadores que est?o na ilha e n?o s?o da guild dominante 
-- castleWar.isInDominantGuild(cid) - checa se o cid ? membro da guild dominante
-- castleWar.isRunning() - checa se o evento est? rolando


local winnerStorage = 391893 -- storage com a guild name dominante 
local nameLever = 391894 -- storage com o nome do ?ltimo jogador que usou a lever
local runningStorage = 391895 -- storage caso 1 est? rolando o event
local teleportEnterFrom = {x=500,y=325,z=8} -- onde ? criado o tp pro evento
local teleportEnterTo = {x=1150,y=978,z=7} -- para onde o tp do evento leva
local teleportExit = {x=1159, y=924, z=4} -- local que abre um tp de sa?da para quem ficou dentro do castle(saiu da guild dominante l? dentro)
local townPos = {x=1152, y=941, z=7} -- pos do templo ba-sing-se, usado pra ser o destino do tp acima /\
local posPortao = {x=1152, y=930, z=7} -- pos do port?o a ser transformado em mob
local warMinutos = 30 -- dura??o do evento em minutos

local function removeItemPos(pos, id)
	local v = getTileItemById(pos, id).uid
return v > 0 and doRemoveItem(v)
end 

local function addItemPos(pos, id)
	local v = getTileItemById(pos, id).uid
	return v <= 0 and doCreateItem(id, 1, pos)
end 

castleWar =
{
	init = function ()
		--removeItemPos(teleportExit, 1387)
		removeItemPos(posPortao, 1547)
		doCreateMonster("Gate", posPortao)
		doSetStorage(runningStorage, 1)
	--	doCreateTeleport(1387, teleportEnterTo, teleportEnterFrom)
		addEvent(castleWar.close, warMinutos*60*1000)
		addEvent(function() doBroadcastMessage("[Evento - Castle War] O evento acabar? em 1 minuto!", MESSAGE_STATUS_CONSOLE_BLUE) end, (warMinutos-1)*60*1000)
		castleWar.animatedTexts()
		local specs = getSpectators(bloodconfig.positionTP, 1, 0)
		if specs and #specs >= 1 then 
			for i = 1, #specs do 
				local spec = specs[i]
				if getCreaturePosition(spec).x == bloodconfig.positionTP.x and getCreaturePosition(spec).y == bloodconfig.positionTP.y then 
					doTeleportThing(spec, {x = 502, y = 357, z = 7}, true)
				end
			end
		end 
		local tp = doCreateItem(1387, 1, bloodconfig.positionTP)
		doSendMagicEffect(bloodconfig.positionTP, 10)
		doSetItemActionId(tp, 58977)
		doBroadcastMessage("[Evento - Castle War] O Castle War foi aberto! Para todos que desejam participar, o portal se localiza no depot de Ba Sing Se. Somente dobradores com n?vel maior ou igual ? 50 podem entrar! ")
	end,
	
	close = function ()
			local t = getTileItemById(bloodconfig.positionTP, 1387)
			if t then
				doRemoveItem(t.uid, 1)
				doSendMagicEffect(bloodconfig.positionTP, CONST_ME_POFF)
			end
		if type(getStorage(winnerStorage)) == "string" then  
			doBroadcastMessage("[Castle War - Resultado] O jogador ("..getStorage(nameLever)..") dominou o castelo para sua guild ("..getStorage(winnerStorage)..")!", MESSAGE_STATUS_CONSOLE_BLUE)
		end
			castleWar.removeEnemies()
			--doCreateTeleport(1387, townPos, teleportExit)
			if getTopCreature(posPortao).uid > 0 then 
				doRemoveCreature(getTopCreature(posPortao).uid)
			end 
			addItemPos(posPortao, 1547)
			doSetStorage(runningStorage, 0)
	end,
	
	makeOwner = function (cid)
		doSetStorage(winnerStorage, getPlayerGuildName(cid))
		doSetStorage(nameLever, getCreatureName(cid))
	end,
	
	isOnCastle = function (cid)
		local pos = getCreaturePosition(cid)
		return pos.x>=1088 and pos.y>=866 and pos.z<=7 and pos.x<=1343 and pos.y<=1043 and pos.z>=0
	end,
	
	isInDominantGuild = function (cid)
		return getPlayerGuildName(cid) == getStorage(winnerStorage)
	end,
	
	isRunning = function ()
		return getStorage(runningStorage) == 1
	end,
	
	animatedTexts = function ()
		local guildName = getStorage(winnerStorage)
		if guildName == -1 then 
			guildName = ""
		end
		doSendAnimatedText({x=1153, y=937, z=4}, guildName, 215)
		doSendAnimatedText({x = 1145, y = 941, z = 7}, guildName, 215)
		return getStorage(runningStorage) == 1 and addEvent(castleWar.animatedTexts, 1000)
	end,
	
	removeEnemies = function ()
		for index, creature in ipairs(getPlayersOnline()) do
			if castleWar.isOnCastle(creature) then
				-- if not castleWar.isInDominantGuild(creature) then
					doCreatureAddHealth(creature, getCreatureMaxHealth(creature)-getCreatureHealth(creature))
					doTeleportThing(creature, getTownTemplePosition(getPlayerTown(creature)))
				-- end
			end
		end
		doSendMagicEffect(townPos, CONST_ME_TELEPORT)
	end
}
