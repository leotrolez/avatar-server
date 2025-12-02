function getLang(cid)
  if isPlayer(cid) then
    return getPlayerStorageValue(cid, "getPlayerLang")
  else
    return EN
  end
end

function setLang(cid, lang)
  if isPlayer(cid) then
    return setPlayerStorageValue(cid, "getPlayerLang", lang)
  end
end

function getLangString(cid, en, pt)
  if getLang(cid) == EN then
    return en
  else
    return pt
  end
end

local strings = {
  ["Your target cant be disabled right now."] = "Seu alvo não pode sofrer prisões neste momento.",
  ["Your target cant be disabled for the next %ds."] = "Seu alvo não pode sofrer prisões pelos próximos %ds.",
  ["You can not use this ability in this creature now."] = "Você não pode usar essa habilidade nesta criatura, agora.",
  ["You're already using this fold."] = "Você já está sobre o efeito dessa dobra.",
  ["You can't use this fold in closed places."] = "Você não pode usar essa dobra em lugares fechados.",
  ["You can not use this ability now."] = "Você não pode usar essa habilidade agora.",
  ["It isn't possible use this fold here."] = "É impossível usar essa dobra aqui."
}

function tr(cid, string)
  if getLang(cid) == PT then
    return strings[string] or string
  end

  return string
end