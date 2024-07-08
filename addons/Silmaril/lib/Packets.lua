
--Remove all of this and just return the functions.
function message_in(id, data)
    if id == 0x00B then -- Zone Response
        return packet_in_0x00B(data)
    elseif id == 0x00E then -- Zone Response
        return packet_in_0x00E(data)
    elseif id == 0x03C then -- Shop
        return packet_in_0x03C(data)
    elseif id == 0x05C then -- Dialog information
        return packet_in_0x05C(data)
    elseif id == 0x028 then -- Action
        return packet_in_0x028(data)
    elseif id == 0x029 then -- Action Message
        return packet_in_0x029(data)
    elseif id == 0x032 then -- NPC Interaction
        return packet_in_0x032(data)
    elseif id == 0x033 then  -- NPC Interaction
        return packet_in_0x033(data)
    elseif id == 0x034 then  -- NPC Interaction
        return packet_in_0x034(data)
    elseif id == 0x037 then -- Update Character
        return packet_in_0x037(data)
    elseif id == 0x038 then -- Entity Animation
        return packet_in_0x038(data)
    elseif id == 0x03E then  -- Open Buy/Sell
        return packet_in_0x03E(data)
    elseif id == 0x052 then -- NPC Release
        return packet_in_0x052(data)
    elseif id == 0x063 then -- Player buff duration
        return packet_in_0x063(data)
    elseif id == 0x065 then -- Repositioning
        return packet_in_0x065(data)
    elseif id == 0x068 then -- Pet Status Update
        return packet_in_0x068(data)
    elseif id == 0x076 then -- Buffs
        return run_buffs(data) -- via Buffs.lua
    elseif id == 0x0F5 then -- Widescan tacking packet
        return packet_in_0x0F5(data) -- via Sortie.lua
    elseif id == 0x0F9 then -- Reraise Dialog
        return packet_in_0x0F9(data)
    end
end

function message_out(id, data)
    if id == 0x01A then -- Action
        return packet_out_0x01A(data)
    elseif id == 0x00D then -- Leaving Zone
        return packet_out_0x00D(data)
    elseif id == 0x05B then  -- User dialog
        return packet_out_0x05B(data)
    elseif id == 0x05C then  -- Warp request
        return packet_out_0x05C(data)
    elseif id == 0x05E then -- Zone Line
        return packet_out_0x05E(data)
    elseif id == 0x015 then -- Player Update
        return packet_out_0x015(data)
    elseif id == 0x036 and false then -- Menu Item (Trade)
        return packet_out_0x036(data)
    elseif id == 0x083 then -- Buy Item
        return packet_out_0x083(data)
    end
end


-----------------------------------------------------------------------
--------------------------- MESSAGES IN ------------------------------
-----------------------------------------------------------------------

-- Zone Response
function packet_in_0x00B(data)
    -- Turn off move_to_exit
    zone_completed()

    -- Reload dress up if it hasn't been
    if get_dressup() and get_protection() then
        set_dressup(false)
        send_command("lua u dressup;wait 1;lua l dressup")
    end
end

-- NPC Update
function packet_in_0x00E(data)
    --Sortie.lua Addon
    bitzer_Check(data)
end

-- Shop response
function packet_in_0x03C(data) -- Disabled   
end

-- Dialog information response
function packet_in_0x05C(data)
    if not get_injecting() then return end
    local packet = parse_packet('incoming', data)
    log('npc_inject() called from [0x05C]')
    npc_inject()
end

