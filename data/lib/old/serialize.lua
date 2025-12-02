function serialize(v)
	if v == nil then return 'nil' end
	local  t = type(v)
	if t == "number"   then return tostring(v)
	elseif t == "string"   then return string.format("%q", v)
	elseif t == "boolean"  then return v and "true" or "false"
	elseif t == "function" then return string.format ("loadstring(%q,'@serialized')", string.dump (v))
	elseif t == "table" then
		local res = '{'
		local lastIndex = 1
		local first = true

		for i, o in pairs(v) do
			if first then
				first = false
			else
				res = res..','
			end
			if lastIndex ~= i then
				local t = type(i)
				if t ~= 'number' and (string.find(i, "%s") ~= nil or string.match(i, '^[A-Za-z]+[%w]+') ~= i) then
					res = res.."['"..i.."']"
				elseif t == 'number' then
					res = res..'['..i..']'
				else
					res = res..i
				end
				res = res..'='
			else
				lastIndex = lastIndex + 1
			end
			local _var = serialize(o)
			if _var then
				res = res.._var
			end
		end
		return res..'}'
	end
end

string.split = function(str, sep)
	local res = {}
	for v in str:gmatch("([^" .. sep .. "]+)") do
		res[#res + 1] = v
	end
	return res
end
