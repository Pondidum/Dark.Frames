local addon, ns = ...

local eventStore = {

  new = function(self)

    local this = {
      events = {},
      frame = CreateFrame("Frame")
    }

    this.frame:SetScript("OnEvent", function(f, name, ...)
      this:onEvent(name, ...)
    end)

    return setmetatable(this, { __index = self })

  end,

  register = function(self, name, handler)
    self.events[name] = self.events[name] or {}
    self.events[name][handler] = true

    self.frame:RegisterEvent(name)
  end,

  onEvent = function(self, name, ...)
    local handlers = self.events[name] or {}

    for handler, active in pairs(handlers) do
      if active then
        handler(name, ...)
      end
    end
  end,

}

ns.eventStore = eventStore:new()
