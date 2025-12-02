dofile(getDataDir().."lib/isoled/150-npcSystem.lua")

function doMessageCheck(message, keyword)
    if not message then
        return false
    end

    if(type(keyword) == "table") then
        return table.isStrIn(keyword, message)
    end
    
    local keyword = keyword:lower()
    local message = message:lower() 

    local a, b = message:find(keyword)
    if keyword == "hi" or keyword == "oi" then
        if a == 1 and b == 2 then
            return true
        end
    else
        if(a ~= nil and b ~= nil) then
            return true
        end
    end

    return false
end

function getItemPriceById(itemid)
    for x = 1, #itemInfosSell do
        local itemSelect = itemInfosSell[x]
        if itemSelect.itemId == itemid then
            return itemSelect.price
        end
    end
    return false
end

function getPriceByItem(item)
    local price = getItemAttribute(item.uid, "price")

    if price == nil then
        return price
    end

    if getItemPriceById(item.itemid) and (item.type ~= 0 and item.type > 0 and item.type ~= nil) then
        return tonumber(price)*item.type
    end

    return price
end

function setItemToRealPrice(cid, item)
    local priceInList = getItemPriceById(item.itemid)
    
    if priceInList then
        doItemSetAttribute(item.uid, "price", priceInList)
        doItemSetAttribute(item.uid, "description", getItemDescriptionsById(item.itemid).description..""..getLangString(cid, "Price", "Preço")..": "..getPriceByItem(item).." gold.")  
    else
        doItemSetAttribute(item.uid, "price", "Unsellable")
        doItemSetAttribute(item.uid, "description", getItemDescriptionsById(item.itemid).description.."")
    end
	--addEvent(function()    doItemSetAttribute(item.uid, "description", getItemDescriptionsById(item.itemid).description) end, 50)
    return true
end

function setDescriptionItemBonus(cid, item)
    local keys = {["Attack Level"] = "attacklevel", ["Defense Level"] = "defenselevel", ["Armor Level"] = "armorlevel"}
    for i,v in pairs (keys) do
        if getItemAttribute(item.uid, v) ~= nil then
            local desc = getItemAttribute(item.uid, "description")
            local level = getItemAttribute(item.uid, v)
            if desc ~= nil then
                doItemSetAttribute(item.uid, "description", i .. " Additional: " .. level .. ".\n" .. desc .. "")
            else
                doItemSetAttribute(item.uid, "description", i .. " Additional: " .. level .. ".")
            end
        end
    end
    return true
end