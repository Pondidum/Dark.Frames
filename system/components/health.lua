local addon, ns = ...

ns.components.health = ns:create({

  requires = {
    root = true,
  },

  events = {
    'UNIT_HEALTH_FREQUENT',
    'UNIT_MAXHEALTH',
    'UNIT_CONNECTION',
  },

  ctor = function(self)
    local frame = CreateFrame("StatusBar", "$parentHealth", self.root)
    local background = frame:CreateTexture(nil, "BORDER")
    local text = frame:CreateFontString(nil, "OVERLAY")

    frame:SetAllPoints(self.root.frame)
    background:SetAllPoints(frame)
    text:SetPoint("RIGHT", frame, "RIGHT", -4, 0)

    --text:SetFont(font, size, style)
    text:SetShadowColor(0, 0, 0)
    text:SetShadowOffset(1.25, -1.25)

    self.frame = frame
    self.background = background
    self.text = text

  end,

  update = function(self)

    local min, max = 0, UnitMaxHealth(self.unit)
    local current = UnitHealth(self.unit)

    self:updateBar(min, max, current)
    self:updateText(min, max, current)

  end,

  updateBar = function(self, min, max, current)
    self.frame:SetMinMaxValues(min, max)
    self.frame:SetValue(current)
  end,

  updateText = function(self, min, max, current)

    local text = self.text
    local unit = self.unit

    if not UnitIsConnected(unit) then
      text:SetText("Disconnected")

    elseif UnitIsDead(unit) then
      text:SetText("Dead")

    elseif UnitIsGhost(unit) then
      text:SetText("Ghost")

    elseif current ~= max then
      text:SetText(self:shortValue(current) .. " | " .. floor(current / max * 100) .. "%")

    else
      text:SetText(self:shortValue(max))

    end

  end,

  shortValue = function(self, v)

    if v == nil then
      return 0
    end

    if v >= 1e6 then
      return ("%.1fm"):format(v / 1e6):gsub("%.?0+([km])$", "%1")
    elseif v >= 1e3 or v <= -1e3 then
      return ("%.1fk"):format(v / 1e3):gsub("%.?0+([km])$", "%1")
    end

    return v

  end

})
