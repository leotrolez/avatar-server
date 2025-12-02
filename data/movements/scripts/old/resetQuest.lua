local config = {
  posExit = {x=485,y=510,z=10},

  statuesPoses = {
    {x=486,y=508,z=10, trash=1457, used=false}, {x=486,y=513,z=10, trash=1456, used=false}, {x=487,y=508,z=10, trash=1457, used=false}, 
    {x=487,y=513,z=10, trash=1456, used=false}, {x=488,y=508,z=10, trash=1457, used=false}, {x=488,y=513,z=10, trash=1456, used=false}, 
    {x=489,y=508,z=10, trash=1457, used=false}, {x=489,y=513,z=10, trash=1456, used=false}, {x=490,y=508,z=10, trash=1457, used=false}, 
    {x=490,y=513,z=10, trash=1456, used=false}, {x=491,y=508,z=10, trash=1457, used=false}, {x=491,y=513,z=10, trash=1456, used=false}, 
    {x=492,y=508,z=10, trash=1457, used=false}, {x=492,y=513,z=10, trash=1456, used=false}
  },

  monsterName = "stoned gargoyle"
}

function onStepIn(cid, item, position, fromPosition)
  if isMonster(cid) then
    return
  end

  for x = 1, #config.statuesPoses do
    if not config.statuesPoses[x].used then
      config.statuesPoses[x].used = true
      removeTileItemByIds(config.statuesPoses[x], {1452, 1453}, 2)
      doCreateItem(config.statuesPoses[x].trash, 1, config.statuesPoses[x])
      doTeleportCreature(cid, config.posExit, 10)
      doCreateMonster(config.monsterName, config.statuesPoses[x], nil, true)
      break
    end
  end

  return true
end