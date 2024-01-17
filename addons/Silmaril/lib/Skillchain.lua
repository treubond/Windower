do
    --Monitors for Skillchian Partners

    local Skillchain_Leader_Name = ''
    local Skillchain_Leader_WS = ''
    local Skillchain_Leader_ID = 0

    local Skillchain_Leader_Name_2 = ''
    local Skillchain_Leader_WS_2 = ''
    local Skillchain_Leader_ID_2 = 0

    local Skillchain_Leader_Name_3 = ''
    local Skillchain_Leader_WS_3 = ''
    local Skillchain_Leader_ID_3 = 0

    local Skillchain_Leader_Name_4 = ''
    local Skillchain_Leader_WS_4 = ''
    local Skillchain_Leader_ID_4 = 0

    function skillchain(Name, WS, ID, Delay)
        log("Skillchain #1 - Leader:["..Name.."], Weaponskill:["..WS.."], Delay:["..Delay.."]")
        if Name ~= 'none' and WS ~= 'none' and WS ~= '' and ID ~= 0 then
            if Name ~= Skillchain_Leader_Name or WS ~= Skillchain_Leader_WS then
                windower.add_to_chat(8,'Skillchain #1 - Monitoring ['..Name..'] for ['..WS..'].')
            end
            Skillchain_Leader_Name = Name
            Skillchain_Leader_WS = WS
            Skillchain_Leader_ID = tonumber(ID)
            Skillchain_Delay = tonumber(Delay)
            Skillchain_Time = os.clock() - 60
        else
            Skillchain_Leader_Name = ''
            Skillchain_Leader_WS = ''
            Skillchain_Leader_ID = 0
            Skillchain_Delay = 0
            Skillchain_Time = os.clock()
        end
    end

    function skillchain2(Name, WS, ID, Delay)
        log("Skillchain #2 - Leader:["..Name.."], Weaponskill:["..WS.."], Delay:["..Delay.."]")
        if Name ~= 'none' and WS ~= 'none' and WS ~= '' and ID ~= 0 then
            if Name ~= Skillchain_Leader_Name_2 or WS ~= Skillchain_Leader_WS_2 then
                windower.add_to_chat(8,'Skillchain #2 - Monitoring ['..Name..'] for ['..WS..'].')
            end
            Skillchain_Leader_Name_2 = Name
            Skillchain_Leader_WS_2 = WS
            Skillchain_Leader_ID_2 = tonumber(ID)
            Skillchain_Delay_2 = tonumber(Delay)
            Skillchain_Time_2 = os.clock() - 60
        else
            Skillchain_Leader_Name_2 = ''
            Skillchain_Leader_WS_2 = ''
            Skillchain_Leader_ID_2 = 0
            Skillchain_Delay_2 = 0
            Skillchain_Time_2 = os.clock()
        end
    end

    function skillchain3(Name, WS, ID, Delay)
        log("Skillchain #3 - Leader:["..Name.."], Weaponskill:["..WS.."], Delay:["..Delay.."]")
        if Name ~= 'none' and WS ~= 'none' and WS ~= '' and ID ~= 0 then
            if Name ~= Skillchain_Leader_Name_3 or WS ~= Skillchain_Leader_WS_3 then
                windower.add_to_chat(8,'Skillchain #3 - Monitoring ['..Name..'] for ['..WS..'].')
            end
            Skillchain_Leader_Name_3 = Name
            Skillchain_Leader_WS_3 = WS
            Skillchain_Leader_ID_3 = tonumber(ID)
            Skillchain_Delay_3 = tonumber(Delay)
            Skillchain_Time_3 = os.clock() - 60
        else
            Skillchain_Leader_Name_3 = ''
            Skillchain_Leader_WS_3 = ''
            Skillchain_Leader_ID_3 = 0
            Skillchain_Delay_3 = 0
            Skillchain_Time_3 = os.clock()
        end
    end

    function skillchain4(Name, WS, ID, Delay)
        log("Skillchain #4 - Leader:["..Name.."], Weaponskill:["..WS.."], Delay:["..Delay.."]")
        if Name ~= 'none' and WS ~= 'none' and WS ~= '' and ID ~= 0 then
            if Name ~= Skillchain_Leader_Name_4 or WS ~= Skillchain_Leader_WS_4 then
                windower.add_to_chat(8,'Skillchain #4 - Monitoring ['..Name..'] for ['..WS..'].')
            end
            Skillchain_Leader_Name_4 = Name
            Skillchain_Leader_WS_4 = WS
            Skillchain_Leader_ID_4 = tonumber(ID)
            Skillchain_Delay_4 = tonumber(Delay)
            Skillchain_Time_4 = os.clock() - 60
        else
            Skillchain_Leader_Name_4 = ''
            Skillchain_Leader_WS_4 = ''
            Skillchain_Leader_ID_4 = 0
            Skillchain_Delay_4 = 0
            Skillchain_Time_4 = os.clock()
        end
    end

    -- Called via Packets.lua
    function run_ws_skillchain(data)

        -- Get the weaponskill data
        local ws = get_weaponskill(data.param)
        if not ws then return end

        local now = os.clock()
        if data.actor_id == Skillchain_Leader_ID and ws.en == Skillchain_Leader_WS and now - Skillchain_Time > Skillchain_Delay then
            log('['..Skillchain_Leader_Name..'] Weaponskill ['..ws.en..'] on ['..data.targets[1].id..'] Follower #1')
            send_packet(get_player_name()..';skillchain_'..ws.en..'_'..Skillchain_Leader_Name..'_'..data.targets[1].id)
            Skillchain_Time = os.clock()
        elseif data.actor_id == Skillchain_Leader_ID_2 and ws.en == Skillchain_Leader_WS_2 and now - Skillchain_Time_2 > Skillchain_Delay_2 then
            log('['..Skillchain_Leader_Name_2..'] Weaponskill ['..ws.en..'] on ['..data.targets[1].id..'] Follower #2')
            send_packet(get_player_name()..';skillchain2_'..ws.en..'_'..Skillchain_Leader_Name_2..'_'..data.targets[1].id)
            Skillchain_Time_2 = os.clock()
        elseif data.actor_id == Skillchain_Leader_ID_3 and ws.en == Skillchain_Leader_WS_3 and now - Skillchain_Time_3 > Skillchain_Delay_3 then
            log('['..Skillchain_Leader_Name_3..'] Weaponskill ['..ws.en..'] on ['..data.targets[1].id..'] Follower #3')
            send_packet(get_player_name()..';skillchain3_'..ws.en..'_'..Skillchain_Leader_Name_3..'_'..data.targets[1].id)
            Skillchain_Time_3 = os.clock()
        elseif data.actor_id == Skillchain_Leader_ID_4 and ws.en == Skillchain_Leader_WS_4 and now - Skillchain_Time_4 > Skillchain_Delay_4 then
            log('['..Skillchain_Leader_Name_4..'] Weaponskill ['..ws.en..'] on ['..data.targets[1].id..'] Follower #4')
            send_packet(get_player_name()..';skillchain4_'..ws.en..'_'..Skillchain_Leader_Name_4..'_'..data.targets[1].id)
            Skillchain_Time_4 = os.clock()
        end
    end

    -- Called via Packets.lua
    function run_spell_check(data)

        -- Get the spell data
        local spell = get_spell(data.param)
        if not spell then return end

        local now = os.clock()
        if data.actor_id == Skillchain_Leader_ID and spell.en == Skillchain_Leader_WS and now - Skillchain_Time > Skillchain_Delay then
            log('['..Skillchain_Leader_Name..'] skillchain with spell ['..spell.en..'] on ['..data.targets[1].id..'] for Follower #1')
            send_packet(get_player_name()..';skillchain_'..spell.en..'_'..Skillchain_Leader_Name..'_'..data.targets[1].id)
        elseif data.actor_id == Skillchain_Leader_ID_2 and spell.en == Skillchain_Leader_WS_2 and now - Skillchain_Time_2 > Skillchain_Delay_2 then
            log('['..Skillchain_Leader_Name_2..'] skillchain with spell ['..spell.en..'] on ['..data.targets[1].id..'] for Follower #2')
            send_packet(get_player_name()..';skillchain2_'..spell.en..'_'..Skillchain_Leader_Name_2..'_'..data.targets[1].id)
        elseif data.actor_id == Skillchain_Leader_ID_3 and spell.en == Skillchain_Leader_WS_3 and now - Skillchain_Time_3 > Skillchain_Delay_3 then
            log('['..Skillchain_Leader_Name_3..'] skillchain with spell ['..spell.en..'] on ['..data.targets[1].id..'] for Follower #3')
            send_packet(get_player_name()..';skillchain3_'..spell.en..'_'..Skillchain_Leader_Name_3..'_'..data.targets[1].id)
        elseif data.actor_id == Skillchain_Leader_ID_4 and spell.en == Skillchain_Leader_WS_4 and now - Skillchain_Time_4 > Skillchain_Delay_4 then
            log('['..Skillchain_Leader_Name_4..'] skillchain with spell ['..spell.en..'] on ['..data.targets[1].id..'] for Follower #4')
            send_packet(get_player_name()..';skillchain4_'..spell.en..'_'..Skillchain_Leader_Name_4..'_'..data.targets[1].id)
        end
    end

    -- Called via Burst.lua
    function run_property_skillchain(name, target)

        local now = os.clock()
        if Skillchain_Leader_WS == name and now - Skillchain_Time > Skillchain_Delay then
            log('['..name..'] on ['..target..'] Follower #1')
            send_packet(get_player_name()..';skillchain_'..name..'_Anyone_'..target)
        elseif Skillchain_Leader_WS_2 == name and now - Skillchain_Time_2 > Skillchain_Delay_2 then
            log('['..name..'] on ['..target..'] Follower #2')
            send_packet(get_player_name()..';skillchain2_'..name..'_Anyone_'..target)
        elseif Skillchain_Leader_WS_3 == name and now - Skillchain_Time_3 > Skillchain_Delay_3 then
            log('['..name..'] on ['..target..'] Follower #3')
            send_packet(get_player_name()..';skillchain3_'..name..'_Anyone_'..target)
        elseif Skillchain_Leader_WS_4 == name and now - Skillchain_Time_4 > Skillchain_Delay_4 then
            log('['..name..'] on ['..target..'] Follower #4')
            send_packet(get_player_name()..';skillchain4_'..name..'_Anyone_'..target)
        end
    end

end