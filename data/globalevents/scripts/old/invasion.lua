local days = {
    ['Monday'] = {"12"},
    ['Tuesday'] = {"14"},
    ['Wednesday'] = {"17"},
    ['Thursday'] = {"20"},
    ['Friday'] = {"18"},
    ['Saturday'] = {"23"},
    ['Sunday'] = {"22"}
}
function canHaveInvade()
	local dayOfTheWeek = days[os.date("%A")]
	if dayOfTheWeek[1] == os.date("%H") then
		return true
	else
		return false
	end
end

function sortearInvade()
	local rarodPoses = {
	{x=173, y=503, z=7},
	{x=467, y=409, z=6},
	{x=286, y=193, z=7}
	}
	local rarods = {"Flaming Rarod", "Swamp Rarod", "Frozen Rarod"}
	local sorteado = math.random(1, 3)
	local rarodName = rarods[sorteado]
	doCreateMonster(rarodName .. " Invade", rarodPoses[sorteado])
	doBroadcastMessage("[Raid] Cuidado todos os dobradores, o "..rarodName.." voltou e está procurando novas vítimas!", MESSAGE_STATUS_CONSOLE_BLUE)
end

local jaRolouInvade = 0
function onTime(interval) 
if jaRolouInvade ~= 1 and canHaveInvade() then
	sortearInvade() 
	jaRolouInvade = 1
end 
return TRUE
end