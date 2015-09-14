local addon, ns = ...

local eventStore = ns.eventStore

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

    for i, eventName in ipairs(self.events) do
      eventStore:register(eventName, wrapper)
    end

  end,

  onEvent = function(self, event, ...)
    self:beforeUpdate(event, ...)
    self:update(event, ...)
    self:afterUpdate(event, ...)
  end,

  beforeUpdate = function()
  end,

  update = function()
  end,

  afterUpdate = function()
  end,
}

ns.components = {}
ns.create = function(self, config)
  return setmetatable(config, { __index = componentMeta })
end
