local config = {
	bosses={---aid of portal, position where it sends, value it sets, text it shows
		[2006] = {pos={x=653, y=1542, z=12, stackpos=1}, value=1, text="Você entrou na caverna de cristal!"},
		[2007] = {pos={x=862, y=1547, z=15, stackpos=1}, value=2, text="Você entrou nos salões de sangue!"},
		[2008] = {pos={x=923, y=1546, z=12, stackpos=1}, value=3, text="Você entrou na caverna esquecida!"},
		[2009] = {pos={x=1017, y=1597, z=12, stackpos=1}, value=4, text="Você entrou na caverna do Arcano!"},
		[2010] = {pos={x=1321, y=1733, z=12, stackpos=1}, value=5, text="Você entrou na colméia!"},
		[2011] = {pos={x=1414, y=1648, z=9, stackpos=1}, value=6, text="Você entrou na caverna das sombras!"}
		},
	mainroom={---aid, position, lowest value that can use this portal, text
		[2001] = {pos={x=653, y=1542, z=12, stackpos=1}, value=1, text="Você entrou na caverna de cristal!"},
		[2002] = {pos={x=862, y=1547, z=15, stackpos=1}, value=2, text="Você entrou nos salões de sangue!"},
		[2003] = {pos={x=923, y=1546, z=12, stackpos=1}, value=3, text="Você entrou na caverna esquecida!"},
		[2004] = {pos={x=1017, y=1597, z=12, stackpos=1}, value=4, text="Você entrou na caverna do arcano!"},
		[2005] = {pos={x=1321, y=1733, z=12, stackpos=1}, value=5, text="Você entrou na colméia!"}	},
	portals={---aid, position, text
		[3000] = {pos={x=687, y=1371, z=11}, text="Você escapou de volta para o retiro!"},
		[3001] = {pos={x=746, y=1283, z=9}, text="Você entrou na sala de Ushuriel!"},
		[3002] = {pos={x=687, y=1539, z=9}, text="Você entrou no reino submarino!"},
		[3003] = {pos={x=799, y=1534, z=9}, text="Você entrou na sala de Zugurosh!"},
		[3004] = {pos={x=844, y=1522, z=12}, text="Você entrou no salão da agonia."},
		[3005] = {pos={x=891, y=1542, z=12}, text="Você entrou na sala de Madareth!"},
		[3006] = {pos={x=1027, y=1535, z=12}, text="Você entrou no campo de batalha!"},
		[3007] = {pos={x=1149, y=1538, z=12}, text="Você entrou na sala dos demônios gêmeos!"},
		[3008] = {pos={x=1206, y=1602, z=12}, text="Você entrou na sala das almas."},
		[3009] = {pos={x=1249, y=1732, z=12}, text="Você entrou na sala de Annihilon!"},
		[3010] = {pos={x=1376, y=1675, z=9}, text="Você entrou na sala de Hellgorak!"}	},
	storage=56123,---storage used in boss and mainroom portals
	e={}	}----dunno whats this but have to be like this to make doCreatureSayWithDelay working, DON'T TOUCH}
function onStepIn(cid, item, position, fromPosition)
	if isPlayer(cid) == TRUE then
		if(config.bosses[item.actionid]) then
			local t= config.bosses[item.actionid]
			if getPlayerStorageValue(cid, config.storage)< t.value then
				setPlayerStorageValue(cid, config.storage, t.value)
			end
			if item.actionid == 2006 and (getPlayerStorageValue(cid, 100079) < 4) then
				setPlayerStorageValue(cid, 100079, 4)
			elseif item.actionid == 2007 and (getPlayerStorageValue(cid, 100078) < 23) then
				setPlayerStorageValue(cid, 100078, 23) 
			elseif item.actionid == 2008 and (getPlayerStorageValue(cid, 100078) < 26) then
				setPlayerStorageValue(cid, 100078, 26) 
			elseif item.actionid == 2009 and (getPlayerStorageValue(cid, 100078) < 29) then
				setPlayerStorageValue(cid, 100078, 29) 
			elseif item.actionid == 2010 and (getPlayerStorageValue(cid, 100078) < 33) then
				setPlayerStorageValue(cid, 100078, 33)
			elseif item.actionid == 2011 and (getPlayerStorageValue(cid, 100080) < 2) then
				setPlayerStorageValue(cid, 100080, 2)
			end
			doTeleportThing(cid, t.pos)
			doSendMagicEffect(getCreaturePosition(cid),10)
			doCreatureSay(cid,t.text,19,1, config.e)
		elseif(config.mainroom[item.actionid]) then
			local t= config.mainroom[item.actionid]
			if getPlayerStorageValue(cid, config.storage)>=t.value then
				doTeleportThing(cid, t.pos)
				doSendMagicEffect(getCreaturePosition(cid),10)
				doCreatureSay(cid,t.text,19,1,config.e)
			else
				doTeleportThing(cid, fromPosition)
				doSendMagicEffect(getCreaturePosition(cid),10)
				doCreatureSay(cid, 'Você não tem energia suficiente para entrar neste portal!', TALKTYPE_ORANGE_1)
			end
		elseif(config.portals[item.actionid]) then
			local t= config.portals[item.actionid]
			if item.actionid == 3001 and (getPlayerStorageValue(cid, 100079) < 2) then
				setPlayerStorageValue(cid, 100079, 2)
			elseif item.actionid == 3003 and (getPlayerStorageValue(cid, 100079) < 5) then
				setPlayerStorageValue(cid, 100079, 5) 
			elseif item.actionid == 3005 and (getPlayerStorageValue(cid, 100078) < 24) then
				setPlayerStorageValue(cid, 100078, 24) 
			elseif item.actionid == 3007 and (getPlayerStorageValue(cid, 100078) < 27) then
				setPlayerStorageValue(cid, 100078, 27) 
			elseif item.actionid == 3008 and (getPlayerStorageValue(cid, 100078) < 30) then
				setPlayerStorageValue(cid, 100078, 30)
			elseif item.actionid == 3009 and (getPlayerStorageValue(cid, 100078) < 31) then
				setPlayerStorageValue(cid, 100078, 31)
			elseif item.actionid == 3010 and (getPlayerStorageValue(cid, 100078) < 34) then
				setPlayerStorageValue(cid, 100078, 34)
			end
			doTeleportThing(cid, t.pos)
			doSendMagicEffect(getCreaturePosition(cid),10)
			doCreatureSay(cid,t.text,19,1,config.e)
		end
	end
end
