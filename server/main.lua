ESX.RegisterServerCallback('vb-banking:server:GetPlayerName', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.getName())
end)

RegisterServerEvent('vb-banking:server:depositvb')
AddEventHandler('vb-banking:server:depositvb', function(amount, inMenu)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	amount = tonumber(amount)
	Citizen.Wait(50)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('ox_lib:notify', xPlayer.source, { 
		   type = 'error',
		   icon = 'ban',
		   position = 'top',
		   duration = 5000, 
		   description = "Invalid Quantity",
		})
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('ox_lib:notify', xPlayer.source, { 
		   type = 'success',
		   icon = 'money-bill-transfer', 
		   position = 'top',
		   duration = 3500, 
		   description = "You deposited $"..amount,
		})
		exports.JD_logs:discord('User Deposited: $'..amount, xPlayer.source, 0, '#005010', 'banking')
	end
end)

RegisterServerEvent('vb-banking:server:withdrawvb')
AddEventHandler('vb-banking:server:withdrawvb', function(amount, inMenu)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local _base = 0
	amount = tonumber(amount)
	_base = xPlayer.getAccount('bank').money
	Citizen.Wait(100)
	if amount == nil or amount <= 0 or amount > _base then
		TriggerClientEvent('ox_lib:notify', xPlayer.source, { 
			type = 'error',
			icon = 'ban', 
			position = 'top',
			duration = 5000, 
			description = "Invalid Quantity",
		})
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('ox_lib:notify', xPlayer.source, { 
			type = 'success',
			icon = 'money-bill-transfer', 
			position = 'top',
			duration = 3500, 
			description = "You withdrawn $"..amount,
		 })
		exports.JD_logs:discord('User Withdrawing: $'..amount, xPlayer.source, 0, '#005010', 'banking')
	end
end)

RegisterServerEvent('vb-banking:server:balance')
AddEventHandler('vb-banking:server:balance', function(inMenu)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('vb-banking:client:refreshbalance', _src, balance)
end)

RegisterServerEvent('vb-banking:server:transfervb')
AddEventHandler('vb-banking:server:transfervb', function(to, amountt, inMenu)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(tonumber(to))
	local balance = 0
	if zPlayer ~= nil then
		balance = xPlayer.getAccount('bank').money
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('ox_lib:notify', _source, { 
				type = 'error',
				icon = 'ban', 
				position = 'top',
				duration = 5000, 
				description = "You can't transfer money to yourself",
			})	
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('ox_lib:notify', _source, { 
					type = 'error',
					icon = 'ban', 
					position = 'top',
					duration = 5000, 
					description = "You don't have enough money in your bank account.",
				})
			else
				xPlayer.removeAccountMoney('bank', tonumber(amountt))
				zPlayer.addAccountMoney('bank', tonumber(amountt))
				TriggerClientEvent('ox_lib:notify', tonumber(to), { 
					type = 'success',
					icon = 'money-bill-transfer',
					position = 'top',
					duration = 5000, 
					description = "You've received a bank transfer of $"..amountt.." from the ID: ".._source,
				})
				TriggerClientEvent('ox_lib:notify', _source, { 
					type = 'success',
					icon = 'money-bill-transfer',
					position = 'top',
					duration = 5000, 
					description = "You've sent a bank transfer of $"..amountt.." to the ID: "..to,
				})
				exports.JD_logs:discord('User Transferred: $'..tonumber(amountt).. " to player on the right" , _source, tonumber(to), '#005010', 'banking')
			end
		end
	else
		TriggerClientEvent('ox_lib:notify', _source, { 
			type = 'error',
			icon = 'ban', 
			position = 'top',
			duration = 5000, 
			description = "That Wallet ID is not valid or doesn't exist",
		})
		
	end
end)