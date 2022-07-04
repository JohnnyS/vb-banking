--================================================================================================
--==                      VB-BANKING BY VISIBAIT (BASED OFF NEW_BANKING)                        ==
--==                      Updated by Team Smoove                        						==
--================================================================================================
local inMenu = false
local atbank = false

-- BLIPS --
Citizen.CreateThread(function()
  for k,v in ipairs(Config.Zonas["banks"]) do
	local blip = AddBlipForCoord(v.x, v.y, v.z)
	SetBlipSprite(blip, v.id)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(tostring(v.name))
	EndTextCommandSetBlipName(blip)
  end
end)
--
-- EVENTS
--

RegisterNetEvent('vb-banking:client:refreshbalance')
AddEventHandler('vb-banking:client:refreshbalance', function(balance)
  local _streetcoords = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(PlayerPedId()))))
  local _pid = GetPlayerServerId(PlayerId())
  ESX.TriggerServerCallback('vb-banking:server:GetPlayerName', function(playerName)
    SendNUIMessage({
      type = "balanceHUD",
      balance = balance,
      player = playerName,
      address = _streetcoords,
      playerid = _pid
    })
  end)
end)

--
-- NUI CALLBACKS
--

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('vb-banking:server:depositvb', tonumber(data.amount), inMenu)
	TriggerServerEvent('vb-banking:server:balance', inMenu)
end)

RegisterNUICallback('withdraw', function(data)
	TriggerServerEvent('vb-banking:server:withdrawvb', tonumber(data.amountw), inMenu)
	TriggerServerEvent('vb-banking:server:balance', inMenu)
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('vb-banking:server:balance', inMenu)
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end) 

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('vb-banking:server:transfervb', data.to, data.amountt, inMenu)
	TriggerServerEvent('vb-banking:server:balance', inMenu)
end)

RegisterNetEvent('vb-banking:result')
AddEventHandler('vb-banking:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
  	Citizen.Wait(500)
  	inMenu = false
end)

--

RegisterNetEvent("vb_bank:menu")
AddEventHandler("vb_bank:menu", function() --If you wanna use a different progress bar change this event
	local playerPed = PlayerPedId() 
	if lib.progressBar({
		duration = 2500,
		label = 'Entering Card..',
		useWhileDead = false,
		canCancel = true,
		anim = {
			scenario = 'PROP_HUMAN_ATM'
		},
		disable = {
			move = true,
			car = true,
			combat = true,
			mouse = false
		},
	}) then
		inMenu = true
		SetNuiFocus(true, true)
		SendNUIMessage({type = 'openGeneral', banco = atbank})
		TriggerServerEvent('vb-banking:server:balance', inMenu)
		SetNuiFocus(true, true)
		SendNUIMessage({type = 'openGeneral', banco = atbank})
		TriggerServerEvent('vb-banking:server:balance', inMenu)
		ClearPedTasksImmediately(playerPed)
	else
		lib.notify({
			description = 'Card was declined or removed too quickly',
			duration = 3000,
			position = 'top',
			type = 'error'
		})
		ClearPedTasksImmediately(playerPed)
	end
end)

--Q Target
Citizen.CreateThread(function()
  exports.qtarget:AddTargetModel({-1126237515, -1364697528, -870868698, 506770882}, {
      options = {
          {
              event = "vb_bank:menu",
              icon = "fas fa-credit-card",
              label = "ATM",
          },
      },
      distance = 1.0
  })
end)

--[[ These are all the banks ]] --
exports.qtarget:AddBoxZone("vb-banking1", vector3(149.78, -1041.57, 29.68), 1.5, 1.5, {
	name="vb-banking1",
	heading=160.39,
	debugPoly=false,
	minZ=29.30,
	maxZ=31.50,
	}, {
		options = {
			{
				event = "vb_bank:menu",
				icon = "fas fa-credit-card",
				label = "Open Bank",
			},
		},
		distance = 3.5
})
exports.qtarget:AddBoxZone("vb-banking2", vector3(-1212.09, -331.37, 37.99), 1.5, 1.5, {
	name="vb-banking2",
	heading=235.51,
	debugPoly=false,
	minZ=37.5,
	maxZ=41.5,
	}, {
		options = {
			{
				event = "vb_bank:menu",
				icon = "fas fa-credit-card",
				label = "Open Bank",
			},
		},
		distance = 3.5
})
exports.qtarget:AddBoxZone("vb-banking3", vector3(-2961.72, 483.10, 15.91), 1.5, 1.5, {
	name="vb-banking3",
	heading=291.21,
	debugPoly=false,
	minZ=15.7,
	maxZ=17.5,
	}, {
		options = {
			{
				event = "vb_bank:menu",
				icon = "fas fa-credit-card",
				label = "Open Bank",
			},
		},
		distance = 3.5
})
exports.qtarget:AddBoxZone("vb-banking4", vector3(-112.25, 6470.63, 31.38), 1.5, 1.5, {
	name="vb-banking4",
	heading=318.43,
	debugPoly=false,
	minZ=31.5,
	maxZ=35.5,
	}, {
		options = {
			{
				event = "vb_bank:menu",
				icon = "fas fa-credit-card",
				label = "Open Bank",
			},
		},
		distance = 3.5
})
exports.qtarget:AddBoxZone("vb-banking5", vector3(314.11, -279.94, 54.38), 1.5, 1.5, {
	name="vb-banking5",
	heading=342.14,
	debugPoly=false,
	minZ=54.38,
	maxZ=59.5,
	}, {
		options = {
			{
				event = "vb_bank:menu",
				icon = "fas fa-credit-card",
				label = "Open Bank",
			},
		},
		distance = 3.5
})
exports.qtarget:AddBoxZone("vb-banking6", vector3(-351.02, -50.75, 49.25), 1.5, 1.5, {
	name="vb-banking6",
	heading=343.13,
	debugPoly=false,
	minZ=49.1,
	maxZ=53.5,
	}, {
		options = {
			{
				event = "vb_bank:menu",
				icon = "fas fa-credit-card",
				label = "Open Bank",
			},
		},
		distance = 3.5
})