local posesGrade = {{x=197,y=338,z=10}, {x=197,y=339,z=10}}
 
 
local function createStone()
        local st = getTileItemById(posesGrade[1], 1543)
        if st.itemid == 0 then
            doCreateItem(1543, posesGrade[1])
            doCreateItem(1543, posesGrade[2])
        end
    return true
end
 
local function removeStone()
    local st = getTileItemById(posesGrade[1], 1543)
        if st.uid > 0 then
            doRemoveThing(st.uid)
            doRemoveThing(getTileItemById(posesGrade[2], 1543).uid)
        end
    return true
end
 
function onStepIn(cid, item)
    if item.itemid == 426 then
     doTransformItem(item.uid, 425)
    end
    if isPlayer(cid) then
     removeStone()
    end
    return true
end
 
function onStepOut(cid, item)
    if item.itemid == 425 then
     doTransformItem(item.uid, 426)
    end
    if isPlayer(cid) then
     createStone()
    end
    return true
end