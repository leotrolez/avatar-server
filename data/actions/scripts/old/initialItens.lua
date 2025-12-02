local tableInfo = {
  [5432] = {skill = SKILL_CLUB, weapon = {id = 7379, amount = 1}},
  [5433] = {skill = SKILL_AXE, weapon = {id = 2428, amount = 1}},
  [5434] = {skill = SKILL_SWORD, weapon = {id = 3963, amount = 1}},
  [5435] = {skill = SKILL_DISTANCE, weapon= {id = 2389, amount = 3}}
}

local configMarks = {
  storage = 90212,
  version = 1, -- Increase this value after adding new marks, so player can step again and receive new map marks
  marks = {
    {mark = 2, pos = {x=476,y=354,z=8}, desc = "Forge Room"},
    {mark = 11, pos = {x=494,y=362,z=8}, desc = "Depot and Bank"},
    {mark = 8, pos = {x=473,y=340,z=8}, desc = "Ba Sing Se Academy"},
    {mark = 2, pos = {x=486,y=330,z=8}, desc = "Taverna"},
    {mark = 5, pos = {x=513,y=343,z=8}, desc = "Exit to Temple"}
  }
}

local recruitCenterPos = {x=506,y=331,z=8}

local function sendMapMarks(cid)
  if isPlayer(cid) ~= true or getPlayerStorageValue(cid, configMarks.storage) == configMarks.version then
    return false
  end
  for _, m  in pairs(configMarks.marks) do
    doPlayerAddMapMark(cid, m.pos, m.mark, m.desc ~= nil and m.desc or "")
    end
    return true
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if getPlayerStorageValue(cid, "playerStartOnInitialItenGet") == 1 then
    print("jogador:"..getPlayerName(cid).."bugando chest quest initial item. ")
    sendBlueMessage(cid, "Please contact a GameMaster.")
    return false
  end

  local tableUsed = tableInfo[item.uid]
  doPlayerAddSkill(cid, tableUsed.skill, 10)
  doPlayerAddItem(cid, tableUsed.weapon.id, tableUsed.weapon.amount, false)
  doTeleportCreature(cid, recruitCenterPos, 10)
  sendMapMarks(cid)
  setPlayerStorageValue(cid, "playerStartOnInitialItenGet", 1)
  return true
end


