--[[
 * File destinado á comunicação server -> DLL. (barra de moves, etc)
]]--

fireSpells = { --[[MUITO IMPORTANTE: Tem que estar na ordem dos leveis.]]
  "firewhip",
  "firerecover",
  "firekick",
  "fireskyfall",
  "firejump",
  "fireimpulse",
  "firebolt",
  "fireres",
  "firestar",
  "firecannon",
  "firewrath",
  "firefocus",
  "firelightning",
  "firebomb",
  "fireclock",
  "firethunderbolt",
  "firemeteor",
  "firestriker",
  "fireoverload",
  "fireexplosion",
  "firevoltage",
  "firethunderstorm",
  "firedischarge",
  "fireconflagration",
  "firesearcher"
}

earthSpells = { --[[MUITO IMPORTANTE: Tem que estar na ordem dos leveis.]]
  "earthcrush",
  "earthrecover",
  "earthpunch",
  "earthrock",
  "earthjump",
  "earthpull",
  "earthgrowth",
  "earthcollapse",
  "earthtrack",
  "earthpetrify",
  "earthfury",
  "earthcontrol",
  "earthleech",
  "earthsmash",
  "earthingrain",
  "earthfists",
  "eartharena",
  "earthcurse",
  "earthquake",
  "earthcataclysm",
  "earthaura",
  "eartharmor",
  "earthlavaball",
  "earthmetalwall",
  "earthsearcher"
}

waterSpells = { --[[MUITO IMPORTANTE: Tem que estar na ordem dos leveis.]]
  "waterwhip",
  "waterrecover",
  "waterexplosion",
  "waterheal",
  "waterjump",
  "watericeSpikes",
  "waterres",
  "watershards",
  "watersurf",
  "watercannon",
  "waterregen",
  "waterbloodControl",
  "waterpunch",
  "waterdragon",
  "waterrain",
  "waterbubbles",
  "waterprotect",
  "watericebolt",
  "waterflow",
  "watericeGolem",
  "watertsunami",
  "waterclock",
  "waterblizzard",
  "waterbloodBending",
  "watersearcher"
}

airSpells = { --[[MUITO IMPORTANTE: Tem que estar na ordem dos leveis.]] 
  "airball",
  "airrecover",
  "airburst",
  "airrun",
  "airjump",
  "airforce",
  "airgust",
  "airgale",
  "airboost",
  "airfan",
  "airwings",
  "airsuffocation",
  "airhurricane",
  "airtempest",
  "airwindblast",
  "airtornado",
  "airbarrier",
  "airtrap",
  "airdoom",
  "airbomb",
  "airwindstorm",
  "airstormcall",
  "airvortex",
  "airdeflection",
  "airsearcher"
}

function sendCDToClient(cid, element, spellname, time)
  if time == 0 or time == nil or not (isPlayer(cid)) then
    return true
  end

  trySpellExp(cid, string.lower(element), string.lower(spellname)) -- treina spell

  local tableElement = {
    ["fire"] = fireSpells, 
    ["water"] = waterSpells,
    ["earth"] = earthSpells,
    ["air"] = airSpells
  }
  
  if tableElement[element] ~= nil then
    for x = 1, #tableElement[element] do
      if tableElement[element][x] == element..spellname then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "#m#"..x..","..time..";")
        return true
      end
    end
  end
end

function sendPrevCDToClient(cid, element, spellname, time)
  if time == 0 or time == nil or not (isPlayer(cid)) then
    return true
  end
  local elementId = getElementId(element)
  local tableElement = {
    ["fire"] = fireSpells, 
    ["water"] = waterSpells,
    ["earth"] = earthSpells,
    ["air"] = airSpells
  }
  
  if tableElement[element] ~= nil then
    for x = 1, #tableElement[element] do
      if tableElement[element][x] == element..spellname then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "#m#"..x..","..-time..";")
        return true
      end
    end
  end
end

