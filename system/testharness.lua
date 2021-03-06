local addon = "TestHarness"
local ns = {}

print("Creating Environment...")
require("wowframeapi")
print("Done.")

local files = {
  "colors.lua",
  "eventStore.lua",
  "components.lua",
  "system.lua",
  "components\\root.lua",
  "components\\health.lua",
  "components\\power.lua",
  "components\\name.lua",
  "adjustments\\unitColor.lua"
}

print("Loading files...")

for i, path in ipairs(files) do

  print(string.format("Loading %s", path))
  local fn, message = loadfile(path)

  if not fn then
    print("Error", message)
    return
  end

  fn(addon, ns)

end

print("Done.")
print("Building interface...")

local frames = ns:build()
print("Done.")

for i, frame in ipairs(frames) do
  print(i, frame.unit, frame.health)
end


print("firing event")
RaiseEvent("UNIT_HEALTH_FREQUENT")
