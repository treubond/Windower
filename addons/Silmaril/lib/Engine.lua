do
    local enabled = false
    local connected = false
    local old_status = 0
    local auto_load = true
    local auto_load_time = os.clock()
    local sortie_addon = true

    function main_engine()

        local engine_speed = 1/30
        local movement_speed = 1/10
        local send_speed = 1/4
        local display_speed = 1/4
        local sync_speed = 30

        local now = os.clock()
        local last_request = now
        local last_sync = now
        local last_display = now
        local last_movement = now
        local last_send = now

	    while true do

            now = os.clock() -- used to determine the elapsed time
            receive_info() --check the UDP port for incoming traffic

            if not connected then
                -- Send a requst to client every second
                if now - last_request > 2 then
                    request() -- Send the request to connect to silmaril via Connection.lua
                    last_request = now
                end
            else

                if now - last_movement > movement_speed then
                    last_movement = now

                    -- Update the player information via Player.lua
                    update_player_info()

                    -- Process player movement
                    movement()

                end

                if now - last_send > send_speed then

                    last_send = now

                    -- Send the info to Silmaril
                    send_silmaril()

                    -- Player was mirroring and recieved a release packet.  Now just wait till status ~= 4
                    if get_mirror_on() and get_mirroring() then
                        local p = get_player()
                        if old_status == 4 and p.status == 0 and get_mirror_release() then
                            -- Player is released via status change (non standard)
                            log("Mirror sequence completed via status change")
                            npc_mirror_complete()
                            clear_npc_data()
                        end
                        old_status = p.status
                    end

                    -- Mirroring 
                    if get_injecting() then 
                        local retry_count = get_retry_count()
                        -- No poke response after the time delay
                        if now - get_poke_time() > 1 and not get_mid_inject() then
                            -- There are still message so try to get a poke response
                            if get_mirror_message() then
                                if retry_count < 5 then
                                    retry_count = retry_count + 1
                                    log("Retry Poke ["..retry_count..'/5] - Time Out ('..tostring(now - get_poke_time())..')')
                                    send_packet(get_player_id()..";mirror_status_retry_"..string.format("%i",retry_count))
                                    npc_retry()
                                else
                                    info("Timed out - Unable to Poke NPC.")
                                    set_force_warp(false)
                                    send_packet(get_player_id()..";mirror_status_failed")
                                    npc_reset()
                                end
                            else
                                -- Turns off injection and finishes process
                                npc_inject()
                            end
                        end

                        -- Mid injection and no response so follow up with injection
                        if get_mid_inject() then
                            local delay = now - get_message_time()
                            if (delay > .25 and get_force_warp()) or delay > 2 then
                                log("Middle of injection and message time exceeded (Force Warp) - Time Out ("..tostring(now - get_message_time())..")")
                                if not get_mirror_message() then
                                    info("Timed out and all message are sent - Consider complete and reseting.")
                                    send_packet(get_player_id()..";mirror_status_failed")
                                    npc_reset()
                                else
                                    log("Continue the injection.")
                                    npc_inject()
                                end
                            end
                        end

                    end

                    -- load the initial settings
                    if auto_load and now - auto_load_time > 2 then 
                        load_command("")
                        log("Auto Load Settings")
                        auto_load = false;
                    end
                end

                -- Update the in game display
                if now - last_display > display_speed then
                    last_display = now
                    update_display() -- call to Display.lua
                    check_addons() -- call to Addons.lua
                end

                -- Update the spells the player has
                if now - last_sync > sync_speed then 
                    get_player_spells() -- Spells.lua
                    log("Updated Sync")
                    last_sync = now
                end

            end
            sleep_time(engine_speed)
        end
    end

    function get_enabled()
        return enabled
    end

    function set_enabled(value)
        enabled = value
    end

    function set_connected(value)
        log("Connected ["..tostring(value)..']')
        sync = false
        connected = value
    end

    function get_connected()
        return connected
    end

    function set_auto_load(value)
        auto_load = value
        auto_load_time = os.clock()
    end

end