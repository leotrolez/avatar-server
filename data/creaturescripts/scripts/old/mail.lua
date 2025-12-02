function onMailReceive(cid, target, item, openBox)
  if(openBox) then
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getLangString(cid, "New mail has arrived.", "Nova correspondência recebida."))
  end

  return true
end
