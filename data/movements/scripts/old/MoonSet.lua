 local items = {
    ["head"] = {bonusReflect = 1, addRegen = 6, extraBonus = "armor", extraBonusQt = 2, oldStatus = 7}, -- Helmet
    ["armor"] = {bonusReflect = 1, addRegen = 3, extraBonus = "armor", extraBonusQt = 4, oldStatus = 11}, -- Armor
    ["legs"] = {bonusReflect = 1, addRegen = 3, extraBonus = "armor", extraBonusQt = 4, oldStatus = 7}, -- Legs
    ["feet"] = {bonusReflect = 1, addRegen = 3, extraBonus = "armor", extraBonusQt = 2, oldStatus = 0}, -- Boots
    ["shield"] = {bonusReflect = 5, addRegen = 3, extraBonus = "defense", extraBonusQt = 5, oldStatus = 31}, -- Shield
    ["necklace"] = {bonusReflect = 1, addRegen = 3, extraBonus = "dropRate", extraBonusQt = 3, oldStatus = 0}, -- Amulet
}
 
local slots = {
        [1] = 13401,
        [4] = 13402,
        [5] = 13405,
        [7] = 13403,
        [8] = 13404,
}
 
function getItemType(itemid)
    local slottypes = {"head", "body", "legs", "feet", "ring", "necklace", "shield"}
    local arq = io.open("data/items/items.xml", "r"):read("*all")
    local attributes = arq:match('<item id="' .. itemid .. '".+name="' .. getItemNameById(itemid) ..'">(.-)</item>')
    local slot = ""
    for i,x in pairs(slottypes) do
        if attributes:find(x) then
                slot = x
                    break
            end
    end
    if slot == "body" then
        slot = "armor"
    end
return slot
end
 
local function getMatchSet(cid, item)
        for i,v in pairs (slots) do
                local it = getPlayerSlotItem(cid, i).itemid
                if (it == 0) or (it == nil) then
                        it = item
                end
                if not (it == v) then
                        return false
                end
        end
 
        return true
end
 
 
local CD = {}
 
for i = 13401, 13405 do
        CD[i] = createConditionObject(CONDITION_REGENERATION)
        setConditionParam(CD[i], CONDITION_PARAM_TICKS, -1)
        setConditionParam(CD[i], CONDITION_PARAM_HEALTHGAIN, 2)
        setConditionParam(CD[i], CONDITION_PARAM_HEALTHTICKS, 1)
        setConditionParam(CD[i], CONDITION_PARAM_SUBID, i)     
end

   local speedBonus = createConditionObject(CONDITION_HASTE)
    setConditionParam(speedBonus, CONDITION_PARAM_TICKS, -1)
    setConditionParam(speedBonus, CONDITION_PARAM_SUBID, 25647)  
    setConditionFormula(speedBonus, 0, 30, 0, 30)     

function onEquip(cid, item, slot)
        doAddCondition(cid, CD[item.itemid])        
        if item.itemid == 13404 then 
            doAddCondition(cid, speedBonus)
        end 
       
        if getMatchSet(cid) then
                for i, v in pairs (slots) do
                        local it = getPlayerSlotItem(cid, i)
                       
                        local ite = items[getItemType(it.itemid)]
                        if isInArray(slots, it.itemid) then    
                                doItemSetAttribute(it.uid, ite.extraBonus, ite.extraBonusQt + ite.oldStatus)
                        end
                                setPlayerStorageValue(cid, 13404, 1)
                end
               
                setPlayerStorageValue(cid, 13402, 10)
                setPlayerStorageValue(cid, 13403, 1)
                if getPlayerStorageValue(cid, "hasInPotionExp") >= os.time() then
                        doPlayerSetExperienceRate(cid, 1.6)
                else
                        doPlayerSetExperienceRate(cid, 1.1)
                end
                registerCreatureEvent(cid,"reflect")
        end
        return true
end
 
function onDeEquip(cid, item, slot)
        doRemoveCondition(cid,CONDITION_REGENERATION, item.itemid)
        if item.itemid == 13404 then 
            doRemoveCondition(cid, CONDITION_HASTE, 25647)
        end 
       
        if getMatchSet(cid, item.itemid) then
                for i, v in pairs (slots) do
                        local it = getPlayerSlotItem(cid, i)                   
                        if (it.itemid == 0) or (it.itemid == nil) then
                                it = item
                        end
                        local ite = items[getItemType(it.itemid)]      
                        if isInArray(slots, it.itemid) then    
                                doItemSetAttribute(it.uid, ite.extraBonus, ite.oldStatus)
                        end
                        setPlayerStorageValue(cid, 13404, -1)
                end
                setPlayerStorageValue(cid, 13402, -1)
                setPlayerStorageValue(cid, 13403, -1)
                if getPlayerStorageValue(cid, "hasInPotionExp") >= os.time() then
                        doPlayerSetExperienceRate(cid, 1.5)
                else
                        doPlayerSetExperienceRate(cid, 1)
                end
        end
        unregisterCreatureEvent(cid,"reflect")
        return true
end