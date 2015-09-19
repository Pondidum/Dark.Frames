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
    frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, 0)
    frame:SetPoint("TOPRIGHT", parent, "BOTTOMRIGHT", 0, 0)

    self.frame = frame
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

    local powerType, powerToken, altRed, altGreen, altBlue = UnitPowerType(self.unit)
    local color = self.colors.power[powerToken]

    if color then
      self.frame:SetStatusBarColor(unpack(color))
    else
      self.frame:SetStatusBarColor(altRed, altGreen, altBlue)
    end

  end,

})
