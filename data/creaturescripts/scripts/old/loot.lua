local function find(pos, itemid)
    if not(pos or itemid) then
        return false
    end

    local corpse = getTileItemById(pos, itemid).uid

    if corpse > 0 then
        if not isContainer(corpse) then
            return false
        else
            return corpse
        end
    else
        return false
    end
end

local function getConteiner(container)
    local itemsInside = {}
    local str = ""
    for x = 0, getContainerCap(container) do
        local item = getContainerItem(container, x)
        if item.uid > 0 then
            table.insert(itemsInside, item)
        end
    end
    str = str.."("
    if #itemsInside > 0 then
        for i = 1, #itemsInside do
            local currentItem = itemsInside[i]
            if isContainer(currentItem.uid) then
               str = str..getArticle(getItemNameById(currentItem.itemid)).." "..getItemNameById(currentItem.itemid)..": "..getConteiner(currentItem.uid)  
            else
                if currentItem.type > 1 then
                    str = str..getItemPluralNameById(currentItem.itemid)..' ('..currentItem.type..')'
                else
                    str = str..getArticle(getItemNameById(currentItem.itemid))..' '..getItemNameById(currentItem.itemid)
                end
            end    
              if i ~= #itemsInside then
                if #itemsInside == i+1 then
                    str = str.." and "
                else
                    str = str..", "
                end
            end
        end
    else
        str = str.."nothing"    
    end
    str = str..")"
  return str
end

local stones = {
    ["fire"] = {
        monsters = {
            "Dragon", "Dragon Hatchling", "Demon Skeleton", "Dragon Lord", "Zuko's Disciple"
        }, stoneId = getStoneItemId("fire")
    },

    ["water"] = {
        monsters = {
            "Son of Water", "Spirit of Water", "Quara Pincher", "Quara Hydromancer", "Frost Dragon", "Zero"
        }, stoneId = getStoneItemId("water")
    },

    ["air"] = {
        monsters = {
            "Nomad"
        }, stoneId = getStoneItemId("air")    
    },

    ["earth"] = {
        monsters = {
            "Beast of Earth", "Gargoyle", "Stone Golem"
        }, stoneId = getStoneItemId("earth")    
    }, 
}


local function addStone(monsterName, corpseUid)
    --Incompleto
    return false
end

local function getLoot(corpsePosition, cid, name)
    local corpse = find(corpsePosition, MonsterType(name):corpseId())

    if corpse == false then
        return false
    end

    local monsterItens = {}
    for x = 0, getContainerCap(corpse) do
        local item = getContainerItem(corpse, x)
        if item.uid > 0 then
            table.insert(monsterItens, item)
        end
    end

    local a = addStone(name, corpse, items)
    
    if a then
        table(monsterItens, a)
    end

    local str = "Loot from "..name..": " 
    local partyStr = "Loot from "..name..", killed by "..getCreatureName(cid)..": "
    if #monsterItens > 0 then
      for i = 1, #monsterItens do
          local currentItem = monsterItens[i]
          if isContainer(currentItem.uid) then
              str = str..getArticle(getItemNameById(currentItem.itemid)).." "..getItemNameById(currentItem.itemid)..": "..getConteiner(currentItem.uid)
              partyStr = partyStr..getArticle(getItemNameById(currentItem.itemid)).." "..getItemNameById(currentItem.itemid)..": "..getConteiner(currentItem.uid)
          else
              if currentItem.type > 1 then
                  str = str..getItemPluralNameById(currentItem.itemid)..' ('..currentItem.type..')'
                  partyStr = partyStr..getItemPluralNameById(currentItem.itemid)..' ('..currentItem.type..')'
              else
                  str = str..getArticle(getItemNameById(currentItem.itemid))..' '..getItemNameById(currentItem.itemid)
                  partyStr = partyStr..getArticle(getItemNameById(currentItem.itemid))..' '..getItemNameById(currentItem.itemid)
              end
          end
          if i == #monsterItens then
              str = str.."."
              partyStr = partyStr.."."
          else
              if #monsterItens == i+1 then
                  str = str.." and "
                  partyStr = partyStr.." and "
              else
                  str = str..", "
                  partyStr = partyStr..", "
              end
          end
      end
    else
        str = str.."nothing."
        partyStr = partyStr.."nothing."
    end

    if not isCreature(cid) then
        return false
    end

    if isInParty(cid) then
        local players = getPartyMembers(getPartyLeader(cid))
        for x = 1, #players do
            --doPlayerSendChannelMessage(players[x], nil, partyStr, TALKTYPE_CHANNEL_O, CHANNEL_PARTY)  
        end
    end
    doPlayerSendTextMessage(cid, 22, str) 
end

local exeptions = {"Fire Elemental"}

function onKill(cid, target)
    if isPlayer(target) or not isCreature(target) then
        return true
    end

    if isInArray(exeptions, getCreatureName(target)) then
        return true
    end

    addEvent(getLoot, 100, getCreaturePosition(target), cid.uid, getCreatureName(target))
    return true
end