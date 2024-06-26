Config = {}

Config.ESX = 'new' -- new or old

Config.Locale = 'en' -- en, de or custom

Config.Debug = false -- Debug is only German!

Config.ReviveLocation = { x = 0.0, y = 0.0, z = 0.0 }
Config.HealLocation = { x = 0.0, y = 0.0, z = 0.0 }

Config.ReviveCost = 1000 -- Kosten für das Reviven
Config.HealCost = 500 -- Kosten für das Healen

Config.JobAccess = "ambulance" -- Beruf, der Zugriff auf den Befehl hat

Config.Marker = {
    Type = 1,
    DrawDistance = 10.0,
    Color = { r = 0, g = 255, b = 0 },
}
