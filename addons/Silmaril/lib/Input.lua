function input_message(type, index, param, option, option2)

    if not index then log("No Index") return end
    if not type then log("No Type") return end
    if not param then log("No Param") return end

    local pt_loc = get_party_location()
    local target = pt_loc[tonumber(index)]

    if target then 
        log('Using Party Table')
    else
        target = get_mob_by_index(index)
        if not target then
            target = get_mob_by_id(index)
            if not target then
                if type ~= "Reflect" then
                    log("Target not found Type: ["..tostring(type).."] Index ["..tostring(index).."] Param ["..tostring(param).."] Option ["..tostring(option).."] Option 2 ["..tostring(option2).."]")
                    return
                end
            end
        end
    end

	if type == "JobAbility" then
        Action_Message('0x09',target,param)

    elseif type == "PetCommand" then
        Action_Message('0x08',target,param)

	elseif type == "Magic" then
        if not target.valid_target then log('Not a valid target') return end
        if math.sqrt(target.distance) > 22 then log('Enemy too far') return end
        Action_Message('0x03',target,param)

	elseif type == "WeaponSkill" then
        if not target.valid_target then log('Not a valid target') return end
        Action_Message('0x07',target,param)

	elseif type == "Engage" then
        if not target.valid_target then log('Not a valid target') return end
        if target.spawn_type ~= 16 then log('Not a valid spawn type') return end
        if math.sqrt(target.distance) > 30 then log('Enemy too far') return end
        if target.hpp == 0 then log('Enemy is dead') return end
        Action_Message('0x02',target,param)

    elseif type == "Assist" then
        if not target.valid_target then log('Not a valid target') return end
        if target.spawn_type ~= 16 then log('Not a valid spawn type') return end
        if math.sqrt(target.distance) > 30 then log('Enemy too far') return end
        if target.hpp == 0 then log('Enemy is dead') return end
        Action_Message('0x0C',target,"")

    elseif type == "Switch" then
        if not target.valid_target then log('Not a valid target') return end
        if target.spawn_type ~= 16 then log('Not a valid spawn type') return end
        if math.sqrt(target.distance) > 30 then log('Enemy too far') return end
        if target.hpp == 0 then log('Enemy is dead') return end
        Action_Message('0x0F',target,param)

    elseif type == "Shoot" then
        if not target.valid_target then log('Not a valid target') return end
        if target.spawn_type ~= 16 then log('Not a valid spawn type') return end
        if math.sqrt(target.distance) > 30 then log('Enemy too far') return end
        if target.hpp == 0 then log('Enemy is dead') return end
        Action_Message('0x10',target,param)

    elseif type == "AcceptRaise" then
        Action_Message('0x0D',target,param)

	elseif type == "Disengage" then
        Action_Message('0x04',target,param)

	elseif type == "RunAway" then -- done via Moving.lua
        runaway(target,param)

    elseif type == "RunTo" then -- done via Moving.lua
        runto(target,param)

    elseif type == "RunToLocation" then -- done via Moving.lua
        runtolocation(target,param,option)

    elseif type == "RunStop" then -- done via Moving.lua
        runstop()

    elseif type == "FastFollow" then -- done via Moving.lua
        if option == "True" then
            set_fast_follow(true, target)
        else
            set_fast_follow(false, target)
        end

    elseif type == "Face" then -- done via Moving.lua
        face_target(target, param)

    elseif type == "LockOn" then -- done via Moving.lua
        if not target.valid_target then log('Not a valid target') return end
        if math.sqrt(target.distance) > 50 then log('Enemy too far') return end
        lockon(target,param)

    elseif type == "Cancel" then
        cancel_buff(param)
		log("Cancel ["..string.format("%i",param)..']')

    elseif type == "Script" then
        if not option then log("Script missing option text") return end
        Action_Message('0x??',target,option)

    elseif type == "RawInput" then
        Action_Message('raw',target,option)

    elseif type == "Item" then
        Action_Message('0x037',target,param)

    elseif type == "Message" then
        if param == "0" then send_command('input /tell '..target.name..' '..option..'') -- Tell
        elseif param == "1" then send_command('input /party '..option..'') -- Party
        elseif param == "2" then send_command('input /echo '..option..'') -- Echo player only
        elseif param == "3" then send_command('input /echo '..option..'') send_ipc('silmaril message '..option) end -- Echo party

    elseif type == "Mirror" then
        clear_npc_data()
        Mirror_Message(target, param, option)

    elseif type == "Reflect" then
        set_mirror_on(false)
        npc_box_status()
        clear_npc_data()
        if #option2 > 1 then -- A force warp command is sent
            local message = option2:split(',')
            if message[1] and message[2] and message[3] then
                log("Force Warp - Creating Target")
                target = {}
                target.name = "Generated Target"
                target.index = tonumber(index)
                target.id = tonumber(param)
                target.x = message[1]
                target.y = message[2]
                target.z = message[3]

                set_force_warp(true) -- Start modifying the 0x015
                set_mirror_target(target)  -- Set the target to be used later
                set_warp_message(option) -- Set the message to be used later
                set_warp_spoof(true) -- Wait for the first modified to be sent
                set_outgoing_warp(true) -- Inject the message only once
                return -- Let the silmaril.lua take over
            else
                log("Option Incorrect")
                return
            end
        end
        if not target then log('No Target Found') return end
        npc_build_message(target, option)
	end

