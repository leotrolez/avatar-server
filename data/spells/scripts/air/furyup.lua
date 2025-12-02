local MyLocal = {}

function onCastSpell(creature, var)
	local cid = creature:getId()
         if not isPlayer(cid) then
            return false
         end

         
         if getSpellCancels(cid, "air", true) == true then
            return false
         end

         if not canPlayerStartFly(cid) then
            return false
         end

         if doPlayerAddUp(cid, true) then
            --doRemoveCondition(cid, CONDITION_BATTLE)
            return true
         else
            doPlayerSendCancelEf(cid, "You can't fly up there.")
            return false    
         end
end