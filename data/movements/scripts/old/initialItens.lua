function onStepIn(cid, item, position, fromPosition)
  if isPlayer(cid) then
    if getPlayerStorageValue(cid, "playerStartOnInitialIten") == -1 then
      local text = nil
      if getLang(cid) == EN then
        text = "Attention! You need choose one between these itens, for get.\nEach chest contains a one type of weapon and skill,you can\nonly pick one, you can train another type of skill in the future\nif you want."
      else
        text = "Atencao! Você precisa escolher uma classe de arma para comecar\no jogo! Cada baú contem uma classe e seu respectivo bônus skill,\nvocê poderá treinar outro skill no futuro caso deseje."
      end
      doPlayerPopupFYI(cid, text)
      setPlayerStorageValue(cid, "playerStartOnInitialIten", 1)
    end
  end
  return true
end