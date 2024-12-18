ESX = nil

if Config.ESX == 'old' then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.ESX == 'new' then
   ESX = exports["es_extended"]:getSharedObject()
else
   print('Wrong ESX Type!')
end

if Config.UseCommand == true then
    RegisterCommand('toggleMarkers', function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == Config.JobAccess then
            TriggerClientEvent('nkhd_revivestation:toggleMarkers', -1)
        else
            if Config.Locale == 'de' then
                xPlayer.showNotification("Du hast keine Berechtigung, diesen Befehl zu benutzen.")
            elseif Config.Locale == 'en' then
                xPlayer.showNotification("You do not have permission to use this command.")
            elseif Config.Locale == 'custom' then
                xPlayer.showNotification("Your Custom locale here (server.lua).")
            end
        end
    end, false)
elseif Config.UseCommand == false then
    Citizen.CreateThread(function()
        while true do
            local hasAccess = false

            for _, playerId in ipairs(GetPlayers()) do
                local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))
                if xPlayer and xPlayer.job.name == Config.JobAccess then
                    hasAccess = true
                    break
                end
            end

            if not hasAccess then
                TriggerClientEvent('nkhd_revivestation:toggleMarkersAutoOn', -1)
            else
                TriggerClientEvent('nkhd_revivestation:toggleMarkersAutoOff', -1) 
            end

            Citizen.Wait(10000)
        end
    end)
else
    if Config.Debug == true then
        print('No Activate/Deactivate trigger loaded!')
    end
end

RegisterServerEvent('nkhd_revivestation:revivePlayer')
AddEventHandler('nkhd_revivestation:revivePlayer', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
        if account then
            local amount = Config.ReviveCost
            if Config.UseOKOKBilling == false then
                TriggerEvent('esx_billing:sendBill', source, 'society_ambulance', 'Revive', amount)
            elseif Config.UseOKOKBilling == true then
                TriggerEvent("okokBilling:CreateCustomInvoice", source, Config.ReviveCostOKOK, 'Revive', 'Hospital', ambulance, 'Ambulance')
                if Config.Debug == true then
                    print('OKOK Billing loaded Successfully')
                end
            else
                if Config.Debug == true then
                    print('No Bill method loaded!')
                end
            end
            TriggerClientEvent('esx_ambulancejob:revive', source)
            if Config.Locale == 'de' then
                xPlayer.showNotification("Du wurdest revived und eine Rechnung in Höhe von $" .. Config.ReviveCost .. " wurde von dem Krankenhaus gesendet.")
            elseif Config.Locale == 'en' then
                xPlayer.showNotification("You have been revived and got a bill of $" .. Config.ReviveCost .. " has been sent from the hospital.")
            elseif Config.Locale == 'custom' then
                xPlayer.showNotification("Your Custom locale here (server.lua).")
            end
        else
            if Config.Debug == true then
                xPlayer.showNotification("Das Konto der Gesellschaft konnte nicht gefunden werden.")
            end
        end
    end)
end)

RegisterServerEvent('nkhd_revivestation:healPlayer')
AddEventHandler('nkhd_revivestation:healPlayer', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
        if account then
            local amount = Config.HealCost
            if Config.UseOKOKBilling == false then
                TriggerEvent('esx_billing:sendBill', source, 'society_ambulance', 'Heal', amount)
            elseif Config.UseOKOKBilling == true then
                TriggerEvent("okokBilling:CreateCustomInvoice", source, Config.HealCostOKOK, 'Heal', 'Hospital', ambulance, 'Ambulance')
                if Config.Debug == true then
                    print('OKOK Billing loaded Successfully')
                end
            else
                if Config.Debug == true then
                    print('No Bill method loaded!')
                end
            end
            TriggerClientEvent('esx_basicneeds:healPlayer', source)
            if Config.Locale == 'de' then
                xPlayer.showNotification("Du wurdest gehealt und eine Rechnung in Höhe von $" .. Config.HealCost .. " wurde von dem Krankenhaus gesendet.")
            elseif Config.Locale == 'en' then
                xPlayer.showNotification("You have been healed and got a bill of $" .. Config.HealCost .. " has been sent from the hospital.")
            elseif Config.Locale == 'custom' then
                xPlayer.showNotification("Your Custom locale here (server.lua).")
            end
        else
            if Config.Debug == true then
                xPlayer.showNotification("Das Konto der Gesellschaft konnte nicht gefunden werden.")
            end
        end
    end)
end)
