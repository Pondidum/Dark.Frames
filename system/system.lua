local addon, ns = ...

ns.components = {
}

ns.units = {
  player = {
    requires = {
      health = true
    }
  },
}

ns.create = function(self, config)
  return setmetatable({}, { __index = config })
end

ns.buildGraph = function(self)

  local isEmpty = function(t)
    return next(t) == nil
  end

  local ordered = {}
  local stack = { "root" }

  while not isEmpty(stack) do

    local currentNode = table.remove(stack)
    table.insert(ordered, currentNode)

    for otherName, otherNode in pairs(self.components) do
      if otherNode.requires[currentNode] then
        otherNode.requires[currentNode] = nil
        if isEmpty(otherNode.requires) then
          table.insert(stack, otherName)
        end
      end
    end

  end

  return ordered
end

ns.build = function(self)

  local components = self:buildGraph()

  for unitName, unit in pairs(self.units) do

    local root = self.components.root:new(unitName)

    for i, name in ipairs(components) do

      if unit.requires[name] then
        root[name] = self.components[name]:new()
      end

    end

  end

end
