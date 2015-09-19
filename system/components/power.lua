local addon, ns = ...

ns.components.power = ns:create({

  requires = {
    root = true
  },

  events = {
    "UNIT_POWER_FREQUENT",
    "UNIT_POWER_BAR_SHOW",
    "UNIT_POWER_BAR_HIDE",
    "UNIT_DISPLAYPOWER",
    "UNIT_MAXPOWER",
  },

  ctor = function(self)
    local parent = self.root.frame

    local frame = CreateFrame("StatusBar", "$parentPower", parent)
    local background = frame:CreateTexture(nil, "BORDER")

    frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, 0)
    frame:SetPoint("TOPRIGHT", parent, "BOTTOMRIGHT", 0, 0)
    background:SetAllPoints(frame)

    self.frame = frame
    self.background = background
  end,

  update = function(self)

    local unit = self.unit

    local displayType = UnitPowerType(unit)
    local min, max = 0, UnitPowerMax(unit, displayType)
    local current = UnitPower(unit, displayType)

    self.frame:SetMinMaxValues(min, max)
    self.frame:SetValue(current)

  end,

  afterUpdate = function(self)
    self:setColor()
  end,

  setColor = function(self)

    local powerType, powerToken, red, green, blue = UnitPowerType(self.unit)
    local color = self.colors.power[powerToken]

    if color then
      red, green, blue = unpack(color)
    end

    self.frame:SetStatusBarColor(red, green, blue)
    self.background:SetVertexColor(red * 0.3, green * 0.3, blue * 0.3)
  end

})
