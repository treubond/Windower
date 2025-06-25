do
    local enabled = false
    local tracking_window = texts.new("", {
			text={size=10,font='Consolas',red=255,green=255,blue=255,alpha=255},
			pos={x=0,y=0},
			bg={visible=true,red=0,green=0,blue=0,alpha=102},})
    local location = ""
    local bitzer_position = {
            [1] = {name = 'Diaphanous Bitzer (E)', index = 837, x = 0, y = 0, z = 0 },
            [2] = {name = 'Diaphanous Bitzer (F)', index = 838, x = 0, y = 0, z = 0 },
            [3] = {name = 'Diaphanous Bitzer (G)', index = 839, x = 0, y = 0, z = 0 },
            [4] = {name = 'Diaphanous Bitzer (H)', index = 840, x = 0, y = 0, z = 0 }, }
    local mob_tracking = {
            [1] = {name = 'Abject Obdella', index = 144, distance = 0},
            [2] = {name = 'Biune Porxie', index = 223, distance = 0},
            [3] = {name = 'Cachaemic Bhoot', index = 285, distance = 0},
            [4] = {name = 'Demisang Deleterious', index = 373, distance = 0},
            [5] = {name = 'Esurient Botulus', index = 427, distance = 0},
            [6] = {name = 'Fetid Ixion', index = 498, distance = 0},
            [7] = {name = 'Gyvewrapped Naraka', index = 552, distance = 0},
            [8] = {name = 'Haughty Tulittia', index = 622, distance = 0},}
    local old_zone = 0
    local zone_1 = 133
    local zone_2 = 189
    local zone_3 = 275
    local p_loc = nil
    local position_time = os.clock()
    local repositioned = false
    local repositioned_tick = os.clock()
    local display = true

    function sortie_engine()
        if not enabled then return end

        local world = get_world()
        if not world then return end

        -- Zone change or just starting addon
        if old_zone ~= world.zone then
            old_zone = world.zone
            if world.zone == zone_1 or world.zone == zone_2 or world.zone ~= zone_3 then
                log("Sortie Window Show")
                sortie_position()
            else
                log("Sortie Window Hide")
                enabled = false
                tracking_window:hide()
            end
        end

        if world.zone == zone_1 or world.zone == zone_2 or world.zone == zone_3 then
            tracking_update()
        else
            enabled = false
        end

        -- Wait till you finish moving to check for area
        if repositioned then
            -- Actively try to get the update
            if os.clock() - repositioned_tick > 2 then
                position_update()
                repositioned_tick = os.clock()
            end
            -- Time out of trying to find the bitzer
            if os.clock() - position_time > 5 then
                repositioned = false
                if world.zone ~= zone_1 and world.zone ~= zone_2 and world.zone ~= zone_3 then return end
                info('Bitzer Check Timed Out')
            end
        end
    end

    function packet_in_0x0F5(data)
        local packet = parse_packet('incoming', data)
        if not packet['X'] or not packet['Y'] then log("Enemy not found") return end
        if not packet['Index'] then return end

        local enemy_x = packet['X']
        local enemy_y = packet['Y']
        local enemy_index = packet['Index']
        local table_index = 0

        for index, target in pairs(mob_tracking) do
            if target.index == enemy_index then
                table_index = index
            end
        end

        -- Couldn't find the enemy
        if table_index == 0 then return end

        -- Enemy is dead
        if enemy_x == 0 and enemy_y == 0 then mob_tracking[table_index].distance = 'Dead' return end

        -- Update the distance
        if not p_loc or not p_loc.x or not p_loc.y or not p_loc.z then return end
        local distance = round(((p_loc.x - enemy_x)^2 + (p_loc.y - enemy_y)^2):sqrt(),1)
        mob_tracking[table_index].distance = distance
        --log('Track: ['..enemy_index..'] - ['..enemy_x..'], ['..enemy_y..'] and distance of ['..distance..']')
    end

    -- Used to track mobs and objectives
    function tracking_update()
        -- Update the player position
        p_loc = get_player_info()
        if not p_loc or not p_loc.x or not p_loc.y or not p_loc.z then return end
        local maxWidth = 41
        local lines = T{}
        local bitzer_status = {}
        local bitzer_distance = 0
        lines:insert("     //sm sortie X to change floors")
        lines:insert("")
        lines:insert("            Current Area ["..location.."]")
        lines:insert("")
        if location == "A" then
            --Top Floor A
            lines:insert(mob_tracking[1].name..string.format('[%s]  ',tostring(mob_tracking[1].distance)):lpad(' ',maxWidth - string.len(mob_tracking[1].name)))
            lines:insert("")
            lines:insert("Casket #A1")
            lines:insert("  Kill 5x enemies")
            lines:insert("Casket #A2")
            lines:insert("  /heal past the #A1 gate")
            lines:insert("Coffer #A")
            lines:insert("  Kill Abject Obdella")
            lines:insert("Shard #A")
            lines:insert("  Single target magic killing blow 3x")
        elseif location == 'B' then
            -- Top Floor B
            lines:insert(mob_tracking[2].name ..string.format('[%s]  ',tostring(mob_tracking[2].distance)):lpad(' ',maxWidth - string.len(mob_tracking[2].name)))
            lines:insert("")
            lines:insert("Casket #B1")
            lines:insert("  Kill 3x Biune < 30 sec")
            lines:insert("Casket #B2")
            lines:insert("  Open a #B locked Gate")
            lines:insert("Coffer #B")
            lines:insert("  Kill Porxie after opening Casket #B1")
            lines:insert("Shard #B")
            lines:insert("  WS before death on 5x Biune")
        elseif location == 'C' then
            -- Top Floor C
            lines:insert(mob_tracking[3].name ..string.format('[%s]  ',tostring(mob_tracking[3].distance)):lpad(' ',maxWidth - string.len(mob_tracking[3].name)))
            lines:insert("")
            lines:insert("Casket #C1")
            lines:insert("  Kill 3x enemies < 15 sec")
            lines:insert("Casket #C2")
            lines:insert("  Kill all enemies")
            lines:insert("Coffer #C")
            lines:insert("  Kill Cachaemic Bhoot < 5 min")
            lines:insert("Chest #C")
            lines:insert("  Do 3x Magic Bursts")
        elseif location == 'D' then
            -- Top Floor D
            lines:insert(mob_tracking[4].name ..string.format('[%s]  ',tostring(mob_tracking[4].distance)):lpad(' ',maxWidth - string.len(mob_tracking[4].name)))
            lines:insert("")
            lines:insert("Casket #D1")
            lines:insert("  Kill 6x Demisang of different jobs")
            lines:insert("Casket #D2")
            lines:insert("  WAR->MNK->WHM->BLM->RDM->THF")
            lines:insert("Coffer #D")
            lines:insert("  Kill 3x enemies after NM")
            lines:insert("Chest #D")
            lines:insert("  Do a 4-step skillchain on 3x enemies")
        elseif location == 'E' then
            -- Basement E
            lines:insert(mob_tracking[5].name ..string.format('[%s]  ',tostring(mob_tracking[5].distance)):lpad(' ',maxWidth - string.len(mob_tracking[5].name)))
            bitzer_distance = round(((p_loc.x - bitzer_position[1].x)^2 + (p_loc.y - bitzer_position[1].y)^2):sqrt(),1)
            lines:insert(bitzer_position[1].name ..string.format('[%s]  ',tostring(bitzer_distance)):lpad(' ',maxWidth - string.len(bitzer_position[1].name)))
            lines:insert("")
            lines:insert("Casket #E1")
            lines:insert("  All foes around bitzer (12x)")
            lines:insert("Casket #E2")
            lines:insert("  All flan (15x)")
            lines:insert("Coffer #E")
            lines:insert("  Kill all Naakuals")
            lines:insert("Chest #E")
            lines:insert("  Kill with WS from behind")
        elseif location == 'F' then
            -- Basement F
            lines:insert(mob_tracking[6].name ..string.format('[%s]  ',tostring(mob_tracking[6].distance)):lpad(' ',maxWidth - string.len(mob_tracking[6].name)))
            bitzer_distance = round(((p_loc.x - bitzer_position[2].x)^2 + (p_loc.y - bitzer_position[2].y)^2):sqrt(),1)
            lines:insert(bitzer_position[2].name ..string.format('[%s]  ',tostring(bitzer_distance)):lpad(' ',maxWidth - string.len(bitzer_position[2].name)))
            lines:insert("")
            lines:insert("Casket #F1")
            lines:insert("  5/5 Empy gear at bitzer")
            lines:insert("Casket #F2")
            lines:insert("  Defeat all Veela")
            lines:insert("Coffer #F")
            lines:insert("  Kill all Naakuals")
            lines:insert("Chest #F")
            lines:insert("  ???")
        elseif location == 'G' then
            -- Basement G
            lines:insert(mob_tracking[7].name ..string.format('[%s]  ',tostring(mob_tracking[7].distance)):lpad(' ',maxWidth - string.len(mob_tracking[7].name)))
            bitzer_distance = round(((p_loc.x - bitzer_position[3].x)^2 + (p_loc.y - bitzer_position[3].y)^2):sqrt(),1)
            lines:insert(bitzer_position[3].name ..string.format('[%s]  ',tostring(bitzer_distance)):lpad(' ',maxWidth - string.len(bitzer_position[3].name)))
            lines:insert("")
            lines:insert("Casket #G1")
            lines:insert("  Target the Bizter for 30 sec ")
            lines:insert("Casket #G2")
            lines:insert("  Kill all Dullahan (19x)")
            lines:insert("Coffer #G")
            lines:insert("  Bee->Shark->T-Rex->Bird->Tree->Lion")
            lines:insert("Chest #G")
            lines:insert("  Kill Gyvewrapped Naraka")
        elseif location == 'H' then
            -- Basement H
            lines:insert(mob_tracking[8].name ..string.format('[%s]  ',tostring(mob_tracking[8].distance)):lpad(' ',maxWidth - string.len(mob_tracking[8].name)))
            bitzer_distance = round(((p_loc.x - bitzer_position[4].x)^2 + (p_loc.y - bitzer_position[4].y)^2):sqrt(),1)
            lines:insert(bitzer_position[4].name ..string.format('[%s]  ',tostring(bitzer_distance)):lpad(' ',maxWidth - string.len(bitzer_position[4].name)))
            lines:insert("")
            lines:insert("Casket #H1")
            lines:insert("  Leave then enter")
            lines:insert("Casket #H2")
            lines:insert("  Kill all of one Job")
            lines:insert("Coffer #H")
            lines:insert("  Bee->Lion->T-Rex->Shark->Bird->Tree")
            lines:insert("Chest #H")
            lines:insert("  Kill the NM next to a defated Formor")
        end

        tracking_box_refresh(lines)
    end

    -- start tracking a NM
    function track_on(index)
        packet = new_packet('outgoing', 0x0F5, {
            ['Index'] = index,
            ['_junk1'] = 0,
        })
        inject_packet(packet)
        log('track request for enemy ['..index..']')
    end

    -- stop tracking a NM
    function track_off()
        packet = new_packet('outgoing', 0x0F6, {
            ['_junk1'] = 0,
        })
        inject_packet(packet)
        log('tracking stopped')
    end

    -- NPC Update called from Packets.lua
    function bitzer_Check(data)
        if not repositioned then return end
        local packet = parse_packet('incoming', data)

        if packet['X'] == 0 and packet['Y'] == 0 and packet['Y'] == 0 then return end

        local position = 0

        if packet['Index'] == bitzer_position[1].index then
            position = 1
        elseif packet['Index'] == bitzer_position[2].index then
            position = 2
        elseif packet['Index'] == bitzer_position[3].index then
            position = 3
        elseif packet['Index'] == bitzer_position[4].index then
            position = 4
        else
            return
        end

        -- Update stored position
        bitzer_position[position].x = packet['X']
        bitzer_position[position].y = packet['Y']
        bitzer_position[position].z = packet['Z']
            
        log('Bitzer Found - '..packet['Index']..' ['..packet['X']..'],['..packet['Y']..'],['..packet['Z']..']')
        que_packet('sortie_'..packet['Index']..'_'..packet['X']..'_'..packet['Y']..'_'..packet['Z'])
        repositioned = false
    end

    -- Command by user or update called
    function sortie_command(args)
        if not args[1] then return end
        local area = string.gsub(string.upper(args[1]), "%s+", "")
        enabled = true

        --Top floor
        if args == 'Boss' then
            location = 'Boss'
            track_off()
        elseif args == 'Off' then
            if enabled then info('Setting Display Off') end
            display = true
            track_off()
        elseif args == 'On' then
            if enabled then info('Setting Display On') end
            display = true
        elseif area ~= location then
            location = area
        end

        -- Start the Tracking
        if display and enabled then
            coroutine.schedule(start_track, 5)
        end
    end

    function start_track()
        --Set the NM to track
        local mob_index = {['A'] = 1, ['B'] = 2, ['C'] = 3, ['D'] = 4, ['E'] = 5, ['F'] = 6, ['G'] = 7, ['H'] = 8 }
        if not mob_index[location] then return end
        send_to_chat(8,'The Hunt begins for the ['..mob_tracking[mob_index[location]].name..']....')
        track_on(mob_tracking[mob_index[location]].index)
    end

    -- Repositioning called from Packets.lua
    function sortie_position()
        position_time = os.clock()
        repositioned_tick = os.clock()
        repositioned = true
    end

    -- Called periodically to try to ping for basement bitzer
    function position_update()
        -- Zone E
        if location == 'E' then
            local packet = new_packet('outgoing', 0x016, {['Target Index'] = bitzer_position[1].index })
            inject_packet(packet)
            packet_log(packet, "out")
        -- Zone F
        elseif location == 'F' then
            local packet = new_packet('outgoing', 0x016, {['Target Index'] = bitzer_position[2].index })
            inject_packet(packet)
            packet_log(packet, "out")
        -- Zone G
        elseif location == 'G' then
            local packet = new_packet('outgoing', 0x016, {['Target Index'] = bitzer_position[3].index })
            inject_packet(packet)
            packet_log(packet, "out")
        -- Zone H
        elseif location == 'H' then
            local packet = new_packet('outgoing', 0x016, {['Target Index'] = bitzer_position[4].index })
            inject_packet(packet)
            packet_log(packet, "out")
        else
            repositioned = false
        end
    end

    function reposition_packet(packet)
        -- Main
        if packet['X'] == -836 and packet['Y'] == -20 and packet['Z'] == -178 then
            sortie_command('A')

        -- A Bitzer
        elseif packet['X'] == -460 and packet['Y'] == 96 and packet['Z'] == -150 then
            sortie_command('A')
        -- Ghatjot Exit
        elseif packet['X'] == -900 and packet['Y'] == 416 and packet['Z'] == -200 then
            sortie_command('A')

        -- B Bitzer
        elseif packet['X'] == -344 and packet['Y'] == -20 and packet['Z'] == -150 then
            sortie_command('B')
        -- Leshonn Exit
        elseif packet['X'] == -24 and packet['Y'] == 420 and packet['Z'] == -200 then
            sortie_command('B')

        -- C Bitzer
        elseif packet['X'] == -460 and packet['Y'] == -136 and packet['Z'] == -150 then
            sortie_command('C')
        -- Skomora Exit
        elseif packet['X'] == -20 and packet['Y'] == -456 and packet['Z'] == -200 then
            sortie_command('C')

        -- D Bitzer
        elseif packet['X'] == -576 and packet['Y'] == -20 and packet['Z'] == -150 then
            sortie_command('D')
        -- Aita Exit
        elseif packet['X'] == -896 and packet['Y'] == -460 and packet['Z'] == -200 then
            sortie_command('D')

        -- E Basement Enter
        elseif packet['X'] == 580 and packet['Y'] == 31.5 and packet['Z'] == 100 then
            sortie_command('E')
            sortie_position()
        -- Dhartok Exit
        elseif packet['X'] == 280 and packet['Y'] == 276 and packet['Z'] == 70 then
            sortie_command('E')
        -- E Basement Exit
        elseif packet['X'] == -460 and packet['Y'] == 35.5 and packet['Z'] == -140 then
            sortie_command('A')

        -- F Basement Enter
        elseif packet['X'] == 631.5 and packet['Y'] == -20 and packet['Z'] == 100 then
            sortie_command('F')
            sortie_position()
        -- Gartell Exit
        elseif packet['X'] == 876 and packet['Y'] == 280 and packet['Z'] == 70 then
            sortie_command('F')
        -- F Basement Exit
        elseif packet['X'] == -404.5 and packet['Y'] == -20 and packet['Z'] == -140 then
            sortie_command('B')

        -- G Basement Enter
        elseif packet['X'] == 580 and packet['Y'] == -71.5 and packet['Z'] == 100 then
            sortie_command('G')
            sortie_position()
        -- Triboulex Exit
        elseif packet['X'] == 880 and packet['Y'] == -316 and packet['Z'] == 70 then
            sortie_command('G')
        -- G Basement Exit
        elseif packet['X'] == -460 and packet['Y'] == -75.5 and packet['Z'] == -140 then
            sortie_command('C')

        -- H Basement Enter
        elseif packet['X'] == 528.5 and packet['Y'] == -20 and packet['Z'] == 100 then
            sortie_command('H')
            sortie_position()
        -- Aita Exit
        elseif packet['X'] == 284 and packet['Y'] == -320 and packet['Z'] == 70 then
            sortie_command('H')
        -- H Basement Exit
        elseif packet['X'] == -515.5 and packet['Y'] == -20 and packet['Z'] == -140 then
            sortie_command('D')

        -- Boss Enter
        elseif packet['X'] == 624 and packet['Y'] == -620 and packet['Z'] == 100 then
            log('Enter Boss Room - Turning off Display')
            sortie_command('Boss')
        end
    end

    function set_sortie_display(value)
        display = value
    end

    function set_sortie_enabled(value)
        enabled = value
    end

    -- Sortie tracking box
	function tracking_box_refresh(lines)
        if display and location ~= 'Boss' then
		    local maxWidth = 41
            for i,line in ipairs(lines) do lines[i] = lines[i]:rpad(' ', maxWidth) end
            tracking_window:text(lines:concat('\n'))
            tracking_window:show()
        else
            tracking_window:hide()
        end
	end

    function get_sortie_window()
		return tracking_window
	end

	function set_sortie_window(value)
		tracking_window = value
	end

end