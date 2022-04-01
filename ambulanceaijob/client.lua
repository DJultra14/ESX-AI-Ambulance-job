







--   _____ _____  ______       _______ ______ _____          ______     __        _____       _ _    _ _   _______ _____           __ _  _   
--   / ____|  __ \|  ____|   /\|__   __|  ____|  __ \        |  _ \ \   / /       |  __ \     | | |  | | | |__   __|  __ \     /\  /_ | || |  
--  | |    | |__) | |__     /  \  | |  | |__  | |  | |       | |_) \ \_/ /        | |  | |    | | |  | | |    | |  | |__) |   /  \  | | || |_ 
--  | |    |  _  /|  __|   / /\ \ | |  |  __| | |  | |       |  _ < \   /         | |  | |_   | | |  | | |    | |  |  _  /   / /\ \ | |__   _|
--  | |____| | \ \| |____ / ____ \| |  | |____| |__| |       | |_) | | |          | |__| | |__| | |__| | |____| |  | | \ \  / ____ \| |  | |  
--   \_____|_|  \_\______/_/    \_\_|  |______|_____/        |____/  |_|          |_____/ \____/ \____/|______|_|  |_|  \_\/_/    \_\_|  |_|  
																																			
																																			

local ESX	  = nil
local pointSet = false
local BLIP_1 = nil
local currentPed = nil
local reviving = false
local player = source
local playerped = GetPlayerPed(player)
local working = false

-- ESX
Citizen.CreateThread(function()
	
	SetNuiFocus(false, false)
  
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end	
end)


-- Server Callbacks --
RegisterNetEvent("working") 
AddEventHandler("working", function ()

	if working == true then
		ESX.ShowNotification("Already Working")
	else
		working = true
	end
	
	
end)

RegisterNetEvent("workingoff") 
AddEventHandler("workingoff", function ()
	
	if working == true then
		
		working = false
	else
		ESX.ShowNotification("Not Working")
	end
	
	
end)

function workingexp()
	TriggerEvent('working')
end

function workingoffexp()
	TriggerEvent('workingoff')
end
-----------------------

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end


Citizen.CreateThread(function()

	
	time = 1000

	while true do
		
		if working == true then
		
			if pointSet == false then
				
				AiToHelpLength = tablelength(Config.Scenarios)
				randomScenario = math.random(1,AiToHelpLength)
				randomPos = Config.Scenarios[randomScenario].Pos
				ESX.ShowNotification("Patient has been " .. Config.Scenarios[randomScenario].Problem)
				ESX.ShowNotification("Location Marked")
				setPoint(randomPos)
			else
				local playerCoords = GetEntityCoords(playerped)
				local pedCoords = GetEntityCoords(ped)
				local distance = GetDistanceBetweenCoords(playerCoords, pedCoords, true)
				if distance < 5 and reviving == false then
					time = 2
					DrawText3Ds(pedCoords.x,pedCoords.y,pedCoords.z,"Press ~r~E ~s~To Revive")
					if IsControlPressed(0, 46) then
						performRevive(playerped)
					end
				else
					time = 1000
				end
			end
		else
			removePoint()
		end
		
		
		Citizen.Wait(time)
		
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
	  RequestAnimDict(dict)
	  Citizen.Wait(5)
	end
  end

function performRevive(playerPed)
	
	reviving = true
	loadAnimDict("mini@cpr@char_a@cpr_str")
	loadAnimDict("mini@cpr@char_a@cpr_def")


	ESX.ShowNotification("Attempting ~r~CPR~w~!")
	TaskPlayAnim(playerPed, "mini@cpr@char_a@cpr_def", "cpr_intro", 8.0, 1.0, -1, 2, 0, 0, 0, 0) 
	Wait(10000)
	TaskPlayAnim(playerPed, "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
	
	Wait(10000)
	ESX.ShowNotification("~r~CPR~w~ Successful!")
	ClearPedTasks(playerPed)
	
	TriggerServerEvent('reviveAImoney')
	pedDone(currentPed)

	
end

function setPoint(pos)
	removePoint()
	pointSet = true
	BLIP_1 = AddBlipForCoord(pos.x,pos.y,pos.z)
	SetBlipScale(BLIP_1 ,2.0)
	SetBlipSprite(BLIP_1, 153)
	SetBlipColour(BLIP_1, 2)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Injured Person")
	EndTextCommandSetBlipName(BLIP_1)
	
	
	SetBlipRoute(BLIP_1,  true) 	
	--SetBlipRouteColour( blip,  colour )
	createPed(pos)
end

function removePoint()
	if BLIP_1 ~= nil then
		RemoveBlip(BLIP_1)
		BLIP_1 = nil	
		removePed()
		reviving = false
		pointSet = false
	end	
end

function removePed()
	DeleteEntity(currentPed)
	
end

function createPed(pos)

	PedLength = tablelength(Config.Peds)
	randomPed = math.random(1,PedLength)
	local hash = GetHashKey(Config.Peds[randomPed])

	RequestModel(hash)
	while not HasModelLoaded(hash) do Citizen.Wait(0) end
	ped = CreatePed(28, hash, pos.x, pos.y, pos.z, 0.0, true, true)
	
    SetEntityHeading(ped, 100)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

	AnimLength = tablelength(Config.Animations)
	randomAnim = math.random(1,AnimLength)
	
	

	TaskStartScenarioInPlace(ped, Config.Animations[randomAnim])
	currentPed = ped
end

function pedDone(ped)
	FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    SetBlockingOfNonTemporaryEvents(ped, false)
	ClearPedTasks(ped)
	Wait(10000)
	DeleteEntity(ped)
	removePoint()
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end