end

function Action_Message(category, target, param)
    local command = ""
	if not target or not target.id then
        log("target not found")
		return
	end

    if not param then
        log("param not found")
		return
    end

    -- use input commands so that gearswap can swap our gear for us - use target ID
    if category == '0x09' then
        local ability = get_ability(tonumber(param))
        if not ability then return log("Ability not found") end
        command = 'input '..ability.prefix..' "'..ability.en..'" '..target.id
        send_command(command)
        log(command)
    elseif category == '0x07' then
        local ability = get_weaponskill(tonumber(param))
        if not ability then return log("Ability not found") end
        command = 'input '..ability.prefix..' "'..ability.en..'" '..target.id
        send_command(command)
        log(command)
    elseif category == '0x08' then
        local ability = get_ability(tonumber(param))
        if not ability then return log("Ability not found") end
        command = 'input '..ability.prefix..' "'..ability.en..'" '..target.id
        send_command(command)
        log(command)
    elseif category == '0x03' then
        local ability = get_spell(tonumber(param))
        if not ability then return log("Ability not found") end
        command = 'input '..ability.prefix..' "'..ability.en..'" '..target.id
        send_command(command)
        log(command)
    elseif category == '0x037' then
        local ability = get_item(tonumber(param))
        if not ability then return log("Ability not found") end
        command = 'input /item "'..ability.en..'" '..target.id
        send_command(command)
        log(command)
    elseif category == '0x10' then
        command = 'input /ra '..target.id
        send_command(command)
        log(command)
    elseif category == '0x??' then
        command = 'input '..param..' '..target.id
        send_command(command)
        log(command)
    elseif category == 'raw' then
        send_command(param)
        log(param)
    else
        local packet = new_packet('outgoing', 0x1A, 
        {
			['Target'] = target.id,
			['Target Index'] = target.index,
			['Category'] = category, -- Spell Cast
            ['Param'] = param, -- Spell ID
	    })
        inject_packet(packet)
        log("Packet Injected ["..category..'] ['..target.name..']')
    end
end

function Mirror_Message(target, param, option)
    local type =  tonumber(param)

    -- License was not found
    if type == 0 then
        send_to_chat(80,'------- License Not Found -------')

    -- Turns on/off Mirroring
    elseif type == 1 then
        if get_mirror_on() then
            set_mirror_on(false)
            info('\31\200[\31\05Silmaril\31\200]\31\207'..' Mirror: \31\03[OFF]')
        else
            set_mirror_on(true)
            info('\31\200[\31\05Silmaril\31\200]\31\207'..' Mirror: \31\06[ON]')
        end
        npc_box_status() -- done via Display.lua
        send_packet(get_player_id()..";mirror_off") -- Send to other players to turn off via Silmaril.exe

    -- Mirror Message
    elseif type == 2 then
        npc_build_message(target, option)

    -- Spare
    elseif type == 3 then

    -- Turn off mirroring for other toons
    elseif type == 4 then 
        set_mirror_on(false)
        npc_box_status()

    -- Turn off screen
    elseif type == 5 then 
        sm_result_hide()
    end
end

