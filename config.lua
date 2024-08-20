Config = {}

-- Debug mode (set to true for additional console logging)
Config.Debug = false


-- Jobs allowed to use the masterkey
Config.AllowedJobs = {
    "police",
}

-- Animation settings
Config.Animation = {
    Dict = "mp_arresting",
    Name = "a_uncuff"
}

Config.AlternativeAnimation = {
    Dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
    Name = "weed_crouch_checkingleaves_idle_01_inspector"
}

-- Progress bar settings
Config.Progressbar = {
    Duration = 2000, -- Duration in milliseconds
    Label = "Using Master Key..."
}

-- Notification messages
Config.Notifications = {
    NoVehicle = "No vehicle nearby",
    Unauthorized = "You are not authorized to use the master key",
    KeysReceived = "You received keys for vehicle: %s", -- %s will be replaced with the plate number
    Cancelled = "Cancelled using master key",
    AlreadyHaveKey = "You already have the keys to this vehicle"
}


-- Vehicle proximity check
Config.VehicleProximity = 3.0 -- Distance in meters

-- Key item (if you want to require a physical item to use the masterkey)
Config.RequireKeyItem = true
Config.KeyItemName = "masterkey"

-- Cooldown settings (to prevent spam)
Config.Cooldown = {
    Enabled = true,
    Duration = 1000 -- 1 sec cooldown in milliseconds
}

-- Server event name for acquiring vehicle keys
Config.AcquireKeysEventName = 'qb-vehiclekeys:server:AcquireVehicleKeys'

-- Whether to check if the player already has the keys before using the masterkey
Config.CheckExistingKeys = true

-- Whether to remove the masterkey item after use (if RequireKeyItem is true)
Config.RemoveKeyItemAfterUse = false

-- Sound to play when using the masterkey (set to nil to disable)
Config.UseSound = {
    Name = "unlock", -- Sound file name
    Volume = 0.5
}

-- Chance for the masterkey to break after use (0.0 to 1.0, set to 0 to disable)
Config.BreakChance = 0.1

-- Whether to allow the masterkey to work on locked vehicles
Config.WorkOnLockedVehicles = true
