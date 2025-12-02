function onSay(player, words, param)
	local cid = player:getId()
    _G.cid = cid
	local f, err = loadstring(param)
	if f then
		local ret,err = pcall(f)
		if not ret then
			doPlayerSendTextMessage(cid, 25,'Lua error:\n'..err)
		end
	else
		doPlayerSendTextMessage(cid, 25,'Lua error:\n'..err)
	end
	return true
end