-- Action
function packet_in_0x028(data)
	local p = get_player()
	if not p or not p.id then return end
    local packet = parse_action_packet(data)
    if not get_connected() then return end

    if packet.actor_id == p.id then
        -- [2] = 'Ranged attack finish'
        if packet.category == 2 and packet.param == 26739 then
            send_packet(p.id..';shooting_finished_2_Ranged Attack_'..packet.targets[1].id)
            log("PACKET: Shooting Finished")

        -- [3] = 'Weapon Skill finish'
        elseif packet.category == 3 and packet.param ~= 0 then
            local ws = get_weaponskill(packet.param)
            if ws then
                send_packet(p.id..';weaponskill_blocked_'..ws.id..'_'..ws.en..'_'..packet.targets[1].id)
                log('PACKET: Weaponskill ['..ws.en..'] on target ['..packet.targets[1].id..']')
            end

        -- [4] = 'Casting finish'
        elseif packet.category == 4 then
            send_packet(p.id..';casting_finished_'..packet.param..'_'..packet.targets[1].id..'_'..packet.targets[1].actions[1].message)
            log('PACKET: Casting has finished')

        -- [5] = 'Item finish'
        elseif packet.category == 5 then
            send_packet(p.id..';item_finished')
            log("PACKET: Item Finished")

        -- [6] = 'Job Ability'
        elseif packet.category == 6 then
            local option = "0"
			local ability = get_ability(packet.param)
			if ability then
                -- For Corsair's JA Phantom Roll
                if packet.targets[1].actions[1].param then option = packet.targets[1].actions[1].param end
                send_packet(p.id..';jobability_blocked_'..ability.id..'_'..ability.en..'_'..packet.targets[1].id..'_'..option)
                log('PACKET: Job Ability ['..ability.en..'] on Target ['..packet.targets[1].id..'] with Option ['..option..']')
			end

        -- [8] = 'Casting start'
        elseif packet.category == 8 then

            -- Spell Intrupted
            if packet.param == 28787 then 
                if packet.targets[1].actions[1].param ~= 0 then
					local spell = get_spell(packet.targets[1].actions[1].param)
                    if spell then
                        send_packet(p.id..';casting_interrupted_'..spell.id..'_'..spell.en..'_'..packet.targets[1].id)
                        log("PACKET: Casting was interrupted")
                    end
                end

            -- Casting Spell
            elseif packet.param == 24931 then 
                if packet.targets[1].actions[1].param ~= 0 then
					local spell = get_spell(packet.targets[1].actions[1].param)
					if spell then
                        send_packet(p.id..';casting_blocked_'..spell.id..'_'..spell.en..'_'..packet.targets[1].id..'_'..string.format("%.2f",spell.cast_time + 2.1))
                        log('PACKET: Casting Spell ['..spell.en..'] on target '..packet.targets[1].id)
					end
				end
            end

        -- [9] = 'Item start'
        elseif packet.category == 9 then
            if packet.param == 28787 then
                send_packet(p.id..';item_interrupted')
                log("PACKET: Item use interrupted")
            else
                send_packet(p.id..';item_blocked')
                log("PACKET: Item use started")
            end

        -- [12] = 'Ranged attack start'
        elseif packet.category == 12 then
            if packet.param == 24931 then -- shooting
                send_packet(p.id..';shooting_blocked_2_Ranged Attack_'..packet.targets[1].id)
                log("PACKET: Shooting")
            elseif packet.param == 28787 then -- interrupted
                send_packet(p.id..';shooting_interrupted_2_Ranged Attack_'..packet.targets[1].id)
                log("PACKET: Shooting interrupted")
            end
        end
    end

    -- NPC, Enemy, or out of party buffs
    if packet.category == 11 or packet.category == 4 or packet.category == 14 then 
        local buff_gain = S{194,203,205,230,236,237,266,267,268,269,270,271,272,277,278,279,280,319,320,519,520,521,591,645}
        local buff_wear = S{204,206,321,322,341,342,343,344,350,351,378,531,647}
        local pt_ids = get_party_ids() 
        for index, target in pairs(packet.targets) do
            if target.id and not pt_ids[target.id] then
                if target.actions[1].message then
                    local buff = target.actions[1].param
                    if buff then
                        -- Handles the dazes for DNC
                        if packet.category == 14 and buff_gain:contains(tonumber(target.actions[1].message)) then
                            local ability = get_ability(packet.param)
                            local daze = get_buff(ability.status)
                            if daze and daze.id then buff = daze.id..'|'..target.actions[1].param end
                        end

                        if buff_gain:contains(tonumber(target.actions[1].message)) and target.id then -- Buff Gain 
                            send_packet(p.id..';packet_statusgains_'..buff..'_'..target.id)
                        elseif buff_wear:contains(tonumber(target.actions[1].message)) and target.id then -- Buff Wear
                            send_packet(p.id..';packet_statuswears_'..buff..'_'..target.id)
                        end
                    end
                end
            end
        end
    end

    -- Process the skillchain and magic bursts if needed
    if packet.category == 3 and packet.param ~= 0 then -- Monitor others for Weaponskills and Skillchains
        local alliance_ids = get_alliance_ids()
        if alliance_ids[packet.actor_id] then
            run_ws_skillchain(packet)
            run_burst(packet)
        end
    elseif packet.category == 4 then -- Monitor others for Immanence and Skillchains
        local alliance_ids = get_alliance_ids()
        if alliance_ids[packet.actor_id] then
            run_spell_check(packet)
            run_burst(packet)
            local no_effect = S{75,653,654,655,656,66,85,284}
            local message = tonumber(packet.targets[1].actions[1].message)
            if message and not no_effect:contains(message) then
                corsair_shot(packet)
            end
        end
    end
