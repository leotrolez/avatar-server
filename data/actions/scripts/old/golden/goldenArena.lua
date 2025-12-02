local config = {
  totalPoses = registrePosesBetween({x=693,y=322,z=7}, {x=715,y=357,z=7}),
  posesMonsters = {{z=697,y=334,z=7},{z=704,y=334,z=7},{z=712,y=334,z=7},
           {z=712,y=343,z=7},{z=704,y=343,z=7},{z=697,y=343,z=7},
           {z=697,y=352,z=7},{z=704,y=352,z=7},{z=712,y=352,z=7}}
  },

local waves = {
  {"Nomad", "Nomad", "Demon Skeleton", --Wave One
  "Cyclops", "Cyclops", "Cyclops Drone",
  "Cyclops Drone", "Rotworm", "Cyclops Smith"},

  {"Cyclops Smith", "Cyclops Smith", "Cyclops Smith", --Wave Two
   "Stone Golem", "Stone Golem", "Stone Golem", 
   "Beast of Earth", "Demon Skeleton", "Demon Skeleton"},

  {"Beast of Earth", "Giant Spider", "Giant Spider", --Wave Three
   "Demoniac Skeleton", "Giant Spider", "Spider",
   "Stone Golem", "Son of Verminor", "Son of Verminor"},

  {"Hydra", "Hydra", "Giant Spider", --Wave Four
  "Quara Pincher", "Quara Pincher", "Carniphila",
  "Frost Dragon", "Ice Golem", "Hydramat"},

  {"Hydramat", "Beast of Earth", "Demoniac Skeleton", --Wave Five
   "Hydra", "Hydra", "Frost Dragon", 
   "Son of Verminor", "Spirit of Water", "Spirit of Water"},

  {"Hydramat", "Hydramat", "Frost Dragon", --Wave Six
   "Frost Dragon", "Hydra", "Hydra",
   "Beast of Earth", "Beast of Earth", "Son of Verminor"},

  {"Frost Dragon", "Frost Dragon", "Ice Witch", --Wave Seven
   "Ice Witch", "Beast of Earth", "Hydramat",
   "Hydramat", "Hydramat", "Hydramat"},

  {"Hydramat", "Hydramat", "Giant Spider", --Wave Eight
     "Giant Spider", "Hydra", "Hydra", 
     "Frost Dragon", "Stone Golem", "Hydramat"},

    {"Hydramat", "Hydramat", "Hydramat", --Wave Nine
     "Frost Dragon", "Stone Golem", "Hydramat",
     "Ice Golem", "Hydra", "Hydramat"}
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
end





--doCreatureSetDropLoot(cid, doDrop)