local monsters = {}

function onSpawn(cid)
  if not serverInTest then
    return true
  end
--[[
  if isMonster(cid) then
    local creatureName = getCreatureName(cid)

    if not monsters[creatureName] then
      monsters[creatureName] = 1

      local file = io.open("data/logs/monstros/monstros.txt", "a")
        file:write(getCreatureName(cid) .. "\n")
        file:close()
    else
      monsters[creatureName] = monsters[creatureName]+1
    end

    print("Registrando monstros em: data/logs/monstros/monstros.txt...")
  end]]
end