end

-- Action Message
function packet_in_0x029(data)
    local packet = parse_packet('incoming', data)
    local buff_wear = S{204,206,321,322,341,342,343,344,350,351,378,531,647}    
    if packet['Message'] == 48 then -- Reraise Fail
        send_packet(get_player_id()..';packet_castfail_'..packet['Param 1']..'_'..packet['Target'])
    elseif packet['Message'] == 234 then -- Auto Target
        send_packet(get_player_id()..';packet_autotarget_'..packet['Target Index'])
    elseif buff_wear:contains(tonumber(packet['Message'])) then -- Buff Wear
        send_packet(get_player_id()..';packet_statuswears_'..packet['Param 1']..'_'..packet['Target'])
    end
end

-- NPC Interaction Type 1
function packet_in_0x032(data)
    -- This is in response to the client sending a Action packet to start interaction.
    local packet = parse_packet('incoming', data)

    -- Store a temp menu ID to cancel the active dialog for warps/doors
    set_temp_menu_id(packet['Menu ID'])

    -- Non standard way to start a mirror (clears so set menu after)
    if get_mirror_on() and not get_mirroring() then
        log("interact called 0x032")
        packet['Target'] = packet['NPC']
        local p = get_player()
        for index, value in ipairs(p.buffs) do
            if value == 254 then log('Battle Field Exit') clear_npc_data() return end
        end
        npc_mirror_start(packet)
    end

    if get_injecting() and not get_mid_inject() then
        -- Assign the Menu ID
        set_menu_id(packet['Menu ID'])
        set_interaction_type("Type 1")

        -- Menu will be blocked so you can go ahead and start sending the messages
        log('npc_inject() called from [0x032] with Menu ID of ['..tostring(get_menu_id())..']')
        npc_inject()

        --Blocks the menu
        log("Blocking on the 0x032 Packet [Type 1]")
        return true
    end
end

-- String NPC Interaction
function packet_in_0x033(data)
    -- This is in response to the client sending a Action packet to start interaction.
    local packet = parse_packet('incoming', data)

    -- Store a temp menu ID to cancel the active dialog for warps/doors
    set_temp_menu_id(packet['Menu ID'])

    -- Non standard way to start a mirror (clears so set menu after)
    if get_mirror_on() and not get_mirroring() then
        log("interact called 0x033")
        packet['Target'] = packet['NPC']
        local p = get_player()
        for index, value in ipairs(p.buffs) do
            if value == 254 then log('Battle Field Exit') clear_npc_data() return end
        end
        npc_mirror_start(packet)
    end

    if get_injecting() and not get_mid_inject() then
        -- Assign the Menu ID
        set_menu_id(packet['Menu ID'])
        set_interaction_type("Type String")

        -- Menu will be blocked so you can go ahead and start sending the messages
        log('npc_inject() called from [0x033] with Menu ID of ['..tostring(get_menu_id())..']')
        npc_inject()

        --Blocks the menu
        log("Blocking on the 0x033 Packet [String]")
        return true
    end
end

-- NPC Interaction Type 2
function packet_in_0x034(data)
    -- This is in response to the client sending a Action packet to start interaction.
    local packet = parse_packet('incoming', data)

    -- Store a temp menu ID to cancel the active dialog for warps/doors
    set_temp_menu_id(packet['Menu ID'])

    -- Non standard way to start a mirror (clears so set menu after)
    if get_mirror_on() and not get_mirroring() then
        packet['Target'] = packet['NPC']
        local p = get_player()
        for index, value in ipairs(p.buffs) do
            if value == 254 then log('Battle Field Exit') clear_npc_data() return end
        end
        npc_mirror_start(packet)
    end

    if get_injecting() and not get_mid_inject() then
        -- Assign the Menu ID
        set_menu_id(packet['Menu ID'])
        set_interaction_type("Type 2")

        -- Menu will be blocked so you can go ahead and start sending the messages
        log('npc_inject() called from [0x034] with Menu ID of ['..tostring(get_menu_id())..']')
        npc_inject()

        --Blocks the menu
        log("Blocking on the 0x034 Packet [Type 2]")
        return true
    end
