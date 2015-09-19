local addon, ns = ...

ns.components.name = ns:create({

  repuires = {
    root = true,
    health = true,
  },

  ctor = function(self)

    local parent = self.health.frame
    local text = parent:CreateFontString(nil, "OVERLAY")

    text:SetFont("", 12, "OUTLINE")
    text:SetJustifyH("LEFT")

    text:SetTextColor(1, 1, 1)
    text:SetShadowColor(0, 0, 0)
    text:SetShadowOffset(1.25, -1.25)

    text:SetPoint("LEFT", parent, "LEFT", 4, 0)
    text:SetPoint("TOP", parent, "TOP", 4, 0)
    text:SetPoint("BOTTOM", parent, "BOTTOM", 4, 0)

  end,

  update = function(self)
    self.text:SetText(UnitName(self.unit))
  end,

})
