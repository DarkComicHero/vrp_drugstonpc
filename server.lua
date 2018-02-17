local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

local cfg = module("fuger", "config")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_kekmememememes")

RegisterServerEvent('drugs:item')
AddEventHandler('drugs:item', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local drugs = {"weed", "cocaine", "lsd"} -- total drugs list
    local t = math.random(1,#drugs) -- count and choose one drugs list
    if vRP.tryGetInventoryItem({user_id,drugs[t],1,true}) then
      TriggerClientEvent('cancel', player)
    else
      TriggerClientEvent('done', player)
      TriggerClientEvent('cancel', player)
    end
  end)

RegisterServerEvent('vRP_drugNPC:police1')
AddEventHandler('vRP_drugNPC:police1', function(x,y,z,street1,tipResponse)
     vRP.sendServiceAlert({nil, "police",x,y,z,tipResponse .. " on " .. street1 .. "."})
	 sendToDiscord('TS Tipline', tipResponse .. ' on ' .. street1 .. '.', cfg.e911_webhook)
end)

RegisterServerEvent('vRP_drugNPC:police2')
AddEventHandler('vRP_drugNPC:police2', function(x,y,z,street1,street2,tipResponse)
     vRP.sendServiceAlert({nil, "police",x,y,z,"TIPLINE | " .. tipResponse .. " between " .. street1 .. " and " .. street2.. "."})
	 sendToDiscord('TIPLINE | ', tipResponse .. ' between ' .. street1 .. ' and ' .. street2.. '.', cfg.e911_webhook)
end)

RegisterServerEvent('drugs:money')
AddEventHandler('drugs:money', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local cant = math.random(400,1000)
	vRP.giveInventoryItem({user_id,"dirty_money",cant,notify})
end)

function sendToDiscord(name, message, webhook)
print('sending to discord...'..webhook)
  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, content = message, tts = true}), { ['Content-Type'] = 'application/json' })
end