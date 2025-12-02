Room = {
    tiles = {},
    edgeTiles = {},
    connectedRooms = {},
    roomSize = 0,
    isAccessibleFromMainRoom = false,
    isMainRoom = false,
}

function Room.newEmpty()
    return {
        tiles = {},
        edgeTiles = {},
        connectedRooms = {},
        roomSize = 0,
        isAccessibleFromMainRoom = false,
        isMainRoom = false
    }
end

function Room.new(roomTiles, map)
    tiles = roomTiles
    roomSize = #tiles
    edgeTiles = {}
    connectedRooms = {}
    
    for index, tile in ipairs(tiles) do
        for x = tile.tileX-1, tile.tileX+1, 1 do
            for y = tile.tileY-1, tile.tileY+1, 1 do
                if x == tile.tileX or y == tile.tileY then
                   if map[x][y] == 1 then
                        table.insert(edgeTiles,tile)
                   end
                end
            end
        end
    end

    return {
        tiles = tiles,
        roomSize = roomSize,
        edgeTiles = edgeTiles,
        connectedRooms = connectedRooms,
        isAccessibleFromMainRoom = false,
        isMainRoom = false
    }
end

function Room:SetAccessibleFromMainRoom()
    if self.isAccessibleFromMainRoom == false then
        self.isAccessibleFromMainRoom = true
        for index, connectedRoom in ipairs(self.connectedRooms) do
            Room.SetAccessibleFromMainRoom(connectedRoom)
            --connectedRoom:SetAccessibleFromMainRoom()
        end
    end
end

function Room.isConnected(otherRoom)
    return table.contains(self.connectedRooms,otherRoom)
end

function ConnectRooms(roomA,roomB)
    if roomA.isAccessibleFromMainRoom then
        Room.SetAccessibleFromMainRoom(roomB)
        --roomA:SetAccessibleFromMainRoom()
    elseif roomB.isAccessibleFromMainRoom then
        Room.SetAccessibleFromMainRoom(roomA)
        --roomB:SetAccessibleFromMainRoom()
    end
    table.insert(roomA.connectedRooms,roomB)
    table.insert(roomB.connectedRooms,roomA)
end

function sign(n)
    return n==0 and 0 or math.abs(n)/n
end