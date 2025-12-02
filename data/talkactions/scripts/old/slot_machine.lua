
local opcode      = 79
local apostaValue = 1000
local msg         = "Você não possui dinheiro suficiente para jogar."
local slotMachine = {
	['fire']  = { money = 20000},
	['water'] = { money = 10000},
	['air']   = { money = 5000},
	['earth'] = { money = 2500}
}

function randomElement()
  local chance  = math.random(100)
  local element = 'none'
  if (chance == 94) then
    element = 'fire'
  elseif ((chance == 40) or (chance == 89)) then
    element = 'water'
  elseif ((chance == 4) or (chance == 22) or (chance == 59) or (chance == 72)) then
    element = 'air'
  elseif ((chance == 2) or (chance == 29) or (chance == 35) or (chance == 42) or (chance == 53) or (chance == 62) or (chance == 79) or (chance == 96)) then
    element = 'earth'
  end
  return element
end

function onSay(cid, words, param)

if (getPlayerInPos(cid, {x=504,y=357}, {x=504,y=357}, 5) or getPlayerInPos(cid, {x=506,y=357}, {x=506,y=357}, 5) or getPlayerInPos(cid, {x=508,y=357}, {x=508,y=357}, 5) or getPlayerInPos(cid, {x=510,y=357}, {x=510,y=357}, 5)) and not exhaustion.check(cid, "cassino") then
  if ( param == 'start' ) then
    if ( doPlayerRemoveMoney(cid, apostaValue) ) then
      local element = randomElement()
      if ( element ~= 'none' ) then	    
        doPlayerAddMoney(cid, slotMachine[element].money)
        if (element == 'fire') then
		      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você ganhou 20k (20.000 gps).")
        elseif (element == 'water') then
          doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você ganhou 10k (10.000 gps).")
        elseif (element == 'air') then
          doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você ganhou 5k (5.000 gps).")
        else
          doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você ganhou 2.5k (2.500 gps).")
        end
      end
        doSendPlayerExtendedOpcode(cid, opcode, 'start>'..element)
        exhaustion.set(cid, "cassino", 2)
  else
    doSendPlayerExtendedOpcode(cid, opcode, 'msgErro>'..msg)
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, msg)
	end		
  end	
  return true
else
  doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Utilize a máquina do cassino para apostas.")
end
end