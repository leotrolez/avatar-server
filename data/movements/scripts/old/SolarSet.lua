 local items = {
    ["head"] = {bonusReflect = 1, addRegen = 6, extraBonus = "armor", extraBonusQt = 3, oldStatus = 10}, -- Helmet
    ["armor"] = {bonusReflect = 1, addRegen = 3, extraBonus = "armor", extraBonusQt = 3, oldStatus = 16}, -- Armor
    ["legs"] = {bonusReflect = 1, addRegen = 3, extraBonus = "armor", extraBonusQt = 3, oldStatus = 8}, -- Legs
    ["feet"] = {bonusReflect = 1, addRegen = 3, extraBonus = "armor", extraBonusQt = 3, oldStatus = 2}, -- Boots
    ["shield"] = {bonusReflect = 5, addRegen = 3, extraBonus = "defense", extraBonusQt = 0, oldStatus = 37}, -- Shield
    ["necklace"] = {bonusReflect = 1, addRegen = 3, extraBonus = "dropRate", extraBonusQt = 3, oldStatus = 0} -- Amulet
}
 
local slots = {
        [1] = 13416,
        [4] = 13418,
        [5] = 13415,
        [7] = 13417,
        [8] = 12930,
}
 
local cond = {
        [13416] = 1,
        [13418] = 2,
        [13415] = 3,
        [13417] = 4,
        [12930] = 5,
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
        local ct = 0
        for i,v in pairs (slots) do
                local it = getPlayerSlotItem(cid, i).itemid
                if (it == 0) or (it == nil) then
                        it = item
                end
                if (it == v) then
                        ct = ct + 1
                end
        end
        return ct
end
 
 
local CD = {}
 
for i = 1,5 do 
        CD[i] = createConditionObject(CONDITION_REGENERATION)
        setConditionParam(CD[i], CONDITION_PARAM_TICKS, -1)
        setConditionParam(CD[i], CONDITION_PARAM_HEALTHGAIN, 3)
        setConditionParam(CD[i], CONDITION_PARAM_HEALTHTICKS, 1)
        setConditionParam(CD[i], CONDITION_PARAM_SUBID, i)     
end
 
local bonus = {}
 
for b = 20, 150 do
        bonus[b] = createConditionObject(CONDITION_REGENERATION)
        setConditionParam(bonus[b], CONDITION_PARAM_TICKS, -1)
        setConditionParam(bonus[b], CONDITION_PARAM_HEALTHGAIN, b)
        setConditionParam(bonus[b], CONDITION_PARAM_HEALTHTICKS, 1)
        setConditionParam(bonus[b], CONDITION_PARAM_SUBID, b)
end
    speedBonus = createConditionObject(CONDITION_HASTE)
    setConditionParam(speedBonus, CONDITION_PARAM_TICKS, -1)
    setConditionParam(speedBonus, CONDITION_PARAM_SUBID, 22930)  
	setConditionFormula(speedBonus, 0, 30, 0, 30)  
	
function onEquip(cid, item, slot)
        if getPlayerLevel(cid) < 120 then return false end
        local ct = cond[item.itemid]
        doAddCondition(cid, CD[ct])
       	if item.itemid == 12930 then 
			doAddCondition(cid, speedBonus)
		end 
        if getMatchSet(cid) >= 3 then
               
                doRemoveCondition(cid,CONDITION_REGENERATION, bonus[getPlayerStorageValue(cid, "hp_set")])
                doAddCondition(cid, bonus[math.ceil(getCreatureMaxHealth(cid)/100)])
                setPlayerStorageValue(cid, "hp_set", math.ceil(getCreatureMaxHealth(cid)/100))
               
                for i, v in pairs (slots) do                   
                                local it = getPlayerSlotItem(cid, i)
                                if isInArray(slots, it.itemid) then    
                                        if it.itemid > 0 then
                                                local ite = items[getItemType(it.itemid)]
                                                doItemSetAttribute(it.uid, ite.extraBonus, ite.extraBonusQt + ite.oldStatus)
                                                setPlayerStorageValue(cid, 13404, 1)
                                        end
                                end                    
                end
                if getMatchSet(cid) == 4 then
                        setPlayerStorageValue(cid, 13403, 1)
                        setPlayerStorageValue(cid, 13402, 20)
                        if getPlayerStorageValue(cid, "hasInPotionExp") >= os.time() then
                                doPlayerSetExperienceRate(cid, 1.6)
                        else
                                doPlayerSetExperienceRate(cid, 1.1)
                        end
                elseif getMatchSet(cid) == 5 then                      
                        registerCreatureEvent(cid,"reflect")
                end
        end
        return true
end
 
function onDeEquip(cid, item, slot)
        local ct = cond[item.itemid]
        doRemoveCondition(cid,CONDITION_REGENERATION, ct)
		if item.itemid == 12930 then 
			doRemoveCondition(cid, CONDITION_HASTE, 22930)
		end 
        local ite = items[getItemType(item.itemid)]
        doItemSetAttribute(item.uid, ite.extraBonus, ite.oldStatus)
       
        if getMatchSet(cid) < 3 then
                for i = 20, 150 do
                        doRemoveCondition(cid,CONDITION_REGENERATION, i)
                end
                for i, v in pairs (slots) do                   
                                local it = getPlayerSlotItem(cid, i)                   
                                if (it.itemid == 0) or (it.itemid == nil) then
                                        it = item
                                end
                                local ite = items[getItemType(it.itemid)]      
                                if isInArray(slots, it.itemid) then                            
                                        doItemSetAttribute(it.uid, ite.extraBonus, ite.oldStatus)
                                        setPlayerStorageValue(cid, 13404, -1)
                                end
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