local addon, ns = ...

ns.components.health.afterUpdate = function(self)

  local unit = self.unit

  local colours = self.colours
  local colour

  if UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
    colour = colours.tapped
  elseif not UnitIsConnected(unit) then
    colour = colours.disconnected
  elseif UnitIsPlayer(unit) or (UnitIsPlayerControlled(unit) and not UnitIsPlayer(unit)) then
    local _, class = UnitClass(unit)
    colour = colours.class[class]
  elseif UnitReaction(unit, 'player') then
    local reaction = UnitReaction(unit, 'player')
    colour = colours.reaction[reaction]
  else
    colour = colours.health
  end

  local red, green, blue = unpack(colour)

  self.frame:SetStatusBarColor(red, green, blue)
  self.background:SetVertexColor(red * 0.3, green * 0.3, blue * 0.3)

end
