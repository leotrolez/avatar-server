function onStepIn(cid, item, position, fromPosition)

    if isPlayer(cid) then
        local canPass = true

        if getPlayerStorageValue(cid, "canPassPoiReward") == 1 then
            return true
        end

        for x = 1, 6 do
            if getPlayerStorageValue(cid, "poiReward"..x) == -1 then
                doTeleportThing(cid, fromPosition, true)
                doPlayerSendCancel(cid, getLangString(cid, "Sorry, you need complete all rooms to pass here.", "Você precisa completar todas as salas para passar aqui."))
                canPass = false
                break
            end
        end

        if canPass then
            setPlayerStorageValue(cid, "canPassPoiReward", 1)
        else
            setCreatureNoMoveTime(cid, 500)
        end
    end

  return true
end