function workAllCdAndAndPrevCd(cid, element, spellname, time, timeAllExausteds)
  if (timeAllExausteds == nil or timeAllExausteds <= 1) and (time == 0 or time == nil) or not (isPlayer(cid)) then
    return true
  end
  local stringToSend = ""
  local elementId = getElementId(element)
  local tableElement = {
  ["fire"] = fireSpells, 
  ["water"] = waterSpells,
  ["earth"] = earthSpells,
  ["air"] = airSpells
  }  

  if tableElement[element] ~= nil then
    if timeAllExausteds > 1 then
      local currentTime = os.time()

      for x = 1, #tableElement[element] do
        local delayTime = getPlayerStorageValue(cid, "exausted"..tableElement[element][x])
        if tableElement[element][x] ~= element..spellname then
          if delayTime <= currentTime+timeAllExausteds then 
            stringToSend = stringToSend.."#m#"..x..","..timeAllExausteds..";"
          end
        end
      end
    end

    if stringToSend ~= "" then
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, stringToSend)
    end

    sendPrevCDToClient(cid, element, spellname, time)
  end
end

function sendAllCdToClient(cid, element, inlogin)
  if not isPlayer(cid) then
    return false
  end
  local tableElement = {
  ["fire"] = fireSpells, 
  ["water"] = waterSpells,
  ["earth"] = earthSpells,
  ["air"] = airSpells
  }  

  local string = ""

  if tableElement[element] ~= nil then
    for x = 1, #tableElement[element] do
      local delayTime, currentTime = getPlayerStorageValue(cid, "exausted"..tableElement[element][x]), os.time()
      if delayTime >= currentTime then
        string = string.."#m#"..x..","..delayTime-currentTime..";"
      else
        string = string.."#m#"..x..",0;"    
      end
    end
    if inlogin then
      return string
    else
      return doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, string)
    end
  else
    return ""
  end
end

function sendWaterPounchToClient(cid, water, inLogin, isSpell)
  if isSpell then 
    return false 
  end 
  if inLogin then
    if water == nil then
      return ""
    end
    
    if water == 0 then
      return ""
    end

    return "#w#"..water..";"
  else
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "#w#"..water..";")
    return true
  end
end

function getPlayerClientConfigs(cid)
  local string = ""

  for x = 7, 1, (-1) do
    local storage = getPlayerStorageValue(cid, "saveClientConfig"..x)
    if storage >= 0 then
      string = string.."#c#"..x..","..storage..";"
    end
  end

  return string
end

function sendWebsiteToPlayer(cid, web)
  doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "@link@"..web)  
  sendBlueMessage(cid, "@link@"..web)
end

function sendAntiBotQuestions(cid, correct)
  return doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "#b#"..correct..";")
end

function cancelAntiBotQuestions(cid)
  return doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "#b#-1;")
end

--[[
    *Lib dedicada a toda comunica��o entre servidor e otc, via OPCODES.
    -- OpcodesOcupados: 
        SERVER RECEBE: 1 (language), 2 (refresh_spells)
        SERVER ENVIA: 1, 2 (sendRefresh_spells)
]]--

sendOpCode = doSendPlayerExtendedOpcode

function refreshSpellsFunc(cid)
    local string = "#v#"..getPlayerVocation(cid)..";"..sendAllCdToClient(cid, getPlayerElement(cid), true)
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, string)
    refreshBuySpells(cid)
end

onReceiveOpCode = {}

onReceiveOpCode[1] = function(cid, opcode, buffer) 
    if buffer == "pt" then
        setLang(cid, PT)
    else
        setLang(cid, EN)
    end
end

onReceiveOpCode[2] = function(cid, opcode, buffer)
    refreshSpellsFunc(cid)
end

onReceiveOpCode[3] = function(cid, opcode, buffer)
    local version = buffer

    --[[ TODO: check this
      if version ~= clientVersion.."true" then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, getLangString(cid, "WARNING! Your client is out of date, it is extremely important that you download the version v5.2 on our website.", "ATEN��O! O seu client est� desatualizado, � de extrema import�ncia que voc� fa�a o download da vers�o v5.2 em nosso website."))
    end]]
end