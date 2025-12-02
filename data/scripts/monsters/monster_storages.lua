if not MonsterStorages then
    MonsterStorages = setmetatable({}, {
        __index = function (storage, cid)
            local self = Monster(cid)
            if not self then
                return
            end

            if self:registerEvent("MonsterStorages") then
                storage[cid] = {}
                return storage[cid]
            end
        end
    })
end

local creatureEvent = CreatureEvent("MonsterStorages")

function creatureEvent.onDeath(self)
    MonsterStorages[self:getId()] = nil
    return true
end

creatureEvent:register()

function Monster:getStorageValue(key)
    local storages = MonsterStorages[self:getId()]
    if not storages then
        return -1
    end
    return storages[key] or -1
end

function Monster:setStorageValue(key, value)
    local storages = MonsterStorages[self:getId()]
    if not storages then
        return false
    end
    storages[key] = value
    return true
end