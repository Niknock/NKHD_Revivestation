ESX = nil
local markersVisible = false

Citizen.CreateThread(function()
    while ESX == nil do
        if Config.ESX == 'old' then
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        elseif Config.ESX == 'new' then
            ESX = exports["es_extended"]:getSharedObject()
        else
            print('Wrong ESX Type!')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if markersVisible then
            DrawMarker(Config.Marker.Type, Config.ReviveLocation.x, Config.ReviveLocation.y, Config.ReviveLocation.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, 100, false, true, 2, nil, nil, false)
            DrawMarker(Config.Marker.Type, Config.HealLocation.x, Config.HealLocation.y, Config.HealLocation.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, 100, false, true, 2, nil, nil, false)

            local playerCoords = GetEntityCoords(PlayerPedId())
            local distanceToRevive = #(playerCoords - vector3(Config.ReviveLocation.x, Config.ReviveLocation.y, Config.ReviveLocation.z))
            local distanceToHeal = #(playerCoords - vector3(Config.HealLocation.x, Config.HealLocation.y, Config.HealLocation.z))

            if distanceToRevive < 1.5 then
                if Config.Locale == 'de' then
                    ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um dich zu reviven ($" .. Config.ReviveCost .. ")")
                elseif Config.Locale == 'en' then
                    ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to revives yourself ($" .. Config.ReviveCost .. ")")
                elseif Config.Locale == 'custom' then
                    ESX.ShowHelpNotification("Your Custom locale here (client.lua).")
                end
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('nkhd_revivestation:revivePlayer')
                end
            elseif distanceToHeal < 1.5 then
                if Config.Locale == 'de' then
                    ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um dich zu healen ($" .. Config.ReviveCost .. ")")
                elseif Config.Locale == 'en' then
                    ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to heal yourself ($" .. Config.ReviveCost .. ")")
                elseif Config.Locale == 'custom' then
                    ESX.ShowHelpNotification("Your Custom locale here (client.lua).")
                end
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('nkhd_revivestation:healPlayer')
                end
            end
        end
    end
end)

RegisterNetEvent('nkhd_revivestation:toggleMarkers')
AddEventHandler('nkhd_revivestation:toggleMarkers', function()
    if markersVisible == false then
        markersVisible = true
    else
        markersVisible = false
    end
end)