end

-- Update Character
function packet_in_0x037(data)
    local p = get_player()
    if not p then return end
    local packet = parse_packet('incoming', data)
    -- Used to calculate relative time
    set_server_offset(packet['Timestamp'],packet['Time offset?']/60)

    -- Player is in a menu
    if packet['Status'] == 4 then 
        -- Player has mirroring enabled
        if get_mirror_on() and not get_mirroring() and not get_blacklisted() and get_menu_id() then
            -- Start recording as the player has entered a menu with mirroring enabled
            -- This is not a normal sequence as an action packet should have turned on Mirroring
            -- Porter prompts and other non-user interactions cause this
            log("Mirror sequence started via [0x037] packet")
            set_mirroring(true)
        end
    else
        -- Released from NPC while a player was sending a packet stream so send the result to silmaril
        if get_injecting() and os.clock() - get_message_time() > 2 then
            -- If all messages were sent report success
            local msg = get_mirror_message()
            if not msg or #msg == 0 then 
                log("Player is released from menu")
                send_packet(p.id..";mirror_status_completed")
                set_injecting(false)
            end
        end
    end

    -- This to handle where the client and server are out of sync
    if packet['Status'] == 0 and p.status == 1 then
        -- Send a disengage packet since not attacking acording to server
        log(p.name.." is not attacking according to server via [0x037] packet")
        send_packet(p.id..';packet_noattack')
    end
end

-- Entity Animation
function packet_in_0x038(data)
    local packet = parse_packet('incoming', data)
    if packet.Type == "hov1" then
        log('Hover Shot Animation')
    end
end

-- Open Buy/Sell
function packet_in_0x03E(data)
    if true then return end -- Disabled for now
    if not get_mirror_on() then return end
    log("npc_buy() called from [0x03E]")
    npc_buy_start()
end

-- NPC Release
function packet_in_0x052(data)
    local packet = parse_packet('incoming', data)

    -- Run the check if the mirror is completed
    if get_injecting() and not get_block_release() then 
        npc_in_release(packet)
    end

    -- This tells us the Server released the player - next should follow a status from 4 -> 0
    -- The engine is used to make this determination
    if get_mirroring() then
        log("Setting mirror_release to true")
        set_mirror_release(true)
    end
end

-- Player buff duration
function packet_in_0x063(data)
    if data:byte(0x05) ~= 0x09 then return end
    -- Process the buffs via the Player.lua
    player_packet_buffs(data) 
end

-- Repositioning
function packet_in_0x065(data)
    --Sortie.lua Addon
    sortie_position()
end

-- Pet status update
function packet_in_0x068(data)
    local packet = parse_packet('incoming', data)
    local p = get_player()
    if packet['Owner ID'] == p.id then
        local player_pet = get_player_pet()
        -- No pet info so get info
        if not player_pet then
            log('Getting Data of Pet')
            player_pet = get_mob_by_index(packet['Pet Index'])
        end
        if player_pet then
            local pet_target = get_mob_by_id(packet['Target ID'])
            if not pet_target then
                log('Set to idle (Deactive)')
                player_pet.target = 0
                player_pet.status = 0
            else
                player_pet.tp = packet['Pet TP']
                player_pet.target = pet_target.index
                player_pet.status = 1
                if player_pet.tp and pet_target.index then
                    log('Packet 0x068 Update - TP ['..player_pet.tp..'] Target ['..pet_target.index..']')
                end
            end
        end
        --Assign the updates to the pet
        set_player_pet(player_pet)
    end
end

-- Reraise Dialog
function packet_in_0x0F9(data)
    local packet = parse_packet('incoming', data)
    if packet['Category'] ~= 1 then return end
    log("Reraise Menu")
    send_packet(get_player_id()..';packet_reraise_')
end

-----------------------------------------------------------------------
--------------------------- MESSAGES OUT ------------------------------
-----------------------------------------------------------------------

    -- Action
