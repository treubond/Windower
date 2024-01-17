do
    -- socket
    local socket = require("socket")
    local udp = nil
    local port = 2025
    local ip = "127.0.0.1"

    -- Called from Silmaril.lua
    function connect()
        initialize() -- via Sync.lua
        udp = assert(socket.udp())
        udp:settimeout(0)
        udp:setpeername(ip, port)
        main_engine() -- start the main proecess via Engine.lua
    end

    -- Called from Engine.lua
    function request()
        local formattedString = get_player_name()..";request_".._addon.version
        send_packet(formattedString)
    end

    --Send the outgoing packet
    function send_packet (msg)
        if msg and udp then
            assert(udp:send(msg))
            log(msg)
        else
            log('Unable to send data')
        end
    end

    function send_update (msg)
        if msg and udp then
            assert(udp:send(msg))
        else
            log('Unable to send data')
        end
    end

    function receive_info()
        repeat
            data, msg = udp:receive()
            if data then

                log(data)
                local message = data:split('_')
                if not validate_message(message[1]) then return end
                local cmd = message[2]

                if cmd == "accepted" then
                    windower.add_to_chat(1, ('\31\200[\31\05Silmaril Addon\31\200]\31\207 '..message[3]))
                    set_connected(true)
                elseif cmd == "sync" then
                    sync_cmd(message[3])
                elseif cmd == "version" then
                    info('Version miss match!')
                    windower.send_command('lua u silmaril')
                elseif cmd == "reset" then
                    log('Reset Request')
                    set_connected(false)
                    set_sync(false)
                elseif cmd == "on" then
                    on_cmd()
                elseif cmd == "off" then
                    off_cmd()
                elseif cmd == "input" then
                    input_message(message[3],message[4],message[5],message[6])
                elseif cmd == "script" then
                    windower.send_command(message[3])
                elseif cmd == "skillchain" then
                    skillchain(message[3],message[4],message[5],message[6])
                elseif cmd == "skillchain2" then
                    skillchain2(message[3],message[4],message[5],message[6])
                elseif cmd == "skillchain3" then
                    skillchain3(message[3],message[4],message[5],message[6])
                elseif cmd == "skillchain4" then
                    skillchain4(message[3],message[4],message[5],message[6])
                elseif cmd == "config" then
                    config_msg(message[3])
                elseif cmd == "blacklist" then
                    add_black_list(message[3])
                elseif cmd == "protection" then
                    set_protection(message[3])
                elseif cmd == "protectlist" then
                    protectlist(message[3], message[4], message[5], message[6])
                end
            end
        until not data
    end

    -- Build the tables for the characters
    function protectlist(param,param2,param3,param4)
        --Parse the message to two tables
        local temp_cache = {}
        for item in string.gmatch(param, "([^,]+)") do
            table.insert(temp_cache, item)
        end

        local temp_reverse = {}
        for item in string.gmatch(param2, "([^,]+)") do
            table.insert(temp_reverse, item)
        end

        -- If the tables match make a combined table
        local name_cache = {}
        local reverse_name_cache = {}
        if #temp_cache == #temp_reverse then
            for i = 1, #temp_cache do
                name_cache[temp_cache[i]] = temp_reverse[i]
                reverse_name_cache[temp_reverse[i]] = temp_cache[i]
            end
        else
            info("Mis-match on Protection Names")
        end

        set_name_cache(name_cache)
        set_reverse_name_cache(reverse_name_cache)

        -- Build the temp LS cache
        temp_cache = {}
        for item in string.gmatch(param3, "([^,]+)") do
            table.insert(temp_cache, item)
        end

        temp_reverse = {}
        for item in string.gmatch(param4, "([^,]+)") do
            table.insert(temp_reverse, item)
        end

        name_cache = {}
        reverse_name_cache = {}
        if #temp_cache == #temp_reverse then
            for i = 1, #temp_cache do
                name_cache[temp_cache[i]] = temp_reverse[i]
                reverse_name_cache[temp_reverse[i]] = temp_cache[i]
            end
        else
            info("Mis-match on Protection Names")
        end

        set_ls_cache(name_cache)
        set_reverse_ls_cache(reverse_name_cache)

    end

    -- Sets the global environment after start up
    function config_msg(param)
        local commands = {}
        for item in string.gmatch(param, "([^,]+)") do
            table.insert(commands, item)
        end
        -- Toggles Mode of mirroring via Mirroring.lua
        npc_mirror_state(commands[1])
        -- Sets the Dress Up addon reloading via Protection.lua
        set_dressup_enable(commands[2])
        -- Sets the state of random player names via Protection.lua
        log("Anon is set to ["..commands[3].."]")
        set_anon(commands[3])
    end

    function sync_cmd(param)
        if not param then return end
        sync_in_progress() -- Stop the engine from sending requests via Engine.lua
        sync_data(param) -- method called via Sync.lua
    end

    function validate_message(param)
        -- Check if it is for right player
        if param == get_player_name() then return true end

        -- If protection is not on its wrong character
        if not get_protection() then return false end

        -- Protection is on so check the cache
        local cache = get_name_cache()

        -- Empty cache
        if not cache then return false end

        -- Right player in cache
        if cache[get_player_name()] == param then return true end

        log(cache)

        -- Correct player was never found
        info("Wrong message to ["..get_player_name()..'] from ['..param..']')
        send_packet(get_player_name()..";protect")
        return false
    end

    function on_cmd()
        set_enabled(true)
        windower.add_to_chat(1, ('\31\200[\31\05Silmaril\31\200]\31\207'..' Actions: \31\06[ON]'))
    end

    function off_cmd()
        set_enabled(false)
        runstop()
        windower.add_to_chat(1, ('\31\200[\31\05Silmaril\31\200]\31\207'..' Actions: \31\03[OFF]'))
    end
end