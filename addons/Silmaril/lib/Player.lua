do
    local old_pos = {x=0, y=0, z=0} -- Stores last movement location
    local player_buffs = "playerbuffs_"
    local motion = false
    local player = {}
    local player_id = "0" -- used for when the lua is being unloaded
    local player_pet = {}
    local player_location = {}
    local stop_time = os.time()
    local player_moving = false
    local server_delta = 0

    function update_player_info()

        -- This is updated at high speed
        local now = os.clock()

        -- get/set the world data
        local w = get_info()
        set_world(w)
        if not w then return end

        player = get_player_data()
        if not player then return end
        player_id = tostring(player.id)

        player_location = get_mob_by_id(player.id)
        if not player_location then return end

        -- Determine if player is moving
        local movement = math.sqrt((player_location.x-old_pos.x)^2 + (player_location.y-old_pos.y)^2 + (player_location.z-old_pos.z)^2 ) > 0.025

        -- Change of state
        if movement and not motion then
	        motion = true
        elseif not movement and motion then
            stop_time = now
	        motion = false
        end

        if not motion and now - stop_time > .25 then 
            player_moving = false
        else
            player_moving = true
        end

        -- Store the old location
   	    old_pos.x = player_location.x
	    old_pos.y = player_location.y
	    old_pos.z = player_location.z

        --target_index
        if not player.target_index then
            player.target_index = 0
        end

        -- Create a player to update the IPC table
        local character = { 
            id = player.id,
            name = get_player_name(), 
            zone = w.zone, 
            x = player_location.x, 
            y = player_location.y, 
            z = player_location.z, 
            heading = player_location.heading, 
            status = player.status,
            target_index = player.target_index}

        -- Update the party table with your information
		set_party_location(character)

        --Send the information to others via IPC
	    send_ipc('silmaril update '..
            player.id..' '..
            get_player_name()..' '..
            w.zone..' '..
            string.format("%.3f",player_location.x)..' '..
            string.format("%.3f",player_location.y)..' '..
            string.format("%.3f",player_location.z)..' '..
            string.format("%.3f",player_location.heading)..' '..
            player.status..' '..
            player.target_index)
    end

    function get_player_info()
        local player_info = "player_"
        if not player then return player_info end
        local jp_spent = player.job_points[player.main_job:lower()].jp_spent
        local locked_on = false

        --target_locked
        if player.target_locked then
            locked_on = true
        end

        -- No sub job unlocked or Oddy
        if not player.sub_job_id then
            player.sub_job_id = 0
            player.sub_job_level = 0
        end

        -- Update character status
        player_info = 'player_'..
            string.format("%i",player.main_job_id)..','..
            string.format("%i",player.main_job_level)..','..
            string.format("%i",player.sub_job_id)..','..
            string.format("%i",player.sub_job_level)..','..
            string.format("%i",jp_spent)..','..
            tostring(locked_on)..','..
            tostring(player_moving)..','..
            tostring(get_following())..','..
            string.format("%i",get_autorun_target())..','..
            string.format("%i",get_autorun_type())..','..
            tostring(get_mirroring())..','..
            tostring(get_injecting())..','

        return player_info
    end

    function first_time_buffs()
        local formattedString = ""
        if player then
            local intIndex = 1
            for index, value in pairs(player.buffs) do
                formattedString = formattedString..string.format("%i",value)..',Unknown'
                if intIndex ~= tablelength(player.buffs) then
                    formattedString = formattedString .."|"
                end
                intIndex = intIndex + 1
            end
        end
        player_buffs = formattedString
    end

    function player_packet_buffs(original)    
        local packet = parse_packet('incoming', original)
        local formattedString = ""
        for i=1,32 do
            local buff = 'Buffs '..string.format("%i",i)
            local buff_index = 'Time '..string.format("%i",i)
            if packet[buff] ~= 255 and packet[buff] ~= 0 then
                -- Buff time is offset in mins from SE Epoc
                local buff_id = packet[buff]
                --This uses the standard epoc but then to reduce offset they must increment it every 2.27 years
                local buff_offset = 1009810800 + (4294967280 * 9 + packet[buff_index])/ 60 - server_delta
                local end_time = os.date('%Y-%m-%dT%H:%M:%S',buff_offset)
                --log('Buff end time ['..end_time..']')
                formattedString = formattedString..buff_id..','..end_time..'|'
            end
        end
        player_buffs = formattedString:sub(1, #formattedString - 1)
    end

    function get_moving()
		return moving
	end

    function get_player()
		return player
	end

    function set_player(p)
		player = p
	end

    function get_player_location()
		return player_location
	end

    function set_player_location(loc)
		player_location = loc
	end

    function get_player_buffs()
        return 'playerbuffs_'..player_buffs
    end

    function get_player_name()

        -- player is null so give it a shot again
        if not player then player = get_player_data() end

        -- Something wrong happened here - couldn't find the player
        if not player or not player.name then info("Player not found") return "Unknown" end

        -- return the normal name if protection off
        if not get_protection() then return player.name end

        -- Protection is on so get the reverse name
        local cache = get_name_cache()

        -- No table is set so return default name
        if not cache then log("No name cache set") return player.name end

        if cache[player.name] then return cache[player.name] end

        -- Wasn't found in table so return normal name anyway
        log("Couldn't find the name in the protection cache")
        return player.name
    end

    function set_player_pet(value)
        player_pet = value
    end

    function get_player_pet()
        return player_pet
    end

    function get_player_id()
        return player_id
    end

    function set_player_id(value)
        player_id = value
    end

    function set_server_offset(timestamp , offset)
        local server_time = 1009810800 + timestamp - offset - 2.5
        server_delta = server_time - os.time()
        --log('Server Offset is ['..server_delta..'] seconds')
    end

end