exhaustion = {
	check = function (cid, storage)
		if not tonumber(getPlayerStorageValue(cid, storage)) then 
			setPlayerStorageValue(cid, storage, -1)
		end
		return getPlayerStorageValue(cid, storage) >= os.time()
	end,

	get = function (cid, storage)
		local exhaust = getPlayerStorageValue(cid, storage) + 1
		if(exhaust > 0) then
			local left = exhaust - os.time()
			if(left >= 0) then
				return left
			end
		end

		return false
	end,

	set = function (cid, storage, time)
		if time > 1 then
			time = time - 1
		end
		setPlayerStorageValue(cid, storage, os.time() + time)
	end,
        add = function (cid, storage, addtime)
            if not exhaustion.check(cid, storage) then
				return exhaustion.set(cid, storage, addtime)
            end
           local old = exhaustion.get(cid, storage)
           old = old + addtime
           return exhaustion.set(cid, storage, old)
        end,
	make = function (cid, storage, time)
		local exhaust = exhaustion.get(cid, storage)
		if(not exhaust) then
			exhaustion.set(cid, storage, time)
			return true
		end
		return false
	end
}