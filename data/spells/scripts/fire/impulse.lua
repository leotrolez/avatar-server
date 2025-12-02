local spellName = "fire impulse"
local cf = {segundos = spellsInfo[spellName].segundos}

local MyLocal = {}
MyLocal.players = {}
MyLocal.time = cf.segundos
MyLocal.magicEffect = 6

local function stopMove(cid)
    if isCreature(cid) then
        MyLocal.players[cid] = nil
        setPlayerStorageValue(cid, "playerCanMoveDirection", 0)
        if getDobrasLevel(cid) >= 5 then
            doPlayerAddExaust(cid, "fire", "impulse", fireExausted.impulse-6)  
        else
            doPlayerAddExaust(cid, "fire", "impulse", fireExausted.impulse)  
        end
    end  
end

local function sendMagicEffectPersonalizado(pos)
    local poses = {{x=-2,y=0},{x=2,y=0},{x=0,y=2},{x=0,y=-2}}

    for x = 1, #poses do
        doSendDistanceShoot({x=pos.x+poses[x].x, y=pos.y+poses[x].y, z=pos.z}, pos, 3)
    end 
end

local function MoveAutomatic(cid, speed)
         if not isCreature(cid) or exhaustion.check(cid, "stopDashs") or exhaustion.check(cid, "airtrapped") then
            stopMove(cid)
            return false
         end

         if MyLocal.players[cid] == nil then
            return false
         end

         local time = MyLocal.players[cid].timeEnd
         local playerPos = getThingPos(cid)
         local posToGo = getPositionByDirection(playerPos, getCreatureLookDirection(cid), 1)

         if getPlayerCanWalk({player = cid, position = posToGo, createTile = true, checkPZ = true, checkHouse = true, checkWater = false}) and not exhaustion.check(cid, "airtrapped") then
            setCreatureNoMoveTime(cid, speed+50)
            doTeleportThing(cid, posToGo)
            if getPlayerCanWalk({player = cid, position = posToGo, createTile = true, checkPZ = true, checkHouse = true, checkWater = true}) then           
                doSendMagicEffect(playerPos, MyLocal.magicEffect)
            else 
                doSendMagicEffect(playerPos, 5)
            end 
            if time <= os.time() then
                stopMove(cid)
            else
                addEvent(MoveAutomatic, speed, cid, speed)  
            end
        else
            stopMove(cid)
            return false
        end
end

local function formulaLevel(cid)
    local valor = getPlayerLevel(cid)*1.5
    if valor >= 150 then
        valor = 150 + ((valor-150)/4)
        valor = math.ceil(valor)
    end
    if valor >= 200 then
        valor = 200
    end
    return valor
end

function onCastSpell(creature, var)
	local cid = creature:getId()
        if not isPlayer(cid) then
            return false
        end  
        if exhaustion.check(cid, "isInCombat") then
        --  doPlayerSendCancelEf(cid, getLangString(cid, "You cannot use this bend with recent PvP (damage combat with another player).", "Você não pode executar esta dobra com PvP recente (sofrido/causado dano contra outro jogador recentemente)."))
        --  return false
        end

        if getSpellCancels(cid, "fire", false, true) == true then
            return false
        end

        if getPlayerExaust(cid, "fire", "impulse") == false then
            return false
        end

        if MyLocal.players[cid] == nil then
            if getPlayerHasStun(cid) then
                    if getDobrasLevel(cid) >= 5 then
                        doPlayerAddExaust(cid, "fire", "impulse", fireExausted.impulse-6) 
                    else
                        doPlayerAddExaust(cid, "fire", "impulse", fireExausted.impulse) 
                    end
                return true
            end
            local newPos = getPositionByDirection(getThingPos(cid), getCreatureLookDirection(cid))
            if not getPlayerCanWalk({player = cid, position = newPos, createTile = true, checkPZ = true, checkHouse = true, checkWater = false}) then
                doPlayerSendCancelEf(cid, "It isn't possible use this fold here.")
                return false
            end
            MyLocal.players[cid] = {timeEnd = os.time()+MyLocal.time}
            MoveAutomatic(cid, 300-formulaLevel(cid))
            setCreatureNoMoveTime(cid, (300-formulaLevel(cid)) + 50)
         --   setCreatureNoMoveTime(cid, MyLocal.time*1000)
            workAllCdAndAndPrevCd(cid, "fire", "impulse", MyLocal.time, 1)
            setPlayerStorageValue(cid, "playerCanMoveDirection", os.time()+MyLocal.time)
            return true
         else
            doPlayerSendCancelEf(cid, "You're already using this fold.")
            return false
         end 
end