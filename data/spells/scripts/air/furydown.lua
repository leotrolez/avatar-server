local MyLocal = {}
function onCastSpell(creature, var)
	local cid = creature:getId()
         if not(isPlayer(cid)) then
            return false
         end
         if getSpellCancels(cid, "air", true) == true then
            return false
         end
         local currentPosition = getCreaturePosition(cid)
         local newPosition = {x=currentPosition.x,y=currentPosition.y,z=currentPosition.z+1,stackpos=0}

         if not getPlayerCanWalk({player = cid, position = newPosition, checkPZ = false, checkHouse = true, createTile = true}) then
            doPlayerSendCancel(cid, "You can't fly down there.")
            return false
         end

         if doPlayerDown(cid, false) then
            --doRemoveCondition(cid, CONDITION_BATTLE)
            return true
         else
            doPlayerSendCancel(cid, "You can't go down without be flying.")
         return false    
         end
end