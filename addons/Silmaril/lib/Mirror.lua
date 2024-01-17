do
    local sent_messages = nil -- Holds the packets that were sent
    local retry_count = 1 -- How many times a retry was conducted
    local message_count = 0 -- Total messages in que to mirror
    local single_mirror = true -- Determins if mirroring should be kept on after a mirror event is completed
    local action_packet = nil -- This is the packet used to poke a NPC
    local black_list = {}   -- NPC's to avoid when mirroring is turned on
    local injecting = false -- In the process of injecting packets
    local mirror_on = false -- If the player has mirroring enabled
    local mirroring = false -- If the player is in the process of building a mirror image
    local mirror_target = nil -- NPC the interaction for (used in Display)
    local message_time = os.clock() - 5 -- Time set to figure out if the player is timming out
    local injecting = false -- players are in the process of injecting packets
    local menu_id = nil -- This is the menu that the player is interacting with
    local mirror_message = nil -- Message to transmit
    local mirroring_state = "" -- this is used to notify the player of the actions
    local blacklisted = false -- Determines if the NPC is to be blacklisted
    local current_menu = nil -- stores the player current Menu ID

------------------------ MIRRORER SECTION ----------------------------------------------

    -- This packet is generated when a player starts an interaction with NPC and mirroring is enabled
    function npc_interact(packet_in)
        if not packet_in then return end
        blacklisted = false
        sent_messages = nil
        mirror_message = nil
        mirror_target = nil
        local npc = windower.ffxi.get_mob_by_id(packet_in['Target'])
        if not npc then return end
        local w = get_world()
        if not w then return end

        for index, item in ipairs(black_list) do
            if npc.name == item.name then
                if w.zone == tonumber(item.zone) or tonumber(item.zone) == 0 then
                    if npc.index == tonumber(item.index) or tonumber(item.index) == 0 then
                        log('Item index '..item.index)
                        blacklisted = true
                    end
                end
            end
        end

        if not blacklisted then
        	mirror_target = npc
            if not mirror_target then return end
            mirror_target.zone = w.zone
            log('NPC Interaction Starting')
            mirroring_state = "Starting"
            sm_result_hide()
            send_packet(get_player_name()..';mirror_interact') -- used to clear a buffer in Silmaril
            packet_log(packet_in)
        else
            mirroring = false
            injecting = false
            log("NPC is blacklisted")
        end
    end

    function npc_buy()
        -- get the environment
        local w = get_world()
        if not w then return end
        if not w then return end
        local p = get_player()
        if not p then return end
        local p_loc = get_player_location()
        if not p_loc then return end

        mirroring_state = "Starting"
        sent_messages = nil
        mirror_message = nil
	    mirror_target = p
        mirror_target.name = "NPC Buy"
        mirror_target.x = p_loc.x
        mirror_target.y = p_loc.y
        mirror_target.z = p_loc.z
        mirror_target.zone = w.zone
        log('NPC Interaction Starting')
        send_packet(get_player_name()..';mirror_interact') -- used to clear a buffer
    end

    -- 0x05B
    -- This function sends the menu selection of the player to silmaril to build the menu transactions
    function npc_out_dialog(packet_in)
        if not packet_in then return end
        if blacklisted then return end
        target_check(packet_in)
        log('Mirroring Dialog [0x05B]')
        send_packet(get_player_name()..';mirror_dialog_0x05B,'..
            packet_in['Target']..','..
            packet_in['Option Index']..','..
            packet_in['_unknown1']..','..
            packet_in['Target Index']..','..
            tostring(packet_in['Automated Message'])..','..
            packet_in['_unknown2']..','..
            packet_in['Zone']..','..
            packet_in['Menu ID'])
        packet_log(packet_in)
    end

    -- 0x05C
    -- This function is for a warp request to silmaril
    function npc_out_warp(packet_in)
        if not packet_in then return end
        if blacklisted then return end
        target_check(packet_in)
        log('Mirroring Warp [0x05C]')
        send_packet(get_player_name()..';mirror_warp_0x05C,'..
            packet_in['X']..','..
            packet_in['Y']..','..
            packet_in['Z']..','..
            packet_in['Target ID']..','..
            packet_in['_unknown1']..','..
            packet_in['Zone']..','..
            packet_in['Menu ID']..','..
            packet_in['Target Index']..','..
            packet_in['_unknown2']..','..
            packet_in['Rotation'])
        packet_log(packet_in)
    end

    -- 0x036
    -- This functin is for trading
    function npc_out_trade(packet_in, formattedString)
        if not packet_in then return end
        if blacklisted then return end
        target_check(packet_in)
        log('Mirroring Trade [0x036]')
        send_packet(get_player_name()..';mirror_trade_0x036,'..
            packet_in['Target']..','..
            packet_in['Target Index']..
            formattedString)
        packet_log(packet_in)
    end

    -- 0x083
    -- This functin is for buy/sell items
    function npc_out_buy(packet_in)
        if not packet_in then return end
        if blacklisted then return end
        target_check(packet_in)
        log('Mirroring Buy [0x083]')
        send_packet(get_player_name()..';mirror_buy_0x083,'..
            packet_in['Count']..','..
            packet_in['_unknown2']..','..
            packet_in['Shop Slot']..','..
            packet_in['_unknown3']..','..
            packet_in['_unknown4'])
        packet_log(packet_in)
    end

    -- Once a NPC interaction is completed the server send a 0x037 packets with the player state change (4 -> 0)
    function npc_in_complete()
        if blacklisted then log("Blacklisted NPC") return end
        if not mirror_target then log("No Target Found") return end
        mirroring_state = "Completed"
        log('NPC interaction completed')
        send_packet(get_player_name()..';mirror_send_'..
            tostring(mirror_target.index)..','..
            tostring(mirror_target.x)..','..
            tostring(mirror_target.y)..','..
            tostring(mirror_target.z)..','..
            tostring(mirror_target.zone)..','..
            tostring(mirror_target.name))
        packet_log(packet)
        if single_mirror then mirror_on = false end
        mirror_target = nil
    end

    -- Table of blacklisted NPC from silmaril
    function add_black_list(list)
        black_list = {}
        -- split to each message
        for items in string.gmatch(list, "([^|]+)") do
            -- split each message further
            local list_item = {}
            for item in string.gmatch(items, "([^,]+)") do
                table.insert(list_item, item)
            end
            local parsed = {name = list_item[1], zone = list_item[2], index = list_item[3]}
            table.insert(black_list, parsed)
            --log('Name ['..parsed.Name..'] Zone ['..parsed.Zone..'] Index ['..parsed.Index..']')
        end
    end

