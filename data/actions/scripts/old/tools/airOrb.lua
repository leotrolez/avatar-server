local MyLocal = {}
MyLocal.centerPos = {x=529,y=685,z=7}
MyLocal.orbPos = {x=529,y=685,z=7}

local function loopHealingCity()
  local possiblePlayers = getSpectators(MyLocal.centerPos, 4, 4)
  if possiblePlayers ~= nil then
    for x = 1, #possiblePlayers do
      local player = possiblePlayers[x]
      if isPlayer(player) then
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
  addEvent(loopHealingCity, 3000, nil)
end

addEvent(loopHealingCity, 3000, nil)

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid

  return true
end
