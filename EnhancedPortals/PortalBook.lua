local comp = require("component")
local serial = require("serialization")
local fs = require("filesystem")
local selected = 1

fs.makeDirectory("/usr/local/enhancedportals/")

local file = io.open("usr/local/enhancedportals/portalbook.tbl","r")
local portals
if file ~= nil then
	local content = file:read("*all")
	if content ~= "" then
		portals = serial.unserialize(contents)
	else
		portals = {}
	end
	file:close()
else
	portals = {}
end

local function count ( table )
	local j = 0
	for _ in pairs(table) do 
		j = j + 1
	end
	return j
end

local function incrementSelected(  )
	selected = selected + 1
	if selected > count( portals ) + 1 then
		selected = count( portals ) +1
	end
end

local function decrementSelected(  )
	selected = selected -1
	if selected == 0 then
		selected = 1
	end
end

local function deleteEntry(  )
	if portals[selected] ~= nil then
		portals[selected] = nil
	end
	-- portals update event
end

local function addEntry( name, uid )
	if selected == count(portals) + 1 then
		table.insert(portals, {end})
name

-- portals update event

