-- https://www.lua.org/pil/11.4.html
List = {}
function List:new()
    local l = {first = 0, last = -1}
    setmetatable(l, self)
    self.__index = self
    return l
end

function List:pushLeft(value)
    local first = self.first - 1
    self.first = first
    self[first] = value
end

function List:pushRight(value)
    local last = self.last + 1
    self.last = last
    self[last] = value
end

function List:size()
    return self.last + 1 - self.first
end

function List:empty()
    return self.first > self.last
end

function List:popLeft()
    local first = self.first
    if self:empty() then error("list is empty") end
    local value = self[first]
    self[first] = nil        -- to allow garbage collection
    self.first = first + 1
    return value
end

function List:popRight()
    local last = self.last
    if self:empty() then error("list is empty") end
    local value = self[last]
    self[last] = nil         -- to allow garbage collection
    self.last = last - 1
    return value
end

return List
