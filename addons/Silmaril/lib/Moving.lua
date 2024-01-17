do
	local autorun = false
	local autorun_target = {}
	local autorun_distance = .25
	local autorun_tofrom = 0
	local face_follower = false
	local move_to_exit= false
	local following = false

	function movement()

		-- no actin needed
		if not autorun then return end

		if not autorun_target then runstop() return end

		-- Get the player
		local p = get_player()
		if not p then runstop() return end

		-- Get the player location
		local p_loc = get_player_location()
		if not p_loc then runstop() return end

		-- Get the party table that contains IPC data
		local pt_loc = get_party_location()
		if not pt_loc then runstop() return end

		-- Get the world data to check for zones
		local w = get_world()
		if not w then runstop() return end

		-- Don't update the target if it's a run to location command
		if autorun_tofrom ~= 3 then
			-- Check if IPC data is availible
			t = pt_loc[tonumber(autorun_target.id)]
			if t and t.zone == w.zone then
				t.distance = (p_loc.x-t.x)^2 + (p_loc.y-t.y)^2
			else
				t = windower.ffxi.get_mob_by_id(autorun_target.id)
			end
		end

		if not t then runstop() return end

		t.distance = t.distance:sqrt()

		if t.distance > 50 then runstop() return end

		if not get_connected() then runstop() return end

		if not get_enabled() and not following then runstop() return end

		-- Don't move because you are in injecting
		if get_injecting() then runstop() return end

		-- Player not able to move
		if p.status ~= 0 and p.status ~=1 and p.status ~=5 and p.status ~=85 then runstop() return end

		-- Target is not followable
		if t.status ~= 0 and t.status ~= 1 and t.status ~= 5 and t.status ~= 85 then runstop() return end

		-- Ensure following distance is large enough
		if autorun_distance < .5 then autorun_distance = .5 end

		-- Enemy dead
		if t.spawn_type == 16 and t.status > 1 then log('Stopping because enemy is dead') runstop() end

		-- You are within distance so stop running
		if t.distance > autorun_distance + .05 and autorun_tofrom == 2 then runstop() return end
		if t.distance + .05 < autorun_distance and autorun_tofrom == 1 then runstop() return end

		-- Perform the movement
		if autorun_tofrom == 1 or autorun_tofrom == 3 then -- run towards
			local angle = math.atan2((t.y - p_loc.y), (t.x - p_loc.x))*-1
			windower.ffxi.run(angle)
		elseif autorun_tofrom == 2 then -- run away from
			-- If player is locked on then remove it
			if p.target_locked then windower.send_command("input /lockon") end
			local angle = math.atan2((t.y - p_loc.y), (t.x - p_loc.x))*-1
			windower.ffxi.run(angle + math.pi)
		end

	end

	-- Command to stop
	function runstop()
		if move_to_exit then return end
		autorun = false
		autorun_tofrom = 0
		windower.ffxi.run(false)
	end

	-- Close distance #1
	function runto(target,distance)
		if move_to_exit then return end
		autorun = true
		autorun_target = target
		autorun_distance = tonumber(distance)
		autorun_tofrom = 1
		runsstart = os.clock()
	end

	-- Run away #2
	function runaway(target, distance) 
		if move_to_exit then return end
		autorun = true
		autorun_target = target
		autorun_distance = tonumber(distance)
		autorun_tofrom = 2
		runsstart = os.clock()
	end

	-- Move to a specified location #3
	function runtolocation(target,distance,option)
		if move_to_exit then return end
		run_to_location = {}
	    for item in string.gmatch(option, "([^,]+)") do
            table.insert(run_to_location, item)
        end

		-- Modify the target so you can just use runto()
		target.x = run_to_location[1]
		target.y = run_to_location[2]
		target.z = run_to_location[3]

		autorun = true
		autorun_target = target
		autorun_distance = tonumber(distance)
		autorun_tofrom = 3
		runsstart = os.clock()
	end

	function face_target(target, direction)
		if move_to_exit then return end
		-- Get the player location
		local p_loc = get_player_location()
		if not p_loc then return end

		local angle = 0
		if direction == "1" then -- 1 is face target
			angle = math.atan2((target.y - p_loc.y), (target.x - p_loc.x))*-1
		elseif direction == "2" then -- 2 is face away from target
			angle = math.atan2((target.y - p_loc.y), (target.x - p_loc.x))*-1 + math.pi
		elseif direction == "3" then -- 3 is match player direction
			angle = target.heading
		elseif direction == "4" then -- 4 is oppostie of player heading
			angle = target.heading + math.pi
		else
			return
		end
		windower.ffxi.turn(angle)

	end

	function set_fast_follow (state)
		if state then
			following = true
			windower.add_to_chat(1, ('\31\200[\31\05Silmaril\31\200]\31\207'..' Following: \31\06[ON]'))
		else
			following = false
			windower.add_to_chat(1, ('\31\200[\31\05Silmaril\31\200]\31\207'..' Following: \31\03[OFF]'))
			runstop()
		end
	end

	function lockon(target, lock)
		-- Get the player
		local p = get_player()
		if not p then return end
		if not get_enabled() then return end
		if p.target_locked and lock == "0" then 
			windower.send_command("input /lockon")
		elseif not p.target_locked and lock == "1" then
			if p.target_index ~= target.index then
				local inject = packets.new("incoming", 0x058, {
					['Player'] = p.id,
					['Target'] = target.id,
					['Player Index'] = p.index,
				})
				packets.inject(inject)
			else
				windower.send_command("input /lockon")
			end
		end
	end

	function zone_check(player_id, zone, player_x, player_y, player_z, type, zone_line)

		-- Check if following is on - if not return
		if not following then return end

		-- Wrong member zoned so disregard+
		if autorun_target.id ~= tonumber(player_id) then log("Wrong Player") return end

		-- Get the world data and retun is not correct zone
		local w = get_world()
		if not w then return end
		if w.zone ~= tonumber(zone) then return end

		if w.mog_house then
			runstop()
			log("Mog House zone packet injected")
			local packet = packets.new('outgoing', 0x05E, 
				{
					['Zone Line'] = zone_line, 
					['Type'] = type
				})
			packets.inject(packet)
		else
			-- Get the player location
			local p_loc = get_player_location()
			if not p_loc then return end
			log('Zone Detected - turning and running towards zone')
			move_to_exit = true
			local angle = (math.atan2((player_y - p_loc.y), (player_x - p_loc.x))*180/math.pi)*-1
			autorun = false
			windower.ffxi.run((angle):radian())
		end
	end

	function zone_completed()
		log("Zone detected - turing off [move_to_exit]")
		move_to_exit = false
	end

	function get_following()
		return following
	end

	function get_autorun()
		return autorun
	end

	function set_following(value)
		following = value
	end

end