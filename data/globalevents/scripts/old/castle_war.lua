local jaRolouCastle = 0
function onTime(interval)
if jaRolouCastle ~= 1 then 
	addEvent(function() castleWar.init() end, 600*1000)
	jaRolouCastle = 1
	doBroadcastMessage("O portal para o evento Castle War será aberto em 10 minutos no depot de Ba Sing Se. Dobradores de nível 50 ou mais poderão participar! É um evento de Guild vs Guild, a Guild vencedora recebe 15% de bônus exp enquanto for a dona do Castle.", MESSAGE_STATUS_WARNING)
end
return TRUE
end