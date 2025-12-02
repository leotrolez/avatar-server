local MyLocal = {}
MyLocal.centerPos = {x=506,y=331,z=8}
MyLocal.orbPos = {x=504,y=331,z=8}
MyLocal.tileId = {473, 12707}

local function loopHealingCity()
  local possiblePlayers = getSpectators(MyLocal.centerPos, 2, 2)

  if possiblePlayers ~= nil then
    for x = 1, #possiblePlayers do
      local player = possiblePlayers[x]
      local playerPos = getCreaturePosition(player)
      if isPlayer(player) then
        if isInArray(MyLocal.tileId, getThingfromPos({x=playerPos.x,y=playerPos.y,z=playerPos.z,stackpos=0}).itemid) then
          local maxHealth, maxMana, playerPos = getCreatureMaxHealth(player), getCreatureMaxMana(player), getThingPos(player)
          if getCreatureHealth(player) < maxHealth or getCreatureMana(player) < maxMana then
            doCreatureAddHealth(player, maxHealth)
            doCreatureAddMana(player, maxMana)
            doSendMagicEffect(MyLocal.orbPos, 11)
            doSendDistanceShoot(MyLocal.orbPos, playerPos, CONST_ANI_ENERGY)
            doSendMagicEffect(playerPos, 12)
          end
        end
      end
    end
  end
  addEvent(loopHealingCity, 3000, nil)
end


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid

  return true
end
