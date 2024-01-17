do
    local sync = false
    local sync_time = os.clock()
    local enabled = false
    local connected = false

    function main_engine()

        local last_request = os.clock()
        local last_inventory = os.clock()
        local last_sync = os.clock()
        local now = os.clock()
        local auto_load = true

	    while true do
            now = os.clock() -- used to determine the elapsed time
            receive_info() --check the UDP port for incoming traffic

            if not connected then
                auto_load = true
                if now - last_request > 1 then -- Send a requst to client every second
                    if now - sync_time > 2 then
                        sync = false
                    end
                    if not sync then
                        set_following(false)
                        enabled = false
                        request() -- Send the request to connect to silmaril via Connection.lua
                        last_request = now
                    end
                end
            else
                -- Update the player location, player info, and the world
                update_player_info()
                -- Update the in game display
                update_display() 
                -- Check if the player needs to move (before first sleep)
                movement()
                -- updates the player environment Via Update.lua
                send_silmaril() 
                coroutine.sleep(.05)
                receive_info()

                --Update the inventory if 2 seconds have elapsed
                if now - last_inventory > 2 then 
                    get_inventory()
                    last_inventory = now
                end

                -- Update the spells every 30 seconds
                if now - last_sync > 30 then 
                    get_player_spells() -- Spells.lua
                    log("Updated Sync")
                    last_sync = now
                end

                -- Mirroring 
                if get_injecting() then 
                    if now - get_message_time() > get_retry_count() / 2 and not get_menu_id() and get_injecting() then -- Retries the NPC poke after 2 seconds
                        log("No Response from poke so retrying")
                        npc_retry()
                    elseif now - get_message_time() > 15 and get_injecting() then -- Resets if you are still injecting and time out
                        log("Time out of mirror reached - Trying to reset.")
                        npc_reset()
                    end
                end

                -- load the initial settings
                if auto_load then 
                    load_command("")
                    auto_load = false;
                end

            end
            -- Check if the player needs to move (after first sleep)
            movement()
            -- Determines update rate
		    coroutine.sleep(.05)
        end
    end

    function sync_in_progress()
        sync_time= os.clock()
        sync = true
    end

    function set_sync(value)
        sync = value
    end

    function get_sync()
        return sync
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

end