local mountsByVocAndId = {
[1] = {"nethersteed", "draptor", "magmacrawler", "firepanther", "horse", "blackpelt", "blazebringer", "doombringer", "blacksheep", "warbear", "ladybug", "hellgrip", "uniwheel"},
[2] = {"crystalwolf", "mantaray", "coralripper", "titanica", "ursagrodon", "jadepincer", "flitterkatzen", "jadelion", "blacksheep", "warbear", "ladybug", "hellgrip", "uniwheel"},
[3] = {"wacoon", "ironblight", "kinglydeer", "noblelion", "panda", "highlandyak", "slagsnare", "racingbird", "blacksheep", "warbear", "ladybug", "hellgrip", "uniwheel"},
[4] = {"kongra", "stampor", "carpacosaurus", "shockhead", "scorpionking", "tigerslug", "widowqueen", "dromedary", "blacksheep", "warbear", "ladybug", "hellgrip", "uniwheel"}
}

local freeMounts = {"blacksheep", "warbear", "uniwheel", "hellgrip", "ladybug"}
local function haveAllMounts(cid)
return getPlayerStorageValue(cid, 93911) == 1
end 

function onSay(cid, words, param, channel)
	if isCreature(cid) then 
		return true
	end
	local id = tonumber(param)
	if type(id) ~= "number" then 
		return true
	end 
	if id > 0 and id < 14 then 
		local mount = mountsByVocAndId[getPlayerVocation(cid)][id]
		if getPlayerStorageValue(cid, mount) == 1 or (haveAllMounts(cid)) then 
			setPlayerStorageValue(cid, "activeMount", mount) 
			dismountPlayer(cid)
			doCreatureExecuteTalkAction(cid, "!mount")
		else
			sendBlueMessage(cid, getLangString(cid, "Sorry, you don't have this mount.", "Desculpe, você não tem essa montaria."))
		end 
	end
  return true
end