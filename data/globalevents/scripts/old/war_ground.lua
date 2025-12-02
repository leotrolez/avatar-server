local days = {
    ['Monday'] = {"21"},
    ['Tuesday'] = {"17"},
    ['Wednesday'] = {"21"},
    ['Thursday'] = {"17"},
    ['Friday'] = {"21"},
    ['Saturday'] = {"17"},
    ['Sunday'] = {"21"}
}
function canHaveWarg()
	local dayOfTheWeek = days[os.date("%A")]
	if dayOfTheWeek[1] == os.date("%H") then
		return true
	else
		return false
	end
end
local jaRolouWar = 0
function onTime(interval)
if jaRolouWar ~= 1 and canHaveWarg() then 
	addEvent(warCreateEvent, 600*1000)
	jaRolouWar = 1
	doBroadcastMessage("O portal para o evento War Ground será aberto em 10 minutos no depot de Ba Sing Se. Dobradores de nível 50 ou mais poderão participar!", MESSAGE_STATUS_WARNING)
end
return TRUE
end