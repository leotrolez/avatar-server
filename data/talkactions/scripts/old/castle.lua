function onSay(cid, words, param, channel)
	local guild = getStorage(391893)
	if guild ~= -1 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "A última guild dominadora do Castle War foi a: "..guild..".")
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Nenhuma guild dominou o Castle War até agora.")
	end
return TRUE
end