function packet_out_0x01A(data)
    local packet = parse_packet('outgoing', data)  
    if packet['Category'] == 0x00 then  -- NPC Interaction
        if not get_mirror_on() then return end
        local p = get_player()
        for index, value in ipairs(p.buffs) do
            if value == 254 then log('Battle Field Exit') return end
        end
        npc_mirror_start(packet)
    elseif packet['Category'] == 0x02 then  -- Engage monster
        log('Engage packet ['..tostring(packet['Target Index'])..']')
        send_packet(get_player_id()..';packet_engage_'..packet['Target Index'])
    elseif packet['Category'] == 0x0F then  -- Switch target
        log('Switch packet ['..tostring(packet['Target Index'])..']')
        send_packet(get_player_id()..';packet_switch_'..packet['Target Index'])
    elseif packet['Category'] == 0x04 then  -- Disengage monster
        log('Disengage from an enemy')
        send_packet(get_player_id()..';packet_disengage')
    end
end

-- Leaving Zone
function packet_out_0x00D(data)

    -- Turn off move_to_exit
    zone_completed()

    -- Turn off Silmaril
    if get_enabled() then
        send_packet(get_player_id()..";stop")
    end

    -- Finish the mirror since you are leaving
    if get_injecting() then
        clear_npc_data()
        log("Zone - Mirroring completed")
        send_packet(get_player_id()..";mirror_status_completed")
    end

    -- You are mirroring and zoning so complete the action
    if get_mirror_on() and get_mirroring() then 
        log("Leaving zone - finishing mirroring action")
        npc_mirror_complete()
    end

    -- clear pet info
    set_player_pet(nil)
end

-- User dialog
function packet_out_0x05B(data)
    -- Used with automatic dialogs like warps/doors
    if get_block_release() then
        local packet = parse_packet('outgoing', data)
        set_block_release(false)
        log('Calling npc_inject from the blocked outoing 0x05B')
        set_injecting(true)
        set_menu_id(packet['Menu ID'])
        npc_inject()
        return true
    end

    if get_mirror_on() then
        local packet = parse_packet('outgoing', data)
        npc_out_dialog(packet)
    end
end

-- Warp request
function packet_out_0x05C(data)
    if not get_mirror_on() then return end
    local packet = parse_packet('outgoing', data)  

    npc_out_warp(packet)
end

-- Zone Line
function packet_out_0x05E(data)

    -- Turn off move_to_exit
    zone_completed()

    -- Turn off Silmaril
    if get_enabled() then
        send_packet(get_player_id()..";stop")
    end

    local p = get_player()
    if not p then return end

    local p_loc = get_player_location()
    if not p_loc then return end

    local w = get_world()
    if not w then return end

    local packet = parse_packet('outgoing', data)

    send_ipc('silmaril zone '..
        p.id..' '..
        w.zone..' '..
        p_loc.x..' '..
        p_loc.y..' '..
        p_loc.z..' '..
        packet['Type']..' '..
        packet['Zone Line']..' '..
        packet['MH Door Menu'])

    log("IPC zone line sent")
end

-- Player Update
function packet_out_0x015(data)
    if get_force_warp() then
        -- Modifiy the packet
        local target = get_mirror_target()
        local packet = parse_packet('outgoing', data)
        packet['X'] = tonumber(target.x)
        packet['Y'] = tonumber(target.y)
        packet['Z'] = tonumber(target.z)
        -- This allows the first 0x015 to position before trying to inject
        if get_warp_spoof() then
            set_warp_spoof(false) 
        else
            if get_outgoing_warp() then
                set_outgoing_warp(false)
                npc_build_message(target, get_warp_message())
            end
        end
        -- Release the modified packet
        return false, build_packet(packet)
    end
end

-- Menu Item (Trade)
function packet_out_0x036(data)
    if true then return end -- Disabled
    if not get_mirror_on() then return end
    local packet = parse_packet('outgoing', data)
    local items = get_items(0)
    local formattedString = ","
    for i=0,9 do
        local item = 'Item Index '..string.format("%i",i)
        local item_count = 'Item Count '..string.format("%i",i)
        if items[packet[item]] then -- found in inventory
            local inv_item = items[packet[item]].id
            local inv_count = packet[item_count]
            formattedString = formattedString..inv_item..'|'..inv_count..','
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1)
    npc_mirror_start(packet) -- Start the mirroring actions
    npc_out_trade(packet, formattedString) -- Send the trade message
end

-- Buy Item
function packet_out_0x083(data)
    if true then return end -- Disabled
    if not get_mirror_on() then return end
    local packet = parse_packet('outgoing', data)
    npc_out_buy(packet)
    log("npc_out_buy() called from [0x083]")
end