------------------------ INJECTION SECTION ----------------------------------------------

    -- Called by Silmaril to start a mirror sequence
    -- Build the message que for when server asks for it.
    -- Only send the action packet here
    function npc_build_message(target, message)
        if not target then return end
        if not message then return end
        local w = get_world()
        if not w then return end

        mirror_target = target
        mirror_target.zone = w.zone

        --Clear out old info
        retry_count = 1
        sent_messages = {}
        menu_id = nil
        mirror_on = false
        log('Cleared old messages')

        -- Builds the messages into a table
        mirror_message = {}
        for item in string.gmatch(message, "([^|]+)") do
            table.insert(mirror_message, item)
        end

        -- Set the message count
        message_count = #mirror_message
        log('Messasge count is ['..message_count..']')

        -- Parse the first message
        local packet_out = {}
        for item in string.gmatch(mirror_message[1], "([^,]+)") do
            table.insert(packet_out, item)
        end

        injecting = true

        if packet_out[1] == "0x05B" or packet_out[1] == "0x05C" then -- Dialog

            -- Build the action packet
            action_packet = packets.new('outgoing', 0x01A, {
                ['Target'] = mirror_target.id,
                ['Target Index'] = mirror_target.index,
                ['Category'] = 0x00,
                ['Param'] = 0 })

            -- Start the interation

            packets.inject(action_packet)
            message_time = os.clock()
            mirroring_state = "Injecting [0x01A]"
            log(mirroring_state)
            packet_log(action_packet)

        elseif packet_out[1] == "0x036" then
            injecting = false
            log("Trade Action")
        end


    end

    -- Called if an event release is not detected
    function npc_retry()
        if not injecting then return end
        local w = get_world()
        if not w then return end
        if not action_packet then injecting = false return end
        -- Try a retry packet injection
        retry_count = retry_count + 1
        packets.inject(action_packet)
        message_time = os.clock()
        mirroring_state = "Injecting [0x01A] - Retry ["..tostring(retry_count)..']'
        packet_log(packet)
        if retry_count > 10 then injecting = false return end
    end

    -- Once a 0x032/0x033/0x034 Packet is recieved from the initial Action always first 0x05B Packet sent
    -- Once a follow up 0x05C is recieved send the next dialog reqest/warp
    function npc_inject(original)
        if not injecting then return end
        local packet_in = nil
        if not mirror_message then return end

        -- Set the menu ID to verify the correct menu
        if original then 
            packet_in = packets.parse('incoming', original)
            packet_log(packet_in)
            if packet_in['Menu ID'] then
                menu_id = packet_in['Menu ID']
                log('Menu ID from the NPC ['..tostring(menu_id)..']')
            end
        end

        -- Make sure you have a menu ID
        if not menu_id then return end

        local packet_out = {}
		for item in string.gmatch(mirror_message[1], "([^,]+)") do
            table.insert(packet_out, item)
        end

        if packet_out[1] == "0x05B" and menu_id ~= tonumber(packet_out[9]) then
            echo("Incorrect Menu Detected!!!! - Player Cannot Mirror ["..get_player_name().."]")
            log("Player Menu ["..tostring(menu_id)..'] and Mirror Menu ['..packet_out[9]..']')
            npc_reset()
            message_time = os.clock()
            sent_messages = nil
            mirror_message = nil
            mirroring_state = "Injecting [0x05B] (Release Packet - Wrong Menu)"
            log(mirroring_state)
            send_packet(get_player_name()..";mirror_status_failed")

        elseif packet_out[1] == "0x05B" then
            local automated = false
            if packet_out[6] == 'true' then automated = true end
            local packet = packets.new('outgoing', 0x05B, {
                ['Target'] = tonumber(mirror_target.id),
                ['Option Index'] = tonumber(packet_out[3]),
                ['_unknown1'] = tonumber(packet_out[4]),
                ['Target Index'] = tonumber(mirror_target.index),
                ['Automated Message'] = automated,
                ['_unknown2'] = packet_out[7],
                ['Zone'] = tonumber(packet_out[8]),
                ['Menu ID'] = tonumber(packet_out[9]),})
            packets.inject(packet)
            message_time = os.clock()
            table.insert(sent_messages, packet)
            table.remove(mirror_message,1)
            if #mirror_message == 0 then mirror_message = nil end
            mirroring_state = "Injecting [0x05B] ("..#sent_messages..' of '..message_count..')'
            log(mirroring_state)
            packet_log(packet)

        elseif packet_out[1] == "0x05C" then
            local packet = packets.new('outgoing', 0x05C, 
            {
                ['X'] = tonumber(packet_out[2]),
                ['Y'] = tonumber(packet_out[3]),
                ['Z'] = tonumber(packet_out[4]),
                ['Target ID'] = tonumber(mirror_target.id),
                ['_unknown1'] = tonumber(packet_out[6]),
                ['Zone'] = tonumber(packet_out[7]),
                ['Menu ID'] = tonumber(packet_out[8]),
                ['Target Index'] = tonumber(mirror_target.index),
                ['_unknown2'] = packet_out[10],
                ['Rotation'] = packet_out[11],
            })
            packets.inject(packet)
            message_time = os.clock()
            table.insert(sent_messages, packet)
            table.remove(mirror_message,1)
            if #mirror_message == 0 then mirror_message = nil end
            mirroring_state = "Injecting [0x05C] ("..#sent_messages..' of '..message_count..')'
            log(mirroring_state)
            packet_log(packet)

        elseif packet_out[1] == "0x083" then
            local packet = packets.new('outgoing', 0x083, 
            {
                ['Count'] = tonumber(packet_out[2]),
                ['_unknown2'] = tonumber(packet_out[3]),
                ['Shop Slot'] = tonumber(packet_out[4]),
                ['_unknown3'] = tonumber(packet_out[5]),
                ['_unknown4'] = tonumber(packet_out[6]),
            })
            packets.inject(packet)
            message_time = os.clock()
            table.insert(sent_messages, packet)
            table.remove(mirror_message,1)
            if #mirror_message == 0 then mirror_message = nil end
            mirroring_state = "Injecting [0x083] ("..#sent_messages..' of '..message_count..')'
            log(mirroring_state)
            packet_log(packet)
        end
    end

    function npc_in_release(packet_in)
        local p = get_player()
        if not p then return end
        if not packet_in then clear_npc_data() return end

        if packet_in['Type'] == 0x00 then
            log('NPC Release [Standard]')
            if retry_count < 11 and not menu_id then -- Poke the NPC
                log("Retry Menu ["..retry_count..'/10]')
                npc_retry()
                local retries = retry_count - 1
                send_packet(get_player_name()..";mirror_status_retry_"..tostring(retries))
            elseif mirror_message and #mirror_message ~= 0  then -- Continue to inject
                npc_inject()
                send_packet(get_player_name()..";mirror_status_inject")
            else  -- zero message left so assuming completed
                log("Injecting completed")
                send_packet(get_player_name()..";mirror_status_completed")
                clear_npc_data()
            end

        elseif packet_in['Type'] == 0x01 then
            log('NPC Release [Event]')
            if not mirror_message or #mirror_message == 0 then
                send_packet(get_player_name()..";mirror_status_completed")
                log("Injecting completed")
                clear_npc_data()
            else
                npc_inject()
                send_packet(get_player_name()..";mirror_status_inject")
            end

        elseif packet_in['Type'] == 0x02 then
            log('NPC Release [Event Skipped]')
            log("Injecting completed")
            send_packet(get_player_name()..";mirror_status_failed")
            clear_npc_data()

        elseif packet_in['Type'] == 0x03 then
            log('NPC Release [String Event]')
            log("Injecting completed")
            send_packet(get_player_name()..";mirror_status_completed")
            clear_npc_data()

        elseif packet_in['Type'] == 0x04 then
            log('NPC Release [Fishing]')

        end
    end

    function clear_npc_data()
        log("Clearing NPC packet information")
        injecting = false
        retry_count = 1
        sent_messages = {}
        menu_id = nil
        mirroring_state = ""
        message_count = 0
        action_packet = nil
        mirroring = false
        mirror_target = nil
        message_time = os.clock()
        mirror_message = nil
    end

    function npc_reset()
        info('Silmaril Reset')
        if menu_id then
            log("Menu Release Packet")
            windower.packets.inject_incoming(0x052, 'ICHC':pack(0,2,menu_id,0))
            windower.packets.inject_incoming(0x052, string.char(0,0,0,0,1,0,0,0))
        else
            log("General Release Packet")
            windower.packets.inject_incoming(0x052, string.char(0,0,0,0,0,0,0,0))
            windower.packets.inject_incoming(0x052, string.char(0,0,0,0,1,0,0,0))
        end
    end

    function packet_log(packet)
        for index, item in pairs(packet) do
            if not string.find(tostring(index), "_") then
                log("Packet: ["..tostring(index)..'] ['..tostring(item)..']')
            end
        end
    end

    function npc_mirror_state(state)
        if state == "True" then
            single_mirror = true
            log("Mirror State is single use")
        else
            single_mirror = false
            log("Mirror State is multiple use")
        end
    end

    function target_check (packet)
        local p = get_player()
        if not p then return end
        local p_loc = get_player_location()
        if not p_loc then return end
        local w = get_world()
        if not w then return end
        if not mirror_target then return end
        if tonumber(packet['Target']) == tonumber(p.id) then
	        mirror_target = p
            mirror_target.x = p_loc.x
            mirror_target.y = p_loc.y
            mirror_target.z = p_loc.z
            mirror_target.zone = w.zone
            log("Mirror Target is [SELF]")
            log("Mirror Target set by 0x05B packet")
        elseif packet['Target'] then
            mirror_target = windower.ffxi.get_mob_by_id(packet['Target'])
            mirror_target.zone = w.zone
            log("Mirror Target set by 0x05B packet")
        end
    end

    function get_injecting()
        return injecting
    end

    function set_injecting(value)
        injecting = value
    end

    function get_mirror_on()
        return mirror_on
    end

    function set_mirror_on(value)
        mirror_on = value
    end

    function get_mirroring()
        return mirroring
    end

    function set_mirroring(value)
        mirroring = value
    end

    function get_message_time()
        return message_time
    end

    function set_message_time(value)
        message_time = value
    end

    function get_mirror_target()
        return mirror_target
    end

    function set_mirror_target(value)
        mirror_target = value
    end

    function get_blacklisted()
        return blacklisted
    end

    function get_mirroring_state()
        return mirroring_state
    end

    function get_menu_id()
        return menu_id
    end

    function get_mirror_message()
        return mirror_message
    end

    function get_retry_count()
        return retry_count
    end

    function get_current_menu()
        return current_menu
    end

    function set_current_menu(value)
        log("Updated the current menu")
        current_menu = value
    end

end