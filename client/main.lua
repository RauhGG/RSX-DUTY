ESX = exports['es_extended']:getSharedObject()

local puntos = {
    {crds = vector3(-1096.943,-818.576,19.036), type = 'police', offtype = 'offpolice'},
    {crds = vector3(-433.964,-324.581,34.911), type = 'ambulance', offtype = 'offambulance'},
}

CreateThread(function()
    while true do
        local _sleep = 1000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        local job = ESX.GetPlayerData().job.name
        for k, v in pairs(puntos) do
            local dist = GetDistanceBetweenCoords(plyCoords, v.crds, true) 
            if dist < 2 then
                _sleep = 0
                if job == v.offtype then
                    ESX.ShowFloatingHelpNotification('~INPUT_CONTEXT~ ~g~Entrar~w~', v.crds)
                    if IsControlJustPressed(0, 38) then
                        fichar(false, v.type, v.offtype)
                    end
                elseif job == v.type then
                    ESX.ShowFloatingHelpNotification('~INPUT_CONTEXT~ ~r~Salir~w~', v.crds)
                    if IsControlJustPressed(0, 38) then
                        fichar(true, v.type, v.offtype)
                    end
                end
            end
        end
        Wait(_sleep)
    end
end)

function fichar(bool, type, offtype)
    if not bool then
        TriggerServerEvent('rsx_duty:entrar', type, offtype)
    else
        TriggerServerEvent('rsx_duty:salir', type, offtype)
    end
end