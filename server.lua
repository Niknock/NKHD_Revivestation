ESX = nil

if Config.ESX == 'old' then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.ESX == 'new' then
   ESX = exports["es_extended"]:getSharedObject()
else
   print('Wrong ESX Type!')
end

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

RegisterServerEvent('nkhd_revivestation:revivePlayer')
AddEventHandler('nkhd_revivestation:revivePlayer', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
        if account then
            local amount = Config.ReviveCost
            TriggerEvent('esx_billing:sendBill', source, 'society_ambulance', 'Revive', amount)
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
            TriggerEvent('esx_billing:sendBill', source, 'society_ambulance', 'Heal', amount)
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
