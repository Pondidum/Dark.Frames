local addon, ns = ...

local events = ns.eventStore:new()
ns.components = {}

ns.units = {
  player = {
    requires = {
      health = true
    }
  },
}

local componentMeta = {

  requires = {},
  events = {},

  new = function(self, unit)

    local this = {
      unit = unit
    }

    setmetatable(this, { __index = self })
    this:ctor()
    this:registerEvents()

    return this
  end,

  ctor = function(self)
  end,

  registerEvents = function(self)

    local wrapper = function(e, ...)
      self:onEvent(e, ...)
    end

    for eventName, active in pairs(self.events) do
      events:register(eventName, wrapper)
    end

  end,

  onEvent = function(self, event, ...)
    self:beforeUpdate(event, ...)
    self:update(event, ...)
    self:afterUpdate(event, ...)
  end,
}

ns.create = function(self, config)
  return setmetatable(config, { __index = componentMeta })
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

  local frames = {}

  for unitName, unit in pairs(self.units) do

    local root = self.components.root:new(unitName)

    for i, name in ipairs(components) do

      if unit.requires[name] then
        root[name] = self.components[name]:new()
      end

    end

    table.insert(frames, root)

  end

  return frames

end
