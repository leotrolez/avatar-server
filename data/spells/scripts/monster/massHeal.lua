function onCastSpell(creature, var)
	local cid = creature:getId()
    if getCreatureHealth(cid) < getCreatureMaxHealth(cid)*0.99 then
        doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
        return true
    end
end