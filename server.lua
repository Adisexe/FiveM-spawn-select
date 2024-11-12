function setLastPos(player)
    local playerIdentifier = GetPlayerIdentifier(player, 1)
    local onlyKey = playerIdentifier:gsub("license:", "")

    MySQL.single("SELECT position FROM users WHERE identifier = ?", { onlyKey }, function(result)
        if not result then
            return
        else
            local position = json.decode(result.position)

            SetEntityCoords(GetPlayerPed(player), position.x, position.y, position.z)
        end
    end)
end

RegisterServerEvent("select_spawn:setLastPos")
AddEventHandler("select_spawn:setLastPos", function()
    setLastPos(source)
end)