local addon = "TestHarness"
local ns = {}

local files = {
  "system.lua",
  "components\\health.lua",
}

print("Loading files...")

for i, path in ipairs(files) do

  print(string.format("Loading %s...", path))
  local fn, message = loadfile(path)

  if not fn then
    print("Error", message)
    return
  end

  fn(addon, ns)

end

print("Done.")
