do
    local all_job_abilities = get_res_all_job_abilities()

    function get_abilities_recast() -- Used via update to get ability timers
        local formattedString = "abilities_"

        player_abilities = get_abilities()
        if not player_abilities then return formattedString end

        ability_recasts = get_ability_recasts()
        if not ability_recasts then return formattedString end

        for index, ability in pairs(player_abilities) do
            if index == "job_abilities" then
                for index, value in pairs(ability) do
                    local recast_time = ability_recasts[all_job_abilities[value].recast_id]
                    if recast_time then
                        formattedString = formattedString..all_job_abilities[value].id..'|'..string.format("%.2f",recast_time)..','
                    end
                end
            elseif index == "pet_commands" then
                for index, value in pairs(ability) do
                    local recast_time = ability_recasts[all_job_abilities[value].recast_id]
                    if recast_time then
                        formattedString = formattedString..all_job_abilities[value].id..'|'..string.format("%.2f",recast_time)..','
                    end
                end
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)
        --log(formattedString)
        return formattedString
    end

    function get_all_abilities() -- -- used once via sync request Sync.lua
        local formattedString = get_player_id()..";abilitydata_"
        local all_ability_count = 0
        for id, ability in pairs(all_job_abilities) do
            formattedString = formattedString..ability.id..'|'..ability.en..'|'..ability.mp_cost..'|'..ability.tp_cost..'|'..ability.range..'|'..targets_table(ability.targets)..'|'..ability.type..','
            if ability.id and ability.id > all_ability_count then
                all_ability_count = ability.id
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)
        --log(formattedString)
        return formattedString..'_'..all_ability_count
    end

    function get_ability(id)
        return all_job_abilities[id]
    end

end
