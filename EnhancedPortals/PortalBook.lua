local comp = require("component")
local serial = require("serialization")
local fs = require("filesystem")
local selected = 1
local bookAdr = "usr/local/enhancedportals/portalbook.tbl"
local portals
local term = require( "term" )
fs.makeDirectory( "/usr/local/enhancedportals/" )

local function loadPortals(  )
	local file = io.open( bookAdr,"r" )
	local x = file:read( "*all" )

	if file ~= nil then
		if x ~= "" then
			return (serial.unserialize( x ))
		else
			return({})
		end
	end
	file:close()	
end

local function savePortals(  )
	local file = io.open( bookAdr, "w")

	if file == nil then
		error("Couldn't open file: ", bookAdr)
	end
	local x = serial.serialize( portals )
	local result, msg = file:write( x )
	file:close()

	if result == nil then
		error (msg)
	end
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

local function addEntry( name, uid )
	if selected == count( portals ) + 1 then
		table.insert( portals, { name, uid })
	end
end

local function dial( uid )
	local dd = comp.ep_dialing_device
	dd.dial( uid )
	os.sleep(2)
	dd.terminate()
end

testApp(true)
local function testApp( run )
	portals = loadPortals()
	savePortals()
	dial("7-7-1") --mining age
	print("working?")
end

 