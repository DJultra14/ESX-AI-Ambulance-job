local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterCommand("AmbulanceAI",  function (source)

    if isAmbulance(source) then
        TriggerClientEvent('working', source)
    else
        xPlayer.showNotification("Your not a ambulance")
    end

    
end, false)


RegisterCommand("AmbulanceAIOff",  function (source)

    
    if isAmbulance(source) then
        TriggerClientEvent('workingoff', source)
    else
        xPlayer.showNotification("Your not a ambulance")
    end

    
end, false)
-- Client Callbacks --
RegisterNetEvent("reviveAImoney") 
AddEventHandler("reviveAImoney", function ()
    
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney('bank', Config.Pay)
    xPlayer.showNotification("You got £" .. Config.Pay .. " for helping this patient")

end)
------------------------
function isAmbulance(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    if job == Config.AmbulanceJobName then
        return true
    else
        return false
    end
end