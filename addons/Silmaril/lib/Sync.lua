-- Called from Connection.lua
function initialize()
    -- Seed the RNG
    randomseed()

    -- Create a random delay and display (important for Mirroring)
    local delay_time = math.random(100,200)/1000
    log('Delay time is ['..delay_time..']')
    coroutine.sleep(delay_time)

    -- Make sure the player is logged in
    while not validate_load() do
        coroutine.sleep(.1)
    end

    -- Set the player in Player.lua
    set_player(windower.ffxi.get_player())

    -- Set the player's location in Player.lua
    set_player_location(windower.ffxi.get_mob_by_id(get_player().id))

    -- Set the world in World.lua
    set_world(windower.ffxi.get_info())

    -- gets the spells the player can use via Spells.lua
    get_player_spells()

    -- gets the buffs from Player.lua
    first_time_buffs()
end

function randomseed()
    --Generate your seed
    seed = os.clock()*1000
    log("Your random Seed is ["..seed.."]")
    math.randomseed(seed)
end

function validate_load()
    local toon = windower.ffxi.get_player()
    if not toon then return false end

    local pos = windower.ffxi.get_mob_by_id(toon.id)
    if not pos then return false end

    local w = windower.ffxi.get_info()
    if not w then return false end

    return true
end

function sync_data(type)
    if type == 'spells' then
        send_packet(get_all_spells()) -- Spells.lua
    elseif type == 'abilities' then
        send_packet(get_all_abilities()) -- Abilities.lua
    elseif type == 'buffs' then
        send_packet(get_all_buffs()) -- Buffs.lua
    elseif type == 'weaponskills' then
        send_packet(get_all_weaponskills()) -- Weaponskills.lua
    elseif type == 'jobs' then
        send_packet(get_all_jobs())
    elseif type == 'traits' then
        send_packet(get_all_traits())
    elseif type == 'status' then
        send_packet(get_all_status())
    elseif type == 'zones' then
        send_packet(get_all_zones())
    elseif type == 'cities' then
        send_packet(get_all_cities())
    elseif type == 'weather' then
        send_packet(get_all_weather())
    elseif type == 'day' then
        send_packet(get_all_day())
    end
    set_sync(false)
end

function get_all_jobs()
    local formattedString = get_player_name()..";jobdata_"
    local all_jobs_count = 0
    for id, job in pairs(res.jobs) do
        formattedString = formattedString..job.id..'|'..job.en..'|'..job.ens..','
        if job.id and tonumber(job.id) > tonumber(all_jobs_count) then
            all_jobs_count = job.id
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_jobs_count
    --log(formattedString)
    return formattedString
end

function get_all_traits()
    local formattedString = get_player_name()..";traitdata_"
    local all_traits_count = 0
    for id, trait in pairs(res.job_traits) do
        formattedString = formattedString..trait.id..'|'..trait.en..','
        if trait.id and tonumber(trait.id) > tonumber(all_traits_count) then
            all_traits_count = trait.id
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_traits_count
    --log(formattedString)
    return formattedString
end

function get_all_status()
    local formattedString = get_player_name()..";statusdata_"
    local all_status_count = 0
    for id, status in pairs(res.statuses) do
        formattedString = formattedString..status.id..'|'..status.en..','
        if status.id and tonumber(status.id) > tonumber(all_status_count) then
            all_status_count = status.id
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_status_count
    --log(formattedString)
    return formattedString
end

function get_all_zones()
    local formattedString = get_player_name()..";zonedata_"
    local all_zone_count = 0
    for id, zone in pairs(res.zones) do
        local can_pet = false
        if zone.can_pet then
            can_pet = true
        end
        formattedString = formattedString..zone.id..'|'..zone.en..'|'..tostring(can_pet)..','
        if zone.id and tonumber(zone.id) > tonumber(all_zone_count) then
            all_zone_count = zone.id
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_zone_count
    --log(formattedString)
    return formattedString
end

function get_all_cities()
    local formattedString = get_player_name()..";citydata_"
    local all_city_count = 0
    -- City areas for town gear and behavior.
    local Cities = {"Ru'Lude Gardens","Upper Jeuno","Lower Jeuno","Port Jeuno","Port Windurst","Windurst Waters","Windurst Woods","Windurst Walls","Heavens Tower","Port San d'Oria","Northern San d'Oria",
	"Southern San d'Oria","Chateau d'Oraguille","Port Bastok","Bastok Markets","Bastok Mines","Metalworks","Aht Urhgan Whitegate","The Colosseum","Tavnazian Safehold","Nashmau","Selbina",
	"Mhaura","Rabao","Norg","Kazham","Eastern Adoulin","Western Adoulin","Celennia Memorial Library","Mog Garden","Leafallia"}
    
    for id, city in pairs(Cities) do
        formattedString = formattedString..city..','
        all_city_count = all_city_count + 1
    end
    formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_city_count
    --log(formattedString)
    return formattedString
end

function get_all_weather()
    local formattedString = get_player_name()..";weatherdata_"
    local all_weather_count = 0
    for id, weather in pairs(res.weather) do
        formattedString = formattedString..weather.id..'|'..weather.en..'|'..res.elements[weather.element].en..'|'..tostring(weather.intensity)..','
        if weather.id and tonumber(weather.id) > tonumber(all_weather_count) then
            all_weather_count = weather.id
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_weather_count
    --log(formattedString)
    return formattedString
end

function get_all_day()
    local formattedString = get_player_name()..";daydata_"
    local all_day_count = 0
    for id, day in pairs(res.days) do
        formattedString = formattedString..day.id..'|'..day.en..'|'..res.elements[day.element].en..','
        if day.id and tonumber(day.id) > tonumber(all_day_count) then
            all_day_count = day.id
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_day_count
    --log(formattedString)
    return formattedString
end