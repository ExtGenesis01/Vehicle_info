ESX = exports["es_extended"]:getSharedObject()

local config = require('config.shared')

local function OpenVehicleMenu1()
    local playerPed = cache.ped
     
    
    if IsPedInAnyVehicle(playerPed, false)  then
        local vehicle = GetVehiclePedIsIn(playerPed, false)  
        
        local vehicleModelHash = GetEntityModel(vehicle)
        local vehicleSpawnCode = string.lower(GetDisplayNameFromVehicleModel(vehicleModelHash))
        local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(vehicleModelHash))
        local vehicleClass = config.class[vehicleSpawnCode] or 'We are unsure of this class'
        local vehiclePlate = GetVehicleNumberPlateText(vehicle)
    

            lib.notify({
                description = 'I Might want to go and see a mechanic for more details',
                type = 'inform',
                position = 'top'
            })
            Citizen.Wait(1000)
            exports.bulletin:Send({
                message = 'Name: ' .. vehicleName,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Plate: ' .. vehiclePlate,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Class: ' .. vehicleClass,
                timeout = 5000,
                theme = 'default'
            })
    else
        lib.notify({ description = 'You are not in a vehicle', type = 'error' })
     end 
end

local function OpenVehicleMenu2()
    local playerPed = cache.ped
    local properties = lib.getVehicleProperties(GetVehiclePedIsUsing(PlayerPedId()))
    
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
        local vehicleModelHash = GetEntityModel(vehicle) or vehicle_names.lua
        local vehicleSpawnCode = string.lower(GetDisplayNameFromVehicleModel(vehicleModelHash))
        local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(vehicleModelHash))
        local vehicleClass = config.class[vehicleSpawnCode] or 'We are unsure of this class'
        local vehiclePlate = GetVehicleNumberPlateText(vehicle)

        local engineMod = GetVehicleMod(vehicle, 11) 
        local brakeMod = GetVehicleMod(vehicle, 12)
        local suspensionMod = GetVehicleMod(vehicle, 13) 
        local transmissionMod = GetVehicleMod(vehicle, 13) 
        local turboEnabled = IsToggleModOn(vehicle, 18) 

        local engineHealth = properties.engineHealth
        local healthPercent = (engineHealth / 1000) * 100
        
        engineMod = engineMod ~= -1 and tostring(engineMod).. "" or 'Stock'
        brakeMod = brakeMod ~= -1 and tostring(brakeMod).." " or 'Stock'
        suspensionMod = suspensionMod ~= -1 and tostring(suspensionMod).." " or 'Stock'
        transmissionMod = transmissionMod ~= -1 and tostring(transmissionMod).." " or 'Stock'

        healthPercent = healthPercent ~= 1 and tostring(healthPercent) .. "%"
           
        if ESX.GetPlayerData().job.name == 'police' and  ESX.GetPlayerData().job.grade >= 1 then
            local alert = lib.alertDialog({
                header = 'IMPORTANT !!!',
                content = 'If they need to know how badly damaged thier vehicle is please direct them to TBT',
                centered = true,
            })

            exports.bulletin:Send({
                message = 'Name: ' .. vehicleName,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Plate: ' .. vehiclePlate,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Class: ' .. vehicleClass,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Engine: ' .. engineMod,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Brakes: ' .. brakeMod,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Suspension: ' .. suspensionMod,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Transmission: ' .. transmissionMod,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Turbo: ' .. (turboEnabled and 'Enabled' or 'Disabled'),
                timeout = 5000,
                theme = 'default'
            })
        end 
        if ESX.GetPlayerData().job.name == 'mechanic' and  ESX.GetPlayerData().job.grade >= 0 then 
            
            local alert = lib.alertDialog({
                header = 'IMPORTANT !!!',
                content = 'If they need to know any vehicle upgrades Please direct them to Rat Repairs',
                centered = true,
            })

            exports.bulletin:Send({
                message = 'Name: ' .. vehicleName,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Plate: ' .. vehiclePlate,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Class: ' .. vehicleClass,
                timeout = 5000,
                theme = 'default'
            })
            exports.bulletin:Send({
                message = 'Vehicle Health:' .. healthPercent,
                timeout = 5000,
                theme = 'default'
            })
        end
    else
        lib.notify({ description = 'You are not in a vehicle', type = 'error' })
    end
end

RegisterCommand('vehinfo', function()
    if ESX.GetPlayerData().job.name == 'police' and  ESX.GetPlayerData().job.grade >= 1 or ESX.GetPlayerData().job.name == 'mechanic' and  ESX.GetPlayerData().job.grade >= 0 then 
        OpenVehicleMenu2()
    else
       OpenVehicleMenu1()
    end
end, false)



