local mountsByVocAndId = {
[1] = {"nethersteed", "draptor", "magmacrawler", "firepanther", "horse", "blackpelt", "blazebringer", "doombringer"},
[2] = {"crystalwolf", "mantaray", "coralripper", "titanica", "ursagrodon", "jadepincer", "flitterkatzen", "jadelion"},
[3] = {"wacoon", "ironblight", "kinglydeer", "noblelion", "panda", "highlandyak", "slagsnare", "racingbird"},
[4] = {"kongra", "stampor", "carpacosaurus", "shockhead", "scorpionking", "tigerslug", "widowqueen", "dromedary"}
}

local cf = {itemid = 9693}
function onSay(cid, words, param, channel)
	if isCreature(cid) then 
		return true
	end
	local id = tonumber(param)
	if type(id) ~= "number" then 
		return true
	end 
--	if not isPremium(cid) then 
--		sendBlueMessage(cid, getLangString(cid, "Only premium account users can buy mounts.", "Somente jogadores com premium account podem comprar montarias."))
--		return true 
--	end 
	if getPlayerItemCount(cid, cf.itemid) == 0 then 
		sendBlueMessage(cid, getLangString(cid, "You don't have the required item to buy a mount.", "Você não possui o item necessário para comprar uma montaria."))
		return true 
	end 
	if id > 0 and id < 9 then 
		local mount = mountsByVocAndId[getPlayerVocation(cid)][id]
		if getPlayerStorageValue(cid, mount) ~= 1 and getPlayerStorageValue(cid, 93911) ~= 1 then  
			if doPlayerRemoveItem(cid, cf.itemid, 1) then 
				setPlayerStorageValue(cid, mount, 1)
				setPlayerStorageValue(cid, "activeMount", mount) 
				dismountPlayer(cid)
				doCreatureExecuteTalkAction(cid, "!mount")
			end
		else
			sendBlueMessage(cid, getLangString(cid, "You already have this mount.", "Você já tem essa montaria."))
		end 
	end
  return true
end