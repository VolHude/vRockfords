ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'rockford', 'alerte Rockford Studio', true, true)

TriggerEvent('esx_society:registerSociety', 'rockford', 'rockford', 'society_rockford', 'society_rockford', 'society_rockford', {type = 'public'})

ESX.RegisterServerCallback('vRockfords:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_rockford', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('vRockfords:getStockItem')
AddEventHandler('vRockfords:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_rockford', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('vRockfords:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('vRockfords:putStockItems')
AddEventHandler('vRockfords:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_rockford', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification(_U('have_deposited', count, inventoryItem.name))
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)




RegisterNetEvent('vRockfords:bar')
AddEventHandler('vRockfords:bar', function(item,price)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xMoney = xPlayer.getMoney()

    if xMoney >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)


RegisterServerEvent('vRockfords:Ouvert')
AddEventHandler('vRockfords:Ouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Rockford Studio', '~y~Informations', 'Le Rockford Studio est ouvert', 'CHAR_STRETCH', 2)
	end
end)

RegisterServerEvent('vRockfords:Fermer')
AddEventHandler('vRockfords:Fermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Rockford Studio', '~y~Informations', 'Le Rockford Studio est fermé', 'CHAR_STRETCH', 2)
	end
end)

RegisterServerEvent('vRockfords:Perso')
AddEventHandler('vRockfords:Perso', function(msg)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Rockford Studio', '~y~Annonce', msg, 'CHAR_STRETCH', 8)
    end
end)