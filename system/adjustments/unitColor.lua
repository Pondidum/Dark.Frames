local addon, ns = ...

ns.components.health.afterUpdate = function(self)

  local unit = self.unit

  local colors = self.colors
  local color

  if UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
    color = colors.tapped
  elseif not UnitIsConnected(unit) then
    color = colors.disconnected
  elseif UnitIsPlayer(unit) or (UnitIsPlayerControlled(unit) and not UnitIsPlayer(unit)) then
    local _, class = UnitClass(unit)
    color = colors.class[class]
  elseif UnitReaction(unit, 'player') then
    local reaction = UnitReaction(unit, 'player')
    color = colors.reaction[reaction]
  else
    color = colors.health
  end

  local red, green, blue = unpack(color)

  self.frame:SetStatusBarColor(red, green, blue)
  self.background:SetVertexColor(red * 0.3, green * 0.3, blue * 0.3)

end
