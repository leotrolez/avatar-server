local teleports = {
  [2772] = {x=582,y=965,z=9},
  [2773] = {x=404,y=400,z=3}
}


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  doTeleportCreature(cid, teleports[item.actionid], 10)
  return true
end
