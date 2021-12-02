ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyrockfordmoney = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
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

---------------- FONCTIONS ------------------

function Bossrockford()
  local vrockford = RageUI.CreateMenu("Actions Patron", "Rockfords Studio")
  vrockford:SetRectangleBanner(30, 144, 255)
    RageUI.Visible(vrockford, not RageUI.Visible(vrockford))

            while vrockford do
                Citizen.Wait(0)
                    RageUI.IsVisible(vrockford, true, true, true, function()

                    if societyrockfordmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyrockfordmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'rockford', amount)
                                RefreshRockfordMoney()
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'rockford', amount)
                                RefreshRockfordMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            aboss()
                            RageUI.CloseAll()
                        end
                    end)

                    end, function()
                end)
            if not RageUI.Visible(vrockford) then
            vrockford = RMenu:DeleteType("Actions Patron", true)
        end
    end
end   

---------------------------------------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'rockford' and ESX.PlayerData.job.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, RockfordStudio.pos.boss.position.x, RockfordStudio.pos.boss.position.y, RockfordStudio.pos.boss.position.z)
        if dist3 <= 7.0 and RockfordStudio.jeveuxmarker then
            Timer = 0
            DrawMarker(20, RockfordStudio.pos.boss.position.x, RockfordStudio.pos.boss.position.y, RockfordStudio.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 30, 144, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        RefreshRockfordMoney()      
                        Bossrockford()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)

function RefreshRockfordMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            Updatesocietyrockfordmoney(money)
        end, ESX.PlayerData.job.name)
    end
end


function Updatesocietyrockfordmoney(money)
    societyrockfordmoney = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'rockford', function(data, menu)
        menu.close()
    end, {wash = false})
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