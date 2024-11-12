local isMenuVisible = false
local camera = nil

function createBackgroundCam()
    camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1404.382, 730.84, 119.797, 0.0, 0.0, 0.0, 60.0, true, 2)

    SetCamFov(camera, 60.0)
    SetEntityHeading(camera, 180.709)
    SetCamActive(camera, true)
    RenderScriptCams(true, false, 0, true, true)
end

function destroyBackgroundCam()
    SetCamActive(camera, false)
    RenderScriptCams(false, false, 0, true, true)
    DestroyCam(camera, false)
    camera = nil
end

function setSpawnPanelShow(status, firstSp)
    isMenuVisible = status
    SetNuiFocus(status, status)

    if status then
        createBackgroundCam()
        SetTimecycleModifier('hud_def_blur')
        DisplayRadar(false)
        Wait(500)
        SendNUIMessage({type = "enableSpawnMenu", enable = status, firstSpawn = firstSp})
        DoScreenFadeIn(2500)
    else
        destroyBackgroundCam()
        ClearTimecycleModifier()
        DisplayRadar(true)
        SendNUIMessage({type = "enableSpawnMenu", enable = status})
    end
end

function setPlayerSpawn(spawn)
    DoScreenFadeOut(0)
    setSpawnPanelShow(false)
    Wait(1000)

    if spawn ~= 'last-place' and spawn ~= 'property' then
        SetEntityCoords(PlayerPedId(), Config.SpawnsList[spawn].x, Config.SpawnsList[spawn].y, Config.SpawnsList[spawn].z)
        SetEntityHeading(PlayerPedId(), Config.SpawnsList[spawn].h)
    elseif spawn == 'last-place' then
        TriggerServerEvent("select_spawn:setLastPos")
    end
    TriggerEvent('santify_hud:toogle', 'hud', true)

    DoScreenFadeIn(2000)
end

RegisterNetEvent("select_spawn:showMenu")
AddEventHandler("select_spawn:showMenu", function(status, firstSpawn)
    setSpawnPanelShow(status, firstSpawn)
end)

RegisterNUICallback('spawnSelected', function(data)
    setPlayerSpawn(data.id)
end)