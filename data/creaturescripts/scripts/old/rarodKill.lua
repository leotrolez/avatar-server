local rarodRewardsEc = 
{
	[1] = {name = "Potion of Stamina Refill", count = 1, itemid = 12753},
	[2] = {name = "Supreme Bless Potion", count = 1, itemid = 12830},
	[3] = {name = "Strange Potion of Experience", count = 1, itemid = 12754},
	[4] = {name = "Stats Scroll", count = 1, itemid = 12466},
	[5] = {name = "Glooth Backpack", count = 1, itemid = 13375},
	[6] = {name = "Bender Scroll", count = 1, itemid = 13848},
	[7] = {name = "Glooth Backpack", count = 1, itemid = 13375},
	[8] = {name = "Bender Scroll", count = 1, itemid = 13848},
	[9] = {name = "Glooth Backpack", count = 1, itemid = 13375},
	[10] = {name = "Bender Scroll", count = 1, itemid = 13848},
	[11] = {name = "Glooth Backpack", count = 1, itemid = 13375},
	[12] = {name = "Bender Scroll", count = 1, itemid = 13848},
	[13] = {name = "Glooth Backpack", count = 1, itemid = 13375},
	[14] = {name = "Bender Scroll", count = 1, itemid = 13848},
	[15] = {name = "Glooth Backpack", count = 1, itemid = 13375},
	[16] = {name = "Bender Scroll", count = 1, itemid = 13848},
	[17] = {name = "Glooth Backpack", count = 1, itemid = 13375},
	[18] = {name = "Bender Scroll", count = 1, itemid = 13848},
	[19] = {name = "Glooth Backpack", count = 1, itemid = 13375},
	[20] = {name = "Bender Scroll", count = 1, itemid = 13848}
}

--[[ precisam ter a mesma quantia de elementos.. nao mexer sem consultar. 
 o elemento de ec eh dado qnd passa o test de seu test de porcentagem, caso contrario da o de free equivalente, 
 o primeiro e segundo eh 100 porcento por isso tem clonado no free
 o sistema garante que de somente 4 item de ec, sendo os 2 primeiros 100 porcento so sobrara outros 2 que passar pelo test de chance
 somente o numero de players presente na lista eh o numero de rolagens nos premios
 com um minimo de 3 players, no caso se um solar ele vai pegar os 2 primeiros e a chance da exp pot do terceiro ]]
 
local rarodRewardsItem = 
{
	[1] = {name = "Potion of Stamina Refill", count = 1, itemid = 12753},
	[2] = {name = "Supreme Bless Potion", count = 1, itemid = 12830},
	[3] = {name = "Crystal Coins", count = 10, itemid = 2160},
	[4] = {name = "Crystal Coins", count = 5, itemid = 2160},
	[5] = {name = "Crystal Coins", count = 4, itemid = 2160},
	[6] = {name = "Golden Legs", count = 1, itemid = 2470},
	[7] = {name = "Crystal Coins", count = 3, itemid = 2160},
	[8] = {name = "Crystal Coins", count = 2, itemid = 2160},
	[9] = {name = "Mastermind Shield", count = 1, itemid = 2514},
	[10] = {name = "Crystal Coin", count = 1, itemid = 2160},
	[11] = {name = "Crystal Coin", count = 1, itemid = 2160},
	[12] = {name = "Magic Plate Armor", count = 1, itemid = 2472},
	[13] = {name = "Platinum Coins", count = 50, itemid = 2152},
	[14] = {name = "Platinum Coins", count = 30, itemid = 2152},
	[15] = {name = "Platinum Coins", count = 20, itemid = 2152},
	[16] = {name = "Platinum Coins", count = 20, itemid = 2152},
	[17] = {name = "Platinum Coins", count = 20, itemid = 2152},
	[18] = {name = "Platinum Coins", count = 20, itemid = 2152},
	[19] = {name = "Platinum Coins", count = 10, itemid = 2152},
	[20] = {name = "Platinum Coins", count = 10, itemid = 2152}
}

local function sendMsgKillers(msg, killers)
	local quantia = #killers
	if quantia > 50 then
		quantia = 50
	end
	for i = 1, quantia do 
		if isCreature(killers[i]) and isPlayer(killers[i]) then
			doPlayerSendTextMessage(killers[i], 22, msg) 
		end
	end
end

local function doRewardPlayer(rarodName, cid, itemInfos, killers, rewardNumber)
	local artigo = getPlayerSex(cid) == 0 and "A jogadora" or "O jogador"
	local itemCount = itemInfos.count
	local itemName = itemInfos.name
	doPlayerAddItem(cid, itemInfos.itemid, itemInfos.count)
    addEvent(sendMsgKillers, 100+(50-rewardNumber), "["..rarodName.." - Reward] " .. artigo .. " " .. getPlayerName(cid) .. " recebeu "..itemCount.."x "..itemName.."!", killers)
    doSendMagicEffect(getCreaturePosition(cid), 27)
end

local chanceRewards = {100, 100, 20, 20, 10}
local function testReward(ecCount, rewardNumber)
	local chance = chanceRewards[5]
	if rewardNumber <= 4 then
		chance = chanceRewards[rewardNumber]
	end
	if ecCount < 5 and math.random(1, 100) <= chance then -- limita que nao passe de 4 itens de ec
		return {rarodRewardsEc[rewardNumber], ecCount+1}
	elseif ecCount < 5 and rewardNumber > #rarodRewardsEc-(4-ecCount) then -- garantir que sempre tenha 4 item de ec por rarod caso tenha 20+ players
		return {rarodRewardsEc[rewardNumber], ecCount+1}
	end
		return {rarodRewardsItem[rewardNumber], ecCount}
end

local function rollRewards(mostDamageKiller, rarodName)
		local ecCount = 0
		local rewardNumber = 1
		local forCount = 0
		local recompensa = {}
		for i = 1, #mostDamageKiller do
			if forCount > 50 or rewardNumber > 20 then
				break
			end
			if isCreature(mostDamageKiller[i]) and isPlayer(mostDamageKiller[i]) then
				recompensa = testReward(ecCount, rewardNumber)
				ecCount = recompensa[2]
				doRewardPlayer(rarodName, mostDamageKiller[i], recompensa[1], mostDamageKiller, rewardNumber)
				rewardNumber = rewardNumber + 1
			end
			if i == #mostDamageKiller and rewardNumber < 4 and isCreature(mostDamageKiller[i]) and isPlayer(mostDamageKiller[i]) then
				local restante = 4-rewardNumber -- testar colocando restante 19
				for j = 1, restante do
					recompensa = testReward(ecCount, rewardNumber+(j-1))
					ecCount = recompensa[2]
					doRewardPlayer(rarodName, mostDamageKiller[i], recompensa[1], mostDamageKiller, rewardNumber+(j-1))
				end
			end
			forCount = forCount + 1
		end
	return true
end

function onDeath(cid, corpse, mostDamageKiller)
	local rarods = {"Flaming Rarod", "Frozen Rarod", "Swamp Rarod"}
	local rarodName = getCreatureName(cid)
     if isMonster(cid) and isInArray(rarods,  string.lower(rarodName)) then -- testar rarods de quest
		addEvent(rollRewards, 100, mostDamageKiller, rarodName)
     end
	return true
end