if(result == nil) then
	print("> WARNING: Couldn't load database lib.")
	return
end

Result = createClass(nil)
Result:setAttributes({
	id = -1
})

function Result:getID()
	return self.id
end

function Result:setID(_id)
	self.id = _id
end

function Result:getRows(free)
	if(self:getID() == -1) then
		error("[Result:getRows]: Result not set!")
	end

	local c = 0
	repeat
		c = c + 1
	until not self:next()

	if(free) then
		self:free()
	end

	return c
end

function Result:getDataInt(s)
	if(self:getID() == -1) then
		error("[Result:getDataInt]: Result not set!")
	end

	return result.getDataInt(self:getID(), s)
end

function Result:getDataLong(s)
	if(self:getID() == -1) then
		error("[Result:getDataLong]: Result not set!")
	end

	return result.getDataLong(self:getID(), s)
end

function Result:getDataString(s)
	if(self:getID() == -1) then
		error("[Result:getDataString]: Result not set!")
	end

	return result.getDataString(self:getID(), s)
end

function Result:getDataStream(s)
	if(self:getID() == -1) then
		error("[Result:getDataStream]: Result not set!")
	end

	return result.getDataStream(self:getID(), s)
end

function Result:next()
	if(self:getID() == -1) then
		error("[Result:next]: Result not set!")
	end

	return result.next(self:getID())
end

function Result:free()
	if(self:getID() == -1) then
		error("[Result:free]: Result not set!")
	end

	--local ret = result.free(self:getID()) //enviroment automaticly frees all stored results when script is finished
	local ret = LUA_NO_ERROR
	self:setID(-1)
	return ret
end

Result.numRows = Result.getRows
function db.getResult(query)
	if(type(query) ~= 'string') then
		return nil
	end

	local res = Result:new()
	res:setID(db.storeQuery(query))
	return res
end
