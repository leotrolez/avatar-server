function hasDisarm(target)
    if isCreature(target) then
        if isMonster(target) then
            if hasCondition(target, CONDITION_SILENCED) or hasCondition(target, CONDITION_MISSED) or hasCondition(target, CONDITION_STUNNED) then
                return (1)	
            end
        end
        if isPlayer(target) then
            if hasCondition(target, CONDITION_SILENCED) then
                return (1) -- esta com stun (freeze, petrify, silence)
            elseif hasCondition(target, CONDITION_STUNNED) then
                return (1)
            elseif hasCondition(target, CONDITION_MISSED) then
                return (2) -- esta com miss
            end
        end
    end
        return (3) -- esta livre pra usar dobras
    end
    
    function decreaseDmg(cid, percentage, duration, effect, msg, color, diag)
    if not isPlayer(cid) then
        return false
    end
    setPlayerStorageValue(cid, DDD, duration)
    setPlayerStorageValue(cid, DDP, percentage)
    setPlayerStorageValue(cid, DDS, os.time())
    --
    if duration > 1 then
        for i=0, (duration-1) do
            addEvent(function()
                if isCreature(cid) then
                    pos = getCreaturePosition(cid)
                    if (diag == true) then
                        pos = {x=pos.x+1, y=pos.y+1, z=pos.z}
                    end
                    doSendAnimatedText(getCreaturePosition(cid), msg, color)
                    doSendMagicEffect(pos, effect)
                end
            end, i*1000)
        end 
    else
        pos = getThingPos(cid)
        if (diag == true) then
            pos = {x=pos.x+1, y=pos.y+1, z=pos.z}
        end
        doSendMagicEffect(pos, effect)
        doSendAnimatedText(getCreaturePosition(cid), msg, color)
    end
    --
    return true
    end
    
    function reflectDmg(cid, percentage, duration, effect, msg, color, diag)
    if not isPlayer(cid) then
        return false
    end
    setPlayerStorageValue(cid, RFD, duration)
    setPlayerStorageValue(cid, RFP, percentage)
    setPlayerStorageValue(cid, RFS, os.time())
    --
    if duration > 1 then
        for i=0, (duration-1) do
            addEvent(function()
                if isCreature(cid) then
                    pos = getCreaturePosition(cid)
                    if (diag == true) then
                        pos = {x=pos.x+1, y=pos.y+1, z=pos.z}
                    end
                    doSendAnimatedText(getCreaturePosition(cid), msg, color)
                    doSendMagicEffect(pos, effect)
                end
            end, i*1000)
        end 
    else
        pos = getThingPos(cid)
        if (diag == true) then
            pos = {x=pos.x+1, y=pos.y+1, z=pos.z}
        end
        doSendMagicEffect(pos, effect)
        doSendAnimatedText(getCreaturePosition(cid), msg, color)
    end
    --
    return true
    end
    
    function boostDodge(cid, percentage, duration, effect, msg, color, diag)
    if not isPlayer(cid) then
        return false
    end
    setPlayerStorageValue(cid, BDP, percentage)
    setPlayerStorageValue(cid, BDD, duration)
    setPlayerStorageValue(cid, BDS, os.time())
    --
    if duration > 1 then
        for i=0, (duration-1) do
            addEvent(function()
                if isCreature(cid) then
                    pos = getCreaturePosition(cid)
                    if (diag == true) then
                        pos = {x=pos.x+1, y=pos.y+1, z=pos.z}
                    end
                    doSendAnimatedText(getCreaturePosition(cid), msg, color)
                    doSendMagicEffect(pos, effect)
                end
            end, i*1000)
        end 
    else
        pos = getThingPos(cid)
        if (diag == true) then
            pos = {x=pos.x+1, y=pos.y+1, z=pos.z}
        end
        doSendMagicEffect(pos, effect)
        doSendAnimatedText(getCreaturePosition(cid), msg, color)
    end
    --
    return true
    end
    
    function doSilence(target, duration)
    if isNpc(target) then
        return false
    end
        if hasDisarm(target) == 3 then
            local condition = createConditionObject(CONDITION_MISSED)
            setConditionParam(condition, CONDITION_PARAM_TICKS, duration*1000)
            doAddCondition(target, condition)
            doSendAnimatedText(getCreaturePosition(target), "Silenced!", 200)
        end
    return true
    end
    
    function doMiss(target, duration)
    if isNpc(target) then
        return false
    end
        if hasDisarm(target) == 3 then
            local condition = createConditionObject(CONDITION_MISSED)
            setConditionParam(condition, CONDITION_PARAM_TICKS, duration*1000)
            doAddCondition(target, condition)
            doSendAnimatedText(getCreaturePosition(target), "Miss!", 214)
        end
    return true
    end
    
    function doPetrify(target, duration)
    if isNpc(target) then
        return false
    end
    --local pedraId = 16143
    local pedraId = 1304
        if hasDisarm(target) == 3 then
            local condition = createConditionObject(CONDITION_STUNNED)
            setConditionParam(condition, CONDITION_PARAM_TICKS, duration*1000)
            doAddCondition(target, condition)
            dontMove(target, duration*1000)
            doSetItemOutfit(target, pedraId, (duration*1000-200))
            doSendAnimatedText(getCreaturePosition(target), "Petrified!", 120)
        end
    return true
    end
    
    function doFreeze(target, duration)
    if isNpc(target) then
        return false
    end
        if hasDisarm(target) == 3 then
            local condition = createConditionObject(CONDITION_STUNNED)
            setConditionParam(condition, CONDITION_PARAM_TICKS, duration*1000)
            doAddCondition(target, condition)
            targpos = getCreaturePosition(target)
            dontMove(target, duration*1000)
            doSendMagicEffect({x = targpos.x + 1, y = targpos.y + 1, z = targpos.z}, 52)
            doSendAnimatedText(getCreaturePosition(target), "Frozen!", 70)
        end
    return true
    end
    
    function doStun(target, duration) -- essa eh sem doSendMagiceffect ou setOutfit
    if isNpc(target) then
        return false
    end
        if hasDisarm(target) == 3 then
            local condition = createConditionObject(CONDITION_STUNNED)
            setConditionParam(condition, CONDITION_PARAM_TICKS, duration*1000)
            doAddCondition(target, condition)
            targpos = getCreaturePosition(target)
            dontMove(target, duration*1000)
            doSendAnimatedText(getCreaturePosition(target), "Stunned!", 200)
        end
    return true
    end
    
    function hasCooldown(cid, cooldown, storage)
    if (cooldown-(os.time()-getPlayerStorageValue(cid, storage)) > 0) then
        doPlayerSendCancel(cid, "Wait "..cooldown-(os.time()-getPlayerStorageValue(cid, storage)).." second(s) to use this fold again.")
        return false
    else
        setPlayerStorageValue(cid, storage, os.time())
        return true
    end
    end
    
    
    
    
    
    
    -- Especiais
    dodgevalue = 111449
    stunned = 111500
    missed = 111501
    DDD = 111510
    DDP = 111511
    DDS = 111512
    RFD = 111520
    RFP = 111521
    RFS = 111522
    BDD = 111530
    BDP = 111531
    BDS = 111532
    
    
    
    
    
    
    
    
    
    
    -- Water Bendings 
    watermasspurify = 112031
    watercannon = 112002
    waterclock = 112003
    waterdragon = 112004
    waterexplosion = 112005
    waterflow = 112006
    waterfreezingaura = 112007
    watergeiser = 112008
    waterheal = 112009
    waterhealaura = 112010
    watericebeam = 112011
    watericebolt = 112012
    watericespikes = 112013
    watericewave = 112014
    waterjump = 112015
    watermanaflow = 112016
    watermanaheal = 112017
    watermasshealing = 112018
    waterprotect = 112019
    waterpurify = 112020
    watershards = 112021
    waterspirit = 112022
    waterbubbles = 112023
    waterstrikeaura = 112024
    watersurf = 112025
    watertsunami = 112026
    waterwave = 112027
    watericewind = 112028
    waterjet = 112029
    waterpump = 112030
    watervortex = 112031
    watericegolem = 112032
    
    
    
    
    
    
    
    -- Fire Bendings 
    fireskyfall = 111001
    firekick = 111002
    firedoublekick = 111003
    firewave = 111004
    firestar = 111005
    firebomb = 111006
    firewrath = 111007
    fireclock = 111008
    fireball = 111009
    fireflash = 111010
    firecannon = 111011
    firejump = 111012
    firepunch = 111013
    fireexplosion = 111014
    firesmoke = 111015
    firesnakes = 111016
    firerage = 111017
    firedragon = 111018
    fireburnsteps = 111019
    firestorm = 111020
    firebeam = 111021
    firebreath = 111022
    fireflames = 111023
    firehellcurse = 111024
    firemeteor = 111025
    firestriker = 111026
    firefog = 111027
    fireoverheat = 111028
    firespark = 111029
    fireflash = 111030
    fireyell = 111031
    firecry = 111032
    
    
    
    
    
    
    
    -- Earth Bendings 
    earthrock = 114001
    earthpull = 114002
    eartharmor = 114003
    earthaura = 114004
    earthsmash = 114005
    earthslide = 114006
    earthclone = 114007
    earthpetrify = 114008
    earthingrain = 114009
    earthwalk = 114010
    earthjump  = 114011
    eartharena = 114012
    earthdrain = 114013
    earthquake = 114014
    earthrevenge = 114015
    earthcataclysm = 114016
    earthgrowth = 114017
    earthstomp = 114018
    earthchallenge = 114019
    earthshake = 114020
    earthtunnel = 114021
    earthroots = 114022
    earthdefense = 114023
    earthwall = 114024
    earthcollapse = 114025
    earthpunch = 1140026
    earthpalm = 114027
    earthfury = 114028
    earthcrush = 114029
    earthrecoil = 114030
    earthflow = 114031
    earththrow = 114032
    earthdig = 114099 -- talvez no moon
    
    
    
    
    
    
    -- Air Bendings 
    airrun = 113001
    airball = 113002
    airstormcall = 113003
    airwindblast = 113004
    airtrap = 113005
    airbomb = 113006
    airwindstorm = 113007
    airdoom = 113008
    airburst = 113009
    airbreath = 113010
    airjump = 113011
    airvortex = 113012
    airclaw = 113013
    airbreeze = 113014
    aircyclones = 113015
    airchains = 113016
    airtorment = 113017
    airstormprison = 113018
    airbarrier = 113019
    aircoat = 113020
    airsense = 113021
    airgust = 113022
    airwindcall = 113023
    airdoom = 113024
    airsuffocation = 113025
    airflow = 113026
    airboost = 113027
    airfan = 113028
    airgale = 113029
    airhaze = 113030
    airvoice = 113031
    airmirror = 133032
    
    function adjustDirection(dir)
    local finaldir = dir-1
    if finaldir == -1 then 
    return 3
    elseif finaldir == 4 then 
    return 0
    end 
    return finaldir
    end
    
    function returnPositionByCoord(pos, linha, coluna, dir)
    return getPosByDir(getPosByDir(pos, dir, 6-linha), adjustDirection(dir), 6-coluna)
    end
    
    function changeOrNot(change, value, compr)
    if change then 
    return (compr-value)
    end
    return 0
    end
    
    function getPositionsByTable(pos, tabela, dir, compr, tabelas)
        local poses = {}
        for i = 1, tabelas do
        table.insert(poses, {})
        end
        local linhas = #tabela
        local changelinhas, changecolunas = false, false
        if linhas <= compr then 
            changelinhas = true 
        end 
    
        for i = 1, linhas do 
            local colunas = #tabela[i]
            if colunas <= compr then 
                changecolunas = true 
            end 
            for j = 1, colunas do
                if tabela[i][j] > 0 then 
                    local posf = returnPositionByCoord({x=pos.x, y=pos.y, z=pos.z}, i+(changeOrNot(changelinhas, linhas, compr)), j+(changeOrNot(changecolunas, colunas, compr)), dir)
                    table.insert(poses[tabela[i][j]], posf)
                end 
            end
        end
        return poses
    end
    
    function isNonPvp(cid)
    return isMonster(cid) or getPlayerStorageValue(cid, "canAttackable") == 1 
    end 
    
    function isInPvpZone(cid)
    local pos = getCreaturePosition(cid)
        if getTileInfo(pos).hardcore then
            return true 
        end
    return false
    end
    
    function isSameParty(cid, target)
        if isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target) then 
            return true
        end
        if isInSameGuild(cid, target) then
            return true
        end
        return false
    end
    
    function isPzPos(pos)
    if not hasSqm(pos) then 
        return false
    end 
    return getTileInfo(pos).protection
    end
    
    function isInPz(cid)
    local pos = getCreaturePosition(cid)
    return (getTileInfo(pos).protection)
    end
    
    function isInPZ(cid)
    local pos = getCreaturePosition(cid)
    return (getTileInfo(pos).protection)
    end
    
    local function isImune(cid, creature)
    local skulls = {1,3,4,5,6}
        if cid == creature then
            return true
        end
        if isMonster(creature) or isMonster(cid) then 
            return false 
        end
        if isPlayer(cid) and isPlayer(creature) and (getPlayerStorageValue(cid, "canAttackable") == 1 or getPlayerStorageValue(creature, "canAttackable") == 1) then 
            return true 
        end 
        if isInParty(cid) and isInParty(creature) and getPlayerParty(cid) == getPlayerParty(creature) then
            return true
        end 
        if isInSameGuild(cid, target) then
            return true
        end
        local modes = getPlayerModes(cid)
        if isInArray(skulls, getCreatureSkullType(creature)) then
            return false
        end     
        if (modes.secure == SECUREMODE_OFF) then
            return false
        end
        return true
    end
    
    function dontMove(target, duration)
        if isPlayer(target) then
            setPlayerStorageValue(target, stun_storage, (os.time()+ (math.ceil(duration/1000))))
        end
        if isCreature(target) then
            doCreatureSetNoMove(target, true)
            addEvent(function() 
                if isCreature(target) then
                doCreatureSetNoMove(target, false)
                end
                end, duration)
        end
    return true
    end
--TODO: Review it 
function isInWarGround(cid)
    return false
end
