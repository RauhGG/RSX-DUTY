ESX = exports['es_extended']:getSharedObject()

local hours1
local hours2

function sendToDiscord(auth, color, msg)
    local embed = {
          { 
            ["Author"] = auth,
            ["title"] = "RSX-Duty",
            ["color"] = color,
            ["title"] = "** Sistema de fichaje **",
            ["description"] = msg,
            ["footer"] = {
                    ["text"] = "RSX-Duty"
            }
          }
      }
  
    PerformHttpRequest('https://discord.com/api/webhooks/999785137023754330/zxVjQbABsk5XNadZ0ZoxoEl9GdutkBevIKRq9X6UGi9JaWfRHsp4scAdN_X3JprGnR8b', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent('rsx_duty:entrar', function(type, offtype)
    local xPlayer = ESX.GetPlayerFromId(source)  
    if xPlayer.getJob().name == offtype then
        xPlayer.setJob(type, xPlayer.getJob().grade)
        time = os.date("*t")
        hours1 = time.hour
        sendToDiscord(GetPlayerName(source), 65403, GetPlayerName(source)..' ha entrado de servicio a las '.. hours1 .. ' horas de '..type)
    else
        print('no es el job correcto, rsx_duty:entrar')
    end
end)

RegisterServerEvent('rsx_duty:salir', function(type, offtype)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getJob().name == type then
        xPlayer.setJob(offtype, xPlayer.getJob().grade)
        time = os.date("*t")
        hours2 = time.hour
        sendToDiscord(GetPlayerName(source), 16711680, GetPlayerName(source)..' ha salido de servicio a las '.. hours2 .. ' horas de '..type)
        local salary = (hours2 - hours1) * Config.Salary[type]
        xPlayer.addMoney(salary)
    else
        print('no es el job correcto, rsx_duty:salir')
    end
end)

