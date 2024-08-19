
# Installation
* Download ZIP
* Make sure your [qb-vehiclekeys](https://github.com/qbcore-framework/qb-vehiclekeys) is fully updated to the latest version.
* Drag and drop resource into your server files
* Start resource through server.cfg
* Drag and drop image into qb-inventory\html\images
* Paste Masterkey in items.lua
* Restart your server.

Go To qb-core/shared/items.lua
```lua
-- MasterKey
 	["masterkey"]=          {["name"] = "masterkey",        ["label"] = "Car Unlocker",			["weight"] = 0, ["type"] = "item",  ["image"] = "masterkey.png",        ["unique"] = true,  ["useable"] = true,["shouldClose"] = true, ["description"] = "A MasterKey For Unlock Any Car"},
```
Go To qb-vehiclekeys/server/main.lua  And Search function HasKeys 
Add Following Code [preview](https://imgur.com/s7qDxIP)
```lua
-- HasKeys function
function HasKeys(id, plate)
local citizenid = QBCore.Functions.GetPlayer(id).PlayerData.citizenid
if VehicleList[plate] and VehicleList[plate][citizenid] then
return true
end
return false
end

-- Modified callback without MySQL dependency
QBCore.Functions.CreateCallback('qb-vehiclekeys:server:CheckHasKey', function(source, cb, plate)
local src = source
local hasKey = HasKeys(src, plate)

if hasKey then
cb(true)
else
-- If the player doesn't have the key in VehicleList, we return false
cb(false)
end
end)
```
