function send_silmaril()

    --Begin updates via a heartbeat check
    local packet_data = get_player_name()..';heartbeat'

    --Player status from Player.lua
    packet_data = packet_data..';'..get_player_info()

    --Player buffs from Player.lua
    packet_data = packet_data..';'..get_player_buffs()

        --Party data via Party.Lua
    for index, value in pairs(get_party_data()) do
        packet_data = packet_data..';'..value
    end

    --Party Buffs via Buffs.lua
    for index, value in pairs(get_party_buffs()) do
        packet_data = packet_data..';'..value
    end

    --Job ability recasts vis Abilities.lua
    packet_data = packet_data..';'..get_abilities_recast()

    --Spell recasts to the Silmaril Program
    packet_data = packet_data..';'..get_spell_recast()

    --Item data to the Silmaril Program via World.lua
    packet_data = packet_data..';'..get_inventory()

    --World data to the Silmaril Program via World.lua
    packet_data = packet_data..';'..get_world_data()

    --Enemy data to the Silmaril Program via World.lua
    packet_data = packet_data..';'..get_enemy_data()

    --NPC data to the Silmaril Program via World.lua
    packet_data = packet_data..';'..get_npc_data()

    --Process the information and generate a response
    packet_data = packet_data..';action'

    --Send the built string using send_update to not log the big messages
    send_update(packet_data)
end