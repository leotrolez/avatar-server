
local opcode      = 202
local apostaValue = 20000
local msg         = "Você não possui dinheiro suficiente para jogar."
local slotMachineVermelho = {
	['fire']  = { money = 400000},
	['water'] = { money = 200000},
	['air']   = { money = 100000},
	['earth'] = { money = 50000}
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

if (getPlayerInPos(cid, {x=512,y=357}, {x=512,y=357}, 5) or getPlayerInPos(cid, {x=514,y=357}, {x=514,y=357}, 5) or getPlayerInPos(cid, {x=516,y=357}, {x=516,y=357}, 5) or getPlayerInPos(cid, {x=518,y=357}, {x=518,y=357}, 5)) and not exhaustion.check(cid, "cassinovermelho") then
  if ( param == 'start' ) then
    if ( doPlayerRemoveMoney(cid, apostaValue) ) then
      local element = randomElement()
      if ( element ~= 'none' ) then	    
        doPlayerAddMoney(cid, slotMachineVermelho[element].money)
        if (element == 'fire') then
		      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você ganhou 400k (400.000 gps).")
        elseif (element == 'water') then
          doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você ganhou 200k (200.000 gps).")
        elseif (element == 'air') then
          doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você ganhou 100k (100.000 gps).")
        else
          doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você ganhou 50k (50.000 gps).")
        end
      end
        doSendPlayerExtendedOpcode(cid, opcode, 'start>'..element)
        exhaustion.set(cid, "cassinovermelho", 2)
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