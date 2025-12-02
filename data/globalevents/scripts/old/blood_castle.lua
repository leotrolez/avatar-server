local days = {
    ['Monday'] = {"17"},
    ['Tuesday'] = {"21"},
    ['Wednesday'] = {"17"},
    ['Thursday'] = {"21"},
    ['Friday'] = {"17"},
    ['Saturday'] = {"21"},
    ['Sunday'] = {"17"}
}
function canHaveBloodc()
	local dayOfTheWeek = days[os.date("%A")]
	if dayOfTheWeek[1] == os.date("%H") then
		return true
	else
		return false
	end
end
local jaRolouBlood = 0
function onTime(interval)
if jaRolouBlood ~= 1 and canHaveBloodc() then 
	addEvent(bloodCreateEvent, 600*1000)
	jaRolouBlood = 1
	doBroadcastMessage("O portal para o evento Blood Castle será aberto em 10 minutos no depot de Ba Sing Se. Dobradores de nível 50 ou mais poderão participar! É um evento non-pvp voltado à exp e prêmio extra para last hit no boss.", MESSAGE_STATUS_WARNING)
end
return TRUE
end