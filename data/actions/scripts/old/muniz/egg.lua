local bossConfig = 
{
	name = "The Baron from Below",
	pos = {x=115, y=314, z=9},
	respawnCooldown = 30 * 60, -- em segundos
}

eggCooldownEnd = 0
brokenEggsCount = 0

local eggRespawn = 30*60*1000

local ovosQuebrados = {16830, 16831, 16832, 16833, 16834, 16835, 16836}
local ovosVivos = {16827, 16828, 16825, 16829, 16826, 16827, 16828}

local vivoToQuebrado = 
{
	["16825"] = 16832,
	["16826"] = 16834,
	["16827"] = 16835,
	["16828"] = 16836,
	["16829"] = 16833,

}

local function ressEgg(pos, newId, oldId)
	brokenEggsCount = brokenEggsCount-1
	local v = getTileItemById(pos, newId).uid
	if v > 0 then
		doTransformItem(v, oldId)
	end
end 

local function isEggCooldown()
	if os.time() <= eggCooldownEnd then
		return true
	end
	return false
end


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if isInArray(ovosVivos, item.itemid) and isEggCooldown() then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, getLangString(cid, "The eggs are still regenerating and cant be destroyed.", "Os ovos ainda estão se regenerando e não podem ser destruídos."))
		return true
	end
	if isInArray(ovosVivos, item.itemid) then
		if isCreature(lastBossCid) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT,  getLangString(cid, "The eggs are being protected by the Baron and cant be destroyed.", "Os ovos estão protegidos pelo Baron e não podem ser destruídos."))
			return true
		end
		doTransformItem(item.uid, vivoToQuebrado["" .. item.itemid])
		addEvent(ressEgg, eggRespawn, toPosition, vivoToQuebrado["" .. item.itemid], item.itemid)
		brokenEggsCount = brokenEggsCount+1
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		if brokenEggsCount >= 80 then
			doPlayerSendTextMessage(cid, 22,  getLangString(cid, "You did it, now he is mad. Run for your life.", "Você conseguiu irritar ele, parabéns. Agora fuja o quanto antes se deseja sobreviver."))
			lastBossCid = doCreateMonster(bossConfig.name, bossConfig.pos)
			eggCooldownEnd = os.time()+bossConfig.respawnCooldown
		else
			 doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT,  getLangString(cid, "Stop breaking the eggs! He will get angry.", "Pare de quebrar os ovos! Ele ficará enfurecido."))
		end
		return true
	end 
  return true
end
