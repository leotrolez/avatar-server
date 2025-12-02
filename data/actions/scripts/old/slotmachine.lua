
local opcode = 79       

function onUse(cid, item, frompos, item2, topos)
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Cada giro custa 1k (1.000 gps).")
	doSendPlayerExtendedOpcode(cid, opcode, 'open>')
	return true
end