local addon, ns = ...

ns.components.root = ns:create({
  requires = {},
  ctor = function(self)
    self.frame = CreateFrame("Frame", "DarkUnit" .. self.unit, "UIParent")
    self.frame:SetSize(280, 50)
  end,
})
