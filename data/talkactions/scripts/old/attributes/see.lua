
local atributosList = {"health", "bend", "speed", "dodge"}

function onSay(cid, words, param, channel)
	if param == "" or not getPlayerByNameWildcard(param) then 
		return true 
	end
	local target = getPlayerByNameWildcard(param)
	local string = ""..getPlayerName(target).." Stats: \n"
	for i = 1, #atributosList do 
		local storageAtributo = atributosList[i] .. "value"
		storageAtributo = getPlayerStorageValue(target, storageAtributo)
		storageAtributo = storageAtributo > 1 and storageAtributo or 1
		string = string.. "• "..atributosList[i]..": "..storageAtributo.."\n"
	end 
	doPlayerPopupFYI(cid, string)
return true 
end