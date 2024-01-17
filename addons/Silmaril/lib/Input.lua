function input_message(type, index, param, option)

    local target = windower.ffxi.get_mob_by_index(index)
    if not target then
        target = windower.ffxi.get_mob_by_id(index)
        if not target then
            local pt_loc = get_party_location()
            target = pt_loc[tonumber(index)]
            if not target then
                log("target not found")
                return
            end
        end
    end

	if type == "JobAbility" then
        Action_Message('0x09',target,param)
		log("Job Ability")

	elseif type == "Magic" then
        if not target.valid_target then return end
        if math.sqrt(target.distance) > 22 then return end
        Action_Message('0x03',target,param)
		log("Magic")

	elseif type == "WeaponSkill" then
        if not target.valid_target then return end
        Action_Message('0x07',target,param)
		log("Weapon Skill")

	elseif type == "Engage" then
        if not target.valid_target then return end
        if target.spawn_type ~= 16 then return end
        if math.sqrt(target.distance) > 30 then return end
        if target.hpp == 0 then return end
        Action_Message('0x02',target,param)
		log("Engage")

    elseif type == "Assist" then
        if not target.valid_target then return end
        if target.spawn_type ~= 16 then return end
        if math.sqrt(target.distance) > 30 then return end
        if target.hpp == 0 then return end
        Action_Message('0x0C',target,"")
		log("Assist")

    elseif type == "Switch" then
        if not target.valid_target then return end
        if target.spawn_type ~= 16 then return end
        if math.sqrt(target.distance) > 30 then return end
        if target.hpp == 0 then return end
        Action_Message('0x0F',target,param)
		log("Switch")

    elseif type == "AcceptRaise" then
        Action_Message('0x0D',target,param)
		log("Accept Raise")

    elseif type == "Shoot" then
        if not target.valid_target then return end
        if target.spawn_type ~= 16 then return end
        if math.sqrt(target.distance) > 30 then return end
        if target.hpp == 0 then return end
        Action_Message('0x10',target,param)
		log("Shoot")

	elseif type == "Disengage" then
        Action_Message('0x04',target,param)
		log("Disengage")

	elseif type == "RunAway" then -- done via Moving.lua
        if not target.valid_target then runStop() return end
        runaway(target,param)

    elseif type == "RunTo" then -- done via Moving.lua
        runto(target,param)

    elseif type == "RunToLocation" then -- done via Moving.lua
        runtolocation(target,param,option)

    elseif type == "RunStop" then -- done via Moving.lua
        runstop()

    elseif type == "FastFollow" then -- done via Moving.lua
        log(option)
        if option == "True" then
            set_fast_follow(true)
        else
            set_fast_follow(false)
        end

    elseif type == "Face" then -- done via Moving.lua
        if not target.valid_target then return end
        if math.sqrt(target.distance) > 50 then return end
        face_target(target, param)
		log("Face ["..param..']')

    elseif type == "LockOn" then -- done via Moving.lua
        if not target.valid_target then return end
        if math.sqrt(target.distance) > 50 then return end
        lockon(target,param)
		log("LockOn")

    elseif type == "Cancel" then
        windower.packets.inject_outgoing(0xF1,string.char(0xF1,0x04,0,0,tostring(param)%256,math.floor(tostring(param)/256),0,0))
		log("Cancel ["..tostring(param)..']')

    elseif type == "Script" then
        if not option then log("Script missing option text") return end
        Action_Message('0x??',target,option)
        log("Script - Script")

    elseif type == "RawInput" then
        Action_Message('raw',target,option)
        log("Raw Input")

    elseif type == "Item" then
        Action_Message('0x037',target,param)
        item_warning(param, option) -- done via Inventory.lua

    elseif type == "Message" then
        if param == "0" then windower.send_command('input /tell '..target.name..' '..option..'') -- Tell
        elseif param == "1" then windower.send_command('input /party '..option..'') -- Party
        elseif param == "2" then windower.send_command('input /echo '..option..'') -- Echo player only
        elseif param == "3" then windower.send_command('input /echo '..option..'') windower.send_ipc_message('message '..option) end -- Echo party

    elseif type == "Mirror" then
        local p = get_player()
        if not p then return end
        if target.index ~= p.index then npc_build_message(target, option) return end
        if tonumber(param) == 0 then
            windower.add_to_chat(80,'------- License Not Found -------')
        elseif tonumber(param) == 1 then
            if get_mirror_on() then
                set_mirror_on(false)
                windower.add_to_chat(1, ('\31\200[\31\05Silmaril\31\200]\31\207'..' Mirror: \31\03[OFF]'))
            else
                set_mirror_on(true)
                windower.add_to_chat(1, ('\31\200[\31\05Silmaril\31\200]\31\207'..' Mirror: \31\06[ON]'))
            end
            set_mirroring(false)
            set_mirror_target(nil)
            set_injecting(false)
            npc_box_status() -- done via Display.lua
            send_packet(get_player_name()..";mirror_off") -- Send to other players to turn off via Silmaril.exe
        elseif tonumber(param) == 2 then
            -- Warp target - self
            npc_build_message(target, option)
        elseif tonumber(param) == 3 then
            local all_results = {}
            -- Builds the messages into a table
            for item in string.gmatch(option, "([^|]+)") do
                local result = string.split(item,",",2)
                all_results[result[1]] = result[2]
            end
            set_status_time()
            npc_box_status(all_results)
        elseif tonumber(param) == 4 then -- Turn off mirroring for other toons
            set_mirror_on(false)
            set_mirroring(false)
            set_mirror_target(nil)
            set_injecting(false)
            npc_box_status()
        elseif tonumber(param) == 5 then -- Turn off screen
            sm_result_hide()
        end
	end
end

function Action_Message(category, target, param)
    local command = ""
	if not target then
        log("target not found")
		return
	end
    -- use input commands so that gearswap can swap our gear for us - use target ID
    if category == '0x09' then
        command = 'input /ja "'..get_ability(tonumber(param)).en..'" '..target.id
        windower.send_command(command)
        log(command)
    elseif category == '0x07' then
        command = 'input /ws "'..get_weaponskill(tonumber(param)).en..'" '..target.id
        windower.send_command(command)
        log(command)
    elseif category == '0x037' then
        command = 'input /item "'..get_item(tonumber(param)).en..'" '..target.id
        windower.send_command(command)
        log(command)
    elseif category == '0x03' then
        command = 'input /ma "'..get_spell(tonumber(param)).en..'" '..target.id
        windower.send_command(command)
        log(command)
    elseif category == '0x10' then
        command = 'input /ra '..target.id
        windower.send_command(command)
        log(command)
    elseif category == '0x??' then
        command = 'input '..param..' '..target.id
        windower.send_command(command)
        log(command)
    elseif category == 'raw' then
        windower.send_command(param)
        log(param)
    else
        packets.inject(packets.new('outgoing', 0x1A, {
			['Target'] = target.id,
			['Target Index'] = target.index,
			['Category'] = category, -- Spell Cast
            ['Param'] = param, -- Spell ID
	    }))
        log("Packet Injected ["..category..'] ['..target.name..']')
    end
end


