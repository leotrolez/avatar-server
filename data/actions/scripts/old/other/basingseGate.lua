--[[script pogado pra CARALHO, mais foda-se
beijos do mirto! --]]

local MyLocal = {}
MyLocal.timeInMinutes = 5
MyLocal.posesOne = {{x=484,y=351, itemId=9533}, {x=484,y=352, itemId=9533}, {x=484,y=353, itemId=9533}, 
          {x=484,y=354, itemId=9533}, {x=484,y=355, itemId=9533}, {x=487,y=351, itemId=9533}, 
          {x=487,y=352, itemId=9533}, {x=487,y=353, itemId=9533}, {x=487,y=354, itemId=9533}, 
          {x=487,y=355, itemId=9533}}

MyLocal.posesTwo = {{x=542,y=388, itemId=9485}, {x=542,y=391, itemId=9485}, {x=543,y=388, itemId=9485}, 
          {x=543,y=391, itemId=9485}, {x=544,y=388, itemId=9485}, {x=544,y=391, itemId=9485}, 
          {x=545,y=388, itemId=9485}, {x=545,y=391, itemId=9485}, {x=546,y=388, itemId=9485}, 
          {x=546,y=391, itemId=9485}, {x=547,y=388, itemId=9485}, {x=547,y=391, itemId=9485}, 
          {x=548,y=388, itemId=9485}, {x=548,y=391, itemId=9485}, {x=549,y=388, itemId=9485}, 
          {x=549,y=391, itemId=9485}}

MyLocal.gateOne = {opened=false, delay=0}
MyLocal.gateTwo = {opened=false, delay=0}

local function backGateClosed(gateId)
  local poses = nil
  if gateId == 1 then
    if MyLocal.gateOne.opened == false then
      return true
    end
    MyLocal.gateOne.opened = false
    poses = MyLocal.posesOne
  else
    if MyLocal.gateTwo.opened == false then
      return true
    end
    MyLocal.gateTwo.opened = false
    poses = MyLocal.posesTwo
  end
  for h = 1, #poses do
    for j = 1, 2 do
      if j == 1 then
        poses[h].z = 7
        doCreateItem(poses[h].itemId, poses[h])  
      else
        poses[h].z = 6
        if gateId == 2 then
          doCreateItem(poses[h].itemId+1, poses[h])
        else
          doCreateItem(poses[h].itemId-1, poses[h])
        end
      end
    end
  end
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local poses = nil
  local infos = nil
  if item.actionid == 9293 then
    infos = MyLocal.gateOne
    poses = MyLocal.posesOne
    if infos.delay >= os.time() then
      local stringTime = getTimeInString(infos.delay)
      doPlayerSendCancel(cid, "You need wait "..stringTime.minute.." minute(s) and "..stringTime.second.." seconds(s) to use it again.")
      return true
    end
    infos.gateNumber = 1
    MyLocal.gateOne.delay = os.time()+(60*(MyLocal.timeInMinutes))
    if infos.opened == false then
      MyLocal.gateOne.opened = true
      sendBlueMessage(cid, "You've opened the gates of the Ba-Sing-Se, they are will close in "..(MyLocal.timeInMinutes+5).." minutes.")
      addEvent(backGateClosed, (MyLocal.timeInMinutes+5)*60*1000, 1)
    else
      MyLocal.gateOne.opened = false
      sendBlueMessage(cid, "You've closed the gates, the city has being more secure now.")

    end
  else
    infos = MyLocal.gateTwo
    poses = MyLocal.posesTwo
    if infos.delay >= os.time() then
      local stringTime = getTimeInString(infos.delay)
      doPlayerSendCancel(cid, "You need wait "..stringTime.minute.." minute(s) and "..stringTime.second.." seconds(s) to use it again.")
      return true
    end
    infos.gateNumber = 2
    MyLocal.gateTwo.delay = os.time()+(60*(MyLocal.timeInMinutes))
    if infos.opened == false then
      MyLocal.gateTwo.opened = true
      sendBlueMessage(cid, "You've opened the gates of the Ba-Sing-Se, they are will close in "..(MyLocal.timeInMinutes+5).." minutes.")
      addEvent(backGateClosed, (MyLocal.timeInMinutes+5)*60*1000, 2)
    else
      MyLocal.gateTwo.opened = false  
      sendBlueMessage(cid, "You've closed the gates, Ba-Sing-Se has being more secure now.")
    end
  end
  doTransformLever(item)

  for h = 1, #poses do
    for j = 1, 2 do
      if j == 1 then
        poses[h].z = 7
        if infos.opened == true then
          removeTileItemById(poses[h], poses[h].itemId)
        else
          doCreateItem(poses[h].itemId, poses[h])  
        end
      else
        poses[h].z = 6
        if infos.opened == true then
          if infos.gateNumber == 2 then
            removeTileItemById(poses[h], poses[h].itemId+1)
          else
            removeTileItemById(poses[h], poses[h].itemId-1)
          end    
        else
          if infos.gateNumber == 2 then
            doCreateItem(poses[h].itemId+1, poses[h])
          else
            doCreateItem(poses[h].itemId-1, poses[h])
          end
        end
      end
    end
  end
  return true
end
