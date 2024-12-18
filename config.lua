Config = {}

Config.ESX = 'new'                                                  -- new or old

Config.Locale = 'en'                                                -- en, de or custom

Config.Debug = false

Config.ReviveLocation = { x = 0.0, y = 0.0, z = 0.0 } 
Config.HealLocation = { x = 0.0, y = 0.0, z = 0.0 } 

Config.ReviveCost = 1000                                            -- How much you should Pay if you get Revived
Config.HealCost = 500                                               -- How much you should Pay if you get Healed
Config.UseOKOKBilling = true                                        -- true if you use OKOK Billing
Config.ReviveCostOKOK = '1000'                                      -- How much you should Pay if you get Revived | Change only if you use OKOK Billing
Config.HealCostOKOK = '500'                                         -- How much you should Pay if you get Healed | Change only if you use OKOK Billing

Config.UseCommand = false                                           -- true if an Medic should use an Command to activate the Triggers | if false script will search if an Person with the Job in Config.JobAccess is online if not the triggers automaticly get spawned
Config.JobAccess = "ambulance"                                      -- Jobs, which can use the Command or get automaticly searched

Config.Marker = {
    Type = 1,
    DrawDistance = 10.0,
    Color = { r = 0, g = 255, b = 0 },
}
