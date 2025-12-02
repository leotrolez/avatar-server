-- posCentral é pos centro da sala pra checar range 10 dali se tem algum monstro neutro vivo, se range 10 for muito e acabar checando de outra sala diminua na linha que tem "getSpectators" o numero 10
-- destino é pra onde o tp leva
-- todo tp precisa ter terminado a missao do NPC pra entrar, o 46131 é o que começa a quest (sem check de monstro somente missao)
-- coloquei mais do que necessario so caso vc precise
-- sala do bau so usar o teleport azul comum mesmo pra sair, lembrando tb que na sala do bau n tem boss pra checar se ta vivo, vc so chega la passando pelo teleport do ultimo boss

local teleportsQuest = { 
[46131] =  {destino = {x=491, y=218, z=12}},
[46132] =  {posCentral = {x=488, y=209, z=12}, destino = {x=468, y=227, z=12}},
[46133] =  {posCentral = {x=472, y=234, z=12}, destino = {x=487, y=253, z=12}},
[46134] =  {posCentral = {x=488, y=260, z=12}, destino = {x=506, y=273, z=12}},
[46135] =  {posCentral = {x=514, y=272, z=12}, destino = {x=536, y=246, z=12}},
[46136] =  {posCentral = {x=529, y=244, z=12}, destino = {x=513, y=227, z=12}},
[46137] =  {posCentral = {x=519, y=218, z=12}, destino = {x=483, y=287, z=12}}
}

local function checkBossAlive(pos)
local specs = getSpectators(pos, 14, 14)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and not isSummon(specs[i]) then 
				return true
			end 
		end 
	end 
	return false
end 

function onStepIn(cid, item, position, fromPosition)
	if isMonster(cid) then 
		doTeleportThing(cid, fromPosition, true)
		return false
	end
	if item.actionid == 46138 then 
		doTeleportThing(cid, {x = 381, y = 160, z = 15}, true)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
		return true
	end 
	if getPlayerStorageValue(cid, "evilAvatarQuest") < 1 then
		doTeleportThing(cid, fromPosition, true)
		doCreatureSay(cid, "Você precisa de permissão para entrar.", TALKTYPE_ORANGE_1, false, cid)
		return false
	elseif item.actionid > 46131 then 
		if teleportsQuest[item.actionid].posCentral and checkBossAlive(teleportsQuest[item.actionid].posCentral) then
			doTeleportThing(cid, fromPosition, true)
			doCreatureSay(cid, "Você precisa matar os monstros próximos para entrar.", TALKTYPE_ORANGE_1, false, cid)
			return false
		else 
			doTeleportThing(cid, teleportsQuest[item.actionid].destino, false)
			doSendMagicEffect(position, CONST_ME_TELEPORT)
			doSendMagicEffect(teleportsQuest[item.actionid].destino, CONST_ME_TELEPORT)
		end
	else 
		doTeleportThing(cid, teleportsQuest[item.actionid].destino, false)
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doSendMagicEffect(teleportsQuest[item.actionid].destino, CONST_ME_TELEPORT)
	end 
	return true
end