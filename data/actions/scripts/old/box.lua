-- vai ser random entre um dos 10, e cada um tem sub chances fazendo no final ser aquela chance que já tinhamos concordado, exemplo 0.5% cada parte do moon etc
local possibleItems = 
{
	[1] = {13635, 13830, 13853, 13435}, -- uma arma frozen
	[2] = {13842, 13442, 13456, 13762}, -- uma arma ogre
	[3] = {13751, 8901, 7888, 13375}, -- seaking boots, foldbook, glacier amulet, glooth backpack
	[4] = {12830}, -- supreme bless potion
	[5] = {12753}, -- stamina refill
	[6] = {12466}, -- stats scroll
	[7] = {18130, 18131, 18132, 18133}, -- rune iv
	[8] = {12864, 12861, 12853, 13296, 13086, 12872, 2123, 10219}, -- alguma arma do shop, ou southern ring ou sacred life amulet
	[9] = {12754, 12754, 12754, 13852, 12886}, -- 3 chance de cair pot de xp, 1 chance crystal helmet e 1 chance crystal chest
	[10] = {11117, 11117, 11117, 11117, 12781, 12781, 12781, 12781, 13914, 13914, 13914, 13914, 13401, 13402, 13403, 13404, 17860, 17862, 17863, 17861} -- 4 chance em cada crystal boots, shield, legs e apenas 1 cada parte do moon e arma legendary
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    doRemoveItem(item.uid, 1)
	local random = math.random(1, 10)
	local finalItem = possibleItems[random][math.random(1, #possibleItems[random])]
	doPlayerAddItem(cid, finalItem, 1)
	local itemName = getItemNameById(finalItem)
	if random <= 4 then  
		sendBlueMessage(cid, getLangString(cid, "You won 1x "..itemName..". Check your backpack!", "Você ganhou 1x "..itemName..". Cheque sua backpack!"))
	else 
		sendBlueMessage(cid, getLangString(cid, "Congratulations! You won 1x "..itemName..". Check your backpack!", "Parabéns! Você ganhou 1x "..itemName..". Cheque sua backpack!"))
	end
	doSendMagicEffect(getCreaturePosition(cid), 28)
  return true
end
