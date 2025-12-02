local function changeAutoloot(cid, value)
	if type(value) ~= "string" or (value ~= "false" and value ~= "true") then
		return true
	end
	if value == "true" then
		setPlayerStorageValue(cid, "autolootdesativo", 0)
	else
		setPlayerStorageValue(cid, "autolootdesativo", 1)
	end
end

local opcodeMarket = 230
local opcodeReward = 247

local OPCODE_PLAYERSPELLS 	 = 50
local OPCODE_SPELLTREE_LEARN = 51

function onExtendedOpcode(cid, opcode, buffer)
	if opcode == 40 then
		if getPlayerLevel(cid) < 20 or getPlayerStorageValue(cid, "canAttackable") == 1 then
			doSendPlayerExtendedOpcode(cid, 91, "inativo")
		else
			doSendPlayerExtendedOpcode(cid, 91, "ativo")
		end
		return doSendPlayerExtendedOpcode(cid, 40, getAtributosString(cid))
	elseif opcode == opcodeReward then
	  --[[if ( buffer == "send" ) then
	    Reward.sendRewards(cid)
	  elseif ( buffer == "get" ) then
	    Reward.getReward(cid)
	  elseif ( buffer == "date" ) then
	    Reward.sendRewards(cid)
	  end]]
	elseif opcode == 131 then
		--changeAutoloot(cid, buffer)
	elseif opcode == OPCODE_PLAYERSPELLS then
		sendPlayerSpells(cid)
	elseif opcode == OPCODE_SPELLTREE_LEARN then
		local t = string.split(buffer, ";")
		doPlayerLearnSpellTree(cid, tonumber(t[1]), t[2])
	elseif opcode > 0 and opcode < 4 then
		onReceiveOpCode[opcode](cid, opcode, buffer) --busca instrução na lib 203-serverToOTC
	end
	return true
end
