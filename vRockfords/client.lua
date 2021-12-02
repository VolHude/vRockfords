ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)


Citizen.CreateThread(function()
    if RockfordStudio.jeveuxblips then
    local rockfordsmap = AddBlipForCoord(RockfordStudio.pos.blips.position.x, RockfordStudio.pos.blips.position.y, RockfordStudio.pos.blips.position.z)
    SetBlipSprite(rockfordsmap, 184)
    SetBlipColour(rockfordsmap, 42)
    SetBlipScale(rockfordsmap, 0.65)
    SetBlipAsShortRange(rockfordsmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Rockfords studio")
    EndTextCommandSetBlipName(rockfordsmap)
    end
end)

function Menuf6Rockfords()
    local vRockfordf6 = RageUI.CreateMenu("Rockfords Studio", "Interactions")
    vRockfordf6:SetRectangleBanner(30, 144, 255)
    RageUI.Visible(vRockfordf6, not RageUI.Visible(vRockfordf6))
    while vRockfordf6 do
        Citizen.Wait(0)
            RageUI.IsVisible(vRockfordf6, true, true, true, function()

                RageUI.Separator("↓ Camera/Micro ↓")

                RageUI.ButtonWithStyle("Sortir/Rentrer Camera",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand('cam')
                        RageUI.CloseAll()
                    end
                end)

                RageUI.ButtonWithStyle("Sortir/Rentrer Micro",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand('mic')
                        RageUI.CloseAll()
                    end
                end)


                RageUI.Separator("↓ Facture ↓")

                RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_rockford', ('Rockfords studio'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)


                RageUI.Separator("↓ Annonce ↓")



                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('vRockfords:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('vRockfords:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('vRockfords:Perso', msg)
                    end
                end)
                end, function() 
                end)
    
                if not RageUI.Visible(vRockfordf6) then
                    vRockfordf6 = RMenu:DeleteType("Rockfords studio", true)
        end
    end
end

Keys.Register('F6', 'rockford', 'Ouvrir le menu rockford studio', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'rockford' then
    	Menuf6Rockfords()
	end
end)

function OpenPrendreMenu()
    local PrendreMenu = RageUI.CreateMenu("Rockford studio", "Nos produits")
    PrendreMenu:SetRectangleBanner(30, 144, 255)
        RageUI.Visible(PrendreMenu, not RageUI.Visible(PrendreMenu))
    while PrendreMenu do
        Citizen.Wait(0)
            RageUI.IsVisible(PrendreMenu, true, true, true, function()
            for k,v in pairs(Bar.item) do
            RageUI.ButtonWithStyle(v.Label.. ' Prix: ' .. v.Price .. '€', nil, { }, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('vRockfords:bar', v.Name, v.Price)
                end
            end)
        end
                end, function() 
                end)
    
                if not RageUI.Visible(PrendreMenu) then
                    PrendreMenu = RMenu:DeleteType("Rockford Studio", true)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'rockford' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, RockfordStudio.pos.MenuPrendre.position.x, RockfordStudio.pos.MenuPrendre.position.y, RockfordStudio.pos.MenuPrendre.position.z)
        if dist3 <= 7.0 and RockfordStudio.jeveuxmarker then
            Timer = 0
            DrawMarker(20, RockfordStudio.pos.MenuPrendre.position.x, RockfordStudio.pos.MenuPrendre.position.y, RockfordStudio.pos.MenuPrendre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 30, 144, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au bar", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenPrendreMenu()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)



function CoffreRockfords()
    local Crockford = RageUI.CreateMenu("Coffre", "Rockford studio")
    Crockford:SetRectangleBanner(30, 144, 255)
        RageUI.Visible(Crockford, not RageUI.Visible(Crockford))
            while Crockford do
            Citizen.Wait(0)
            RageUI.IsVisible(Crockford, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RockfordRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RockfordDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Crockford) then
            Crockford = RMenu:DeleteType("Crockford", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'rockford' then
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, RockfordStudio.pos.coffre.position.x, RockfordStudio.pos.coffre.position.y, RockfordStudio.pos.coffre.position.z)
            if jobdist <= 10.0 and RockfordStudio.jeveuxmarker then
                Timer = 0
                DrawMarker(20, RockfordStudio.pos.coffre.position.x, RockfordStudio.pos.coffre.position.y, RockfordStudio.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 30, 144, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        CoffreRockfords()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)


-- Garage

function GarageRockford()
  local GRockford = RageUI.CreateMenu("Garage", "Rockford Studio")
  GRockford:SetRectangleBanner(30, 144, 255)
    RageUI.Visible(GRockford, not RageUI.Visible(GRockford))
        while GRockford do
            Citizen.Wait(0)
                RageUI.IsVisible(GRockford, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GRockfordvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarRockford(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GRockford) then
            GRockford = RMenu:DeleteType("Garage", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'rockford' then
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, RockfordStudio.pos.garage.position.x, RockfordStudio.pos.garage.position.y, RockfordStudio.pos.garage.position.z)
            if dist3 <= 10.0 and RockfordStudio.jeveuxmarker then
                Timer = 0
                DrawMarker(20, RockfordStudio.pos.garage.position.x, RockfordStudio.pos.garage.position.y, RockfordStudio.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 30, 144, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageRockford()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarRockford(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, RockfordStudio.pos.spawnvoiture.position.x, RockfordStudio.pos.spawnvoiture.position.y, RockfordStudio.pos.spawnvoiture.position.z, RockfordStudio.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Rockford Studio"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end



itemstock = {}
function RockfordRetirerobjet()
    local StockRockford = RageUI.CreateMenu("Coffre", "Rockford Studio")
    StockRockford:SetRectangleBanner(30, 144, 255)
    ESX.TriggerServerCallback('vRockfords:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(StockRockford, not RageUI.Visible(StockRockford))
        while StockRockford do
            Citizen.Wait(0)
                RageUI.IsVisible(StockRockford, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('vRockfords:getStockItem', v.name, tonumber(count))
                                    RockfordRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockRockford) then
            StockRockford = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function RockfordDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Rockford Studio")
    StockPlayer:SetRectangleBanner(30, 144, 255)
    ESX.TriggerServerCallback('vRockfords:getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Citizen.Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('vRockfords:putStockItems', item.name, tonumber(count))
                                            RockfordDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end