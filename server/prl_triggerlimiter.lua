local hits = {}

CreateThread(function()
    for k, v in ipairs(Config.BlEvents) do
        hits[v.name] = {}
        RegisterServerEvent(v.name)
        AddEventHandler(v.name, function()
            if hits[v.name][source] == nil then
                hits[v.name][source] = {}
                hits[v.name][source].hits = 1
            else
                hits[v.name][source].hits = hits[v.name][source].hits + 1
            end
          
            if not hits[v.name][source].time then 
                hits[v.name][source].time = GetGameTimer()
            end
            
            if (hits[v.name][source].time) + (1 * 30000) >= GetGameTimer() then
                hits[v.name][source].hits = 0
                hits[v.name][source].time = nil
            end

            if hits[v.name][source].hits > v.limit then
                print(("%s has triggered the event %s too often"):format(GetPlayerName(source), v.name))
                CancelEvent()
                DropPlayer(source, "You trigger the following event too often: " .. v.name)
                --Ban Event here
            end
        end)
    end
end)
