
local opcode = 202       

function onUse(cid, item, frompos, item2, topos)
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Cada giro custa 20k (20.000 gps).")
	doSendPlayerExtendedOpcode(cid, opcode, 'open>')
	return true
end