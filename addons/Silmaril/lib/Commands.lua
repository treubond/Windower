function commands(cmd, args)
    if cmd ~= nil then
        cmd = cmd:lower()
        log(args)
        if cmd == "start" or cmd == "on" or (cmd == "toggle" and not enabled) then
            start_command(args)
        elseif cmd == "stop" or cmd == "off" or (cmd == "toggle" and enabled) then
            stop_command(args)
        elseif cmd == "follow" then
            follow_command(args)
        elseif cmd == "all" then
            all_command(args)
        elseif cmd == "load" then
            load_command(args)
        elseif cmd == 'debug' then
            debug_command() -- via Display.lua
        elseif cmd == 'info' then
            info_command() -- via Display.lua
        elseif cmd == 'display' then
            display_command() -- via Display.lua
        elseif cmd == 'save' then
            save_command() -- via Display.lua
        elseif cmd == 'reset' then
            npc_reset() -- via Mirror.lua
        elseif cmd == "input" then
            input_message(args[1], args[2], args[3]) -- sm input JobAbility 99 125
        elseif cmd == "script" then
            script_command()
        elseif cmd == 'mirror' then
            mirror_command()
        end
    end
end

function start_command(args)
    if args[1] then
        local sub_command = args[1]:lower()
        if sub_command == "all" then
            send_packet(get_player_name()..";start_all")
        end
    else
        send_packet(get_player_name()..";start")
    end
end

function stop_command(args)
    if args[1] then
        local sub_command = args[1]:lower()
        if sub_command == "all" then
            send_packet(get_player_name()..";stop_all")
        end
    else
        send_packet(get_player_name()..";stop")
    end
end

function follow_command(args)
    if not args[1] then return end
    local sub_command = args[1]:lower()
    if sub_command == 'off' then
        send_packet(get_player_name()..";follow_off_none")
    elseif sub_command == 'on' then
        send_packet(get_player_name()..";follow_on_"..get_player_name())
    elseif sub_command == 'toggle' then
        if get_following() then
            send_packet(get_player_name()..";follow_off_none")
        else
            send_packet(get_player_name()..";follow_on_"..get_player_name())
        end
    elseif sub_command and #sub_command > 0 then
        send_packet(get_player_name()..";follow_on_"..sub_command)
    end
end

function all_command(args)
    if not args[1] then return end
    local sub_command = args[1]:lower()
    if sub_command == 'start' or sub_command == 'on' or (sub_command == "toggle" and not get_enabled()) then
        send_packet(get_player_name()..";start_all")
    elseif sub_command == 'off' or sub_command == 'stop' or (sub_command == "toggle" and get_enabled()) then
        send_packet(get_player_name()..";stop_all")
    elseif sub_command == 'follow' then
        if get_following() then -- Set follow to off if you are following
            send_packet(get_player_name()..";follow_all_none")
        else
            send_packet(get_player_name()..";follow_all_"..get_player_name())
        end
    elseif sub_command == 'load' then
        local command_string = ""
        for i = 1, #args do
            command_string = command_string..args[i].." "
        end
        command_string = command_string:sub(1, #command_string - 1)
        windower.send_ipc_message(command_string)
        windower.send_command('sm '..command_string)
        log(command_string)
    end
end

function load_command(args)
    local p = get_player()
    if not p then return end

    local smModePath = "_"

    for i = 1, #args do
        smModePath = smModePath..args[i].."_"
    end

    if p.sub_job_id ~= 0 then
        send_packet(get_player_name()..";load"..smModePath..p.main_job.."_"..p.sub_job.."_"..get_player_name())
    else
        send_packet(get_player_name()..";load"..smModePath..p.main_job.."_"..get_player_name())
    end
end

function script_command()
    send_packet(get_player_name()..";script")
end

function mirror_command()
    send_packet(get_player_name()..";mirror_request")
end