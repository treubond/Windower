do
    local party_position = {p0='0',p1='1',p2='2',p3='3',p4='4',p5='5',a10='6',a11='7',a12='8',a13='9',a14='10',a15='11',a20='12',a21='13',a22='14',a23='15',a24='16',a25='17'}
    local party_ids = {}
    local alliance_ids = {}
    local party_location = {}

    function get_party_data()
        local party_data = {}

        -- Get the player info
        local p = get_player()
        if not p then return party_data end

        --Clear old Tables
        party_ids = {}
        alliance_ids = {}

        local party = get_party() -- Update the table of the party
        if not party then return party_data end
        for position, member in pairs(party) do
            if type(member) == "table" and member.name and member.name ~= '' then
                local formattedString = "party_"..party_position[position]..'_'..member.name..','
                ..string.format("%i",member.hp)..','..string.format("%i",member.hpp)..','..string.format("%i",member.mp)..','
                ..string.format("%i",member.mpp)..','..string.format("%i",member.tp)..','..string.format("%i",member.zone)
                if member.mob then
                    local mob = {0,0,0,0,0,0,0,0,0,'false','false','|0|0|0|0|0|0|0|0|0|0'}
                    local local_player = party_location[member.mob.id]
                    -- Build a party table to use later
                    if not member.mob.is_npc then
                        if tonumber(party_position[position]) < 6 then
                            party_ids[member.mob.id] = position
                        end
                        alliance_ids[member.mob.id] = position
                    end

                    if local_player then -- update with local IPC information
                        member.mob.x = local_player.x
                        member.mob.y = local_player.y
                        member.mob.z = local_player.z
                        member.mob.heading = local_player.heading
                        if local_player.id == p.id then
                            member.mob.target_index = p.target_index
                            member.mob.status = p.status
                        end
                    end

                    for index, value in pairs(member.mob) do
                        if index == 'id' then
                            mob[1] = string.format("%i",value)
                        elseif index == 'index' then
                            mob[2] = string.format("%i",value)
                        elseif index == 'target_index' then
                            mob[3] = string.format("%i",value)
                        elseif index == 'status' then
                            mob[4] = string.format("%i",value)
                        elseif index == 'heading' then
                            mob[5] = string.format("%.3f",value)
                        elseif index == 'x' then
                            mob[6] = string.format("%.3f",value)
                        elseif index == 'y' then
                            mob[7] = string.format("%.3f",value)
                        elseif index == 'z' then
                            mob[8] = string.format("%.3f",value)
                        elseif index == 'model_size' then
                            mob[9] = string.format("%.3f",value)
                        elseif index == 'is_npc' then
                            mob[10] = tostring(value)
                        elseif index == 'pet_index' then
                            local pet = get_mob_by_index(value)
                            -- Update the player pet
                            if member.mob.id == p.id then
                                if pet then
                                    local player_pet = get_player_pet()
                                    if player_pet then
                                        pet.tp = player_pet.tp
                                        pet.status = player_pet.status
                                        -- Check is its targeting itself
                                        if pet.index == player_pet.target then
                                            pet.target = 0
                                            pet.status = 0
                                        else
                                            pet.target = player_pet.target
                                        end
                                    end
                                end
                                set_player_pet(pet)
                            end

                            if not pet then
                                pet = {}
                                pet.name = "None"
                                pet.id = 0
                                pet.index = 0
                                pet.hpp = 0
                                pet.tp = 0
                                pet.x = 0
                                pet.y = 0
                                pet.z = 0
                                pet.status = 0
                                pet.tp = 0
                            end

                            if not pet.tp then pet.tp = 0 end
                            if not pet.target then pet.target = 0 end
                            if not pet.status then pet.status = 0 end

                            local pet_string = pet.name..'|'..string.format("%i",pet.id)..'|'..string.format("%i",pet.index)..'|'..string.format("%i",pet.hpp)..'|'..string.format("%i",pet.tp)..'|'..string.format("%.3f",pet.x)..
                            '|'..string.format("%.3f",pet.y,2)..'|'..string.format("%.3f",pet.z,2)..'|'..string.format("%i",member.zone)..'|'..string.format("%i",pet.status)..'|'..string.format("%i",pet.target)
                            mob[12] = pet_string
                        end
                    end

                    if not mob[12] then -- No pet active
                        local pet_string = "0|0|0|0|0|0|0|0|0|0|0"
                        mob[12] = pet_string 
                    end

                    if party['party1_leader'] == member.mob['id'] then
                        mob[11] = 'true'
                    else
                        mob[11] = 'false'
                    end

                    for index, value in ipairs(mob) do
                        formattedString = formattedString..','..value
                    end
                else
                    formattedString = formattedString..',0,0,0,0,0,0,0,0,0,false,false,|0|0|0|0|0|0|0|0|0|0'
                end
                party_data[party_position[position]] = formattedString
                --log(formattedString)
            end
        end
        --Fill in remainder of first part
        if not party or not party.party1_leader then
            party.party1_count = 1
        end
        for i = party.party1_count, 5 do
            local formattedString = "party_"..string.format("%i",i)..'_Player '..string.format("%i",i+1)..',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,false,false,|0|0|0|0|0|0|0|0|0|0'
            party_data[i] = formattedString
        end
        --Fill in remainder of second party
        if not party or not party.party2_leader then
            party.party2_count = 0
        end
        for i = party.party2_count + 6, 11 do
            local formattedString = "party_"..string.format("%i",i)..'_Player '..string.format("%i",i+1)..',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,false,false,|0|0|0|0|0|0|0|0|0|0'
            party_data[i] = formattedString
        end
        --Fill in remainder of third part
        if not party or not party.party3_leader then
            party.party3_count = 0
        end
        for i = party.party3_count + 12, 17 do
            local formattedString = "party_"..string.format("%i",i)..'_Player '..string.format("%i",i+1)..',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,false,false,|0|0|0|0|0|0|0|0|0|0'
            party_data[i] = formattedString
        end
        return party_data
    end

    function get_party_ids()
        return party_ids
    end

    function get_alliance_ids()
        return alliance_ids
    end

    function get_party_location()
        return party_location
    end

    function set_party_location(value)
        party_location[value.id] = value
    end

    function clear_party_location()
        log("Clearing Party Location")
        party_location = {}
    end

end
