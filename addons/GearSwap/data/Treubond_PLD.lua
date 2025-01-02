-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
--  ALT = !
--  CTL = ^
--  WIN = @
--  MENU = #

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
 
    include('Global-Binds.lua')

    -- Organizer
    --include('organizer-lib')
    --include('organizer-items.lua')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false

    --Your Main + Sub Weapon Sets. Add new sets here and define below (sets.Montante etc.)
    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'SakpataSword', 'Club', 'Burtgang'} --'ShiningOne', 'Montante', 'Reikiono', 'Naegling'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.ShieldSet = M{['description']='Shield Set', 'Blurred', 'Duban', 'Aegis', 'Demers', 'Thibron'}
    
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'HP')
    state.HybridMode:options('Normal', 'Hybrid') --'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    state.IdleMode:options('Normal', 'Refresh', 'HP')

    state.Phalanx = M(false, 'Phalanx')
     
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'HP', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')
     
    gear.Weard = { name="Weard Mantle", augments={'VIT+1','DEX+3','Enmity+2','Phalanx +5'}}
    gear.RudianosTP = { name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
    gear.RudianosWS = { name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}}
    gear.RudianosFC = { name="Rudianos's Mantle", augments={'HP+60','"Fast Cast"+10',}}
    gear.RudianosEnm = { name="Rudianos's Mantle", augments={'Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10',}}
    gear.Ejekamal = { name="Ejekamal Boots", augments={'Haste+2','"Snapshot"+2','"Fast Cast"+3',}}
    gear.AcroLegsFC = { name="Acro Breeches", augments={'"Fast Cast"+2'}}
     
    target_distance = 3.5 -- Set Default Distance Here --
 
    update_defense_mode()
    
    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
        send_command('bind ^numpad+ input /ja "Defender" <me>')
    end

    send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad9 input /ws "Chant du Cygne" <t>')
    send_command('bind ^numpad4 input /ws "Requiescat" <t>')
    send_command('bind ^numpad5 input /ws "Expiacion" <t>')
    send_command('bind ^numpad1 input /ws "Sanguine Blade" <t>')


    send_command('bind f10 gs c toggle Phalanx')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind @d gs c cycleback ShieldSet')
    send_command('bind @f gs c cycle ShieldSet')

    --Spells
    send_command('bind !q input /ma "Blank Gaze" <me>')
    send_command('bind !w input /ma "Cocoon" <me>')
    send_command('bind !e input /ma "Phalanx" <me>')
    

    send_command('bind ^f9 gs c cycle HybridMode')
    send_command('bind ^f11 gs c cycle OffenseMode')
    send_command('bind !f11 gs c cycle IdleMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')
    send_command('bind @f12 gs c cycle CastingMode')
    send_command('pld')
 
    select_default_macro_book()
end
 
function user_unload()
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')
    send_command('unbind f10')
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
    send_command('unbind @f12')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind @d')
    send_command('unbind @f')
    send_command('unbind !q')
	send_command('unbind !w')
	send_command('unbind !e')
	send_command('unbind !r')
	send_command('unbind !t')
	send_command('unbind !y')
	send_command('unbind !u')
    send_command('gs enable all')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    AF = {}
	RELIC = {}
	EMPY ={}
	
	AF.Head = ""
	AF.Body = ""
	AF.Hands = ""
	AF.Legs = ""
	AF.Feet = ""
	
	RELIC.Head = ""
	RELIC.Body = ""
	RELIC.Hands = ""
	RELIC.Legs = ""
	RELIC.Feet = ""
	
	EMPY.Head = "Chev. Armet +2"
	EMPY.Body = "Chev. Cuirass +2"
	EMPY.Hands = "Chev. Gauntlets +1"
	EMPY.Legs = "Chev. Cuisses +2"
	EMPY.Feet = "Chev. Sabatons +1"



    --------------------------------------
    -- Precast sets
    --------------------------------------
     
    -- Fast cast sets for spells
     
    sets.precast.FC = {
        ammo="Staunch Tathlum",
        head=EMPY.Head,
        body=EMPY.Body,
        hands=EMPY.Hands,
        legs="Carmine Cuisses +1",
        feet=EMPY.Feet,
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Loquac. Earring",
        right_ear="Magnetic Earring",
        left_ring="Defending Ring",
        right_ring="Odium Ring",
        back="Solemnity Cape",
        --[[ ammo="Impatiens",
        head="Chevalier's Armet",neck="Voltsurge Torque",ear1="Loquac. Earring",ear2="Enchanter Earring +1",
        body="Reverence Surcoat +2",hands="Buremte Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
        back=gear.RudianosFC,legs=gear.AcroLegsFC,feet=gear.Ejekamal ]]}
 
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
     
    --Enmity
 
    sets.precast.Enmity = {
        ammo="Staunch Tathlum",
        head=EMPY.Head,
        body=EMPY.Body,
        hands="Sulev. Gauntlets +2",
        legs="Vlr. Breeches +1",
        feet=EMPY.Feet,
        neck="Unmoving Collar +1",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cryptic Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Defending Ring",
        right_ring="Odium Ring",
        back="Atheling Mantle",
        --[[ ammo="Paeapua",
        head="Caballarius Coronet +1",neck="Unmoving Collar +1",ear2="Friomisi Earring",
        body="Reverence Surcoat +2",hands="Caballarius Gauntlets +1",ring1="Supershear Ring",ring2="Provocare Ring",
        back=gear.RudianosEnm,waist="Creed Baudrier",legs="Caballarius Breeches +1",feet="Caballarius Leggings +1" ]]}
 
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.precast.Enmity, {--[[ legs="Caballarius Breeches +1" ]]})
    sets.precast.JA['Holy Circle'] = set_combine(sets.precast.Enmity, {--[[ feet="Reverence Leggings +1" ]]})
    sets.precast.JA['Shield Bash'] = set_combine(sets.precast.Enmity, {--[[ hands="Caballarius Gauntlets +1", ear2="Knightly Earring" ]]})
    sets.precast.JA['Sentinel'] = set_combine(sets.precast.Enmity, {--[[ feet="Caballarius Leggings +1" ]]})
    sets.precast.JA['Rampart'] = set_combine(sets.precast.Enmity, {--[[ head="Caballarius Coronet +1" ]]})
    sets.precast.JA['Fealty'] = set_combine(sets.precast.Enmity, {--[[ body="Caballarius Surcoat +1" ]]})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.precast.Enmity, {--[[ feet="Chevalier's Sabatons" ]]})
    sets.precast.JA['Sepulcher'] = sets.precast.Enmity
    sets.precast.JA['Palisade'] = sets.precast.Enmity
    sets.precast.JA['Cover'] = set_combine(sets.precast.Enmity, {--[[ head="Reverence Coronet +1" ]]})
 
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        --[[ head="Reverence Coronet +1",ear2="Lifestorm Earring",
        body="Caballarius Surcoat +1",hands="Caballarius Gauntlets +1",ring1="Perception Ring",ring2="Solemn Ring",
        back=gear.RudianosEnm,
        legs="Caballarius Breeches +1",feet="Caballarius Leggings +1" ]]}
     
    -- /WAR
    sets.precast.JA['Provoke'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Berserk'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Warcry'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Aggressor'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Defender'] = set_combine(sets.precast.Enmity, {})
     
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        --[[ head="Sulevia's Mask +2",
        body="Sulevia's Platemail +2",hands="Sulevia's Gauntlets +2",
        waist="Caudata Belt",legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2" ]]}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
     
    sets.precast.Step = {
        
        --[[ ammo="Hasty Pinion +1",
        head="Flamma Zucchetto +1",neck="Ziel Charm",ear1="Steelflash Earring",ear2="Heartseeker Earring",
        body="Flamma Korazin +1",hands="Flamma Manopolas +1",ring1="Enlivened Ring",ring2="Patricius Ring",
        back=gear.RudianosTP,waist="Anguinus Belt",legs="Flamma Dirs +1",feet="Flamma Gambieras +1" ]]}
         
    sets.precast.Flourish1 = {
        
        --[[ ammo="Plumose Sachet",
        head="Flamma Zucchetto +1",neck="Voltsurge Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Flamma Korazin +1",hands="Flamma Manopolas +1",ring1="Perception Ring",ring2="Sangoma Ring",
        back=gear.RudianosTP,waist="Anguinus Belt",legs="Flamma Dirs +1",feet="Flamma Gambieras +1" ]]}
 
   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
     
    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Odyssean Gauntlets", augments={'Weapon skill damage +3%','Mag. Acc.+6','Mag. Acc.+9 "Mag.Atk.Bns."+9',}}, --5 WSD
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Rep. Plat. Medal",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Regal Ring",
        right_ring="Lehko's Ring",
        back="Solemnity Cape",
        --[[ ammo="Hasty Pinion +1",
        head="Flamma Zucchetto +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Acro Surcoat",hands="Sulevia's Gauntlets +2",ring1="Rajas Ring",ring2="Ifrit Ring",
        back=gear.RudianosWS,waist="Fotia Belt",legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2" ]]}
 
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        
        --[[ ammo="Hasty Pinion +1",
        head="Flamma Zucchetto +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Heartseeker Earring",
        body="Flamma Korazin +1",hands="Flamma Manopolas +1",ring1="Enlivened Ring",ring2="Patricius Ring",
        back=gear.RudianosWS,waist="Anguinus Belt",legs="Flamma Dirs +1",feet="Flamma Gambieras +1" ]]})
 
     
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {--[[ ring2="Solemn Ring", ]]})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {--[[ waist="Fotia Belt" ]]})
     
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {--[[ hands="Flamma Manopolas +1",waist="Windbuffet Belt +1" ]]})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {--[[ hands="Flamma Manopolas +1" ]]})
 
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        
        --[[ ammo="Plumose Sachet",
        head="Flamma Zucchetto +1",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Flamma Korazin +1",hands="Flamma Manopolas +1",ring1="Shiva Ring",ring2="Acumen Ring",
        back=gear.RudianosWS,waist="Fotia Belt",legs="Flamma Dirs +1",feet="Sulevia's Leggings +2" ]]})
     
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'], {--[[ head="Chimera Hairpin" ]]})
     
    sets.precast.WS['Atonement'] = set_combine(sets.precast.WS, {
        
        --[[ ammo="Paeapua",
        head="Caballarius Coronet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Acro Surcoat",hands="Caballarius Gauntlets +1",ring1="Supershear Ring",ring2="Provocare Ring",
        back=gear.RudianosWS,waist="Fotia Belt",legs="Caballarius Breeches +1",feet="Sulevia's Leggings +2" ]]})
         
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        
        --[[ ammo="Hasty Pinion +1",
        head="Sulevia's Mask +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Acro Surcoat",hands="Sulevia's Gauntlets +2",ring1="Rajas Ring",ring2="Ifrit Ring",
        back=gear.RudianosWS,waist="Fotia Belt",legs="Caballarius Breeches +1",feet="Sulevia's Leggings +2" ]]})    
     
    sets.precast.WS['Circle Blade'] = set_combine(sets.precast.WS, {
        
        --[[ ammo="Hasty Pinion +1",
        head="Sulevia's Mask +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Acro Surcoat",hands="Sulevia's Gauntlets +2",ring1="Rajas Ring",ring2="Ifrit Ring",
        back=gear.RudianosWS,waist="Caudata Belt",legs="Caballarius Breeches +1",feet="Sulevia's Leggings +2" ]]})
         
         
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    sets.Phalanx = {
        main="Sakpata's Sword",
        body={ name="Odyss. Chestplate", augments={'DEX+7','CHR+15','Phalanx +4','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
        hands="Souv. Handsch. +1",
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
        feet="Souveran Schuhs +1",
        back={ name="Weard Mantle", augments={'VIT+4','DEX+1','Enmity+5','Phalanx +5',}},
    }

    sets.midcast.FastRecast = {
        
        --[[ ammo="Incantor Stone",
        head="Chevalier's Armet",neck="Voltsurge Torque",ear1="Loquac. Earring",ear2="Enchanter Earring +1",
        body="Reverence Surcoat +2",hands="Buremte Gloves",ring2="Prolix Ring",
        back=gear.RudianosFC,waist="Tempus Fugit",feet=gear.Ejekamal ]]}
         
    sets.midcast.Enmity = set_combine(sets.precast.Enmity, {})
     
    sets.midcast.SIRD = { -- 93
        ammo="Staunch Tathlum", --10
        head="Souv. Schaller +1", --20
        body=EMPY.Body, --15
        legs="Carmine Cuisses +1", -- 20
        neck="Moonbeam Necklace", -- 10
        waist="Rumination Sash", -- 10
        right_ear="Magnetic Earring", -- 8
        --[[ ammo="Staunch Tathlum", ear2="Knightly Earring",
        waist="Resolute Belt", legs="Carmine Cuisses +1" ]]}
 
    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {--[[ neck="Nesanica Torque" ]]})
    sets.midcast.Flash.SIRD = set_combine(sets.midcast.Flash, sets.midcast.SIRD)
     
    sets.midcast.Stun = set_combine(sets.midcast.Enmity, {})
    sets.midcast.Stun.SIRD = set_combine(sets.midcast.Stun, sets.midcast.SIRD)
     
    sets.midcast.Cure = {
        right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
        neck="Sacro Gorget",
        back="Solemnity Cape",
        --[[ ear1="Oneiros Earring",ear2="Nourishing Earring +1",
        hands="Buremte Gloves",ring1="Vocane Ring +1",ring2="Kunaji Ring",
        waist="Chuq'aba Belt",legs="Flamma Dirs +1" ]]}
    sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, sets.midcast.SIRD)
 
    sets.midcast['Blue Magic'] = set_combine(sets.midcast.Enmity, {})
    sets.midcast['Blue Magic'].SIRD = set_combine(sets.midcast['Blue Magic'], sets.midcast.SIRD)
    sets.midcast['Blue Magic']['Wild Carrot'] = set_combine(sets.midcast.Enmity, sets.midcast.Cure)
    sets.midcast['Blue Magic']['Wild Carrot'].SIRD = set_combine(sets.midcast['Blue Magic']['Wild Carrot'], sets.midcast.SIRD)
     
    sets.midcast['Enhancing Magic'] = {--[[ legs="Reverence Breeches +1" ]]}
    sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.SIRD)
     
    sets.midcast.Protect = {--[[ ring1="Sheltered Ring" ]]}
    sets.midcast.Protect.SIRD = set_combine(sets.midcast.Protect, sets.midcast.SIRD)
    sets.midcast.Shell = {--[[ ring1="Sheltered Ring" ]]}
    sets.midcast.Shell.SIRD = set_combine(sets.midcast.Shell, sets.midcast.SIRD)
     
    sets.midcast.Phalanx = set_combine(sets.midcast.SIRD, sets.Phalanx)

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    sets.Reraise = {--[[ head="Twilight Helm", body="Twilight Mail" ]]}
     
    sets.resting = {
        
        --[[ ammo="Homiliary",
        head="Wivre Hairpin",neck="Creed Collar",
        body="Twilight Mail",ring1="Sheltered Ring",ring2="Paguroidea Ring" ]]}
     
 
    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum",
        head=EMPY.Head,
        body=EMPY.Body,
        hands=EMPY.Hands,
        legs=EMPY.Legs,
        feet=EMPY.Feet,
        neck={ name="Loricate Torque +1", augments={'Path: A',}},
        waist="Flume Belt",
        left_ear="Odnowa Earring +1",
        right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
        back="Solemnity Cape",
        --[[ ammo="Staunch Tathlum",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1="Flashward Earring",ear2="Hearty Earring",
        body="Reverence Surcoat +2",hands="Sulevia's Gauntlets +2",ring1="Vocane Ring +1",ring2="Defending Ring",
        back=gear.Weard,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Sulevia's Leggings +2" ]]}
 
    sets.idle.Refresh = set_combine(sets.idle, {
        
        --[[ ammo="Homiliary",
        head="Wivre Hairpin",neck="Creed Collar",
        body="Twilight Mail",ring1="Sheltered Ring",ring2="Paguroidea Ring" ]]})
 
    sets.idle.Town = set_combine(sets.idle, {
        
        --[[ ammo="Staunch Tathlum",
        head="Flamma Zucchetto +1",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Flamma Korazin +1",hands="Flamma Manopolas +1",ring1="Vocane Ring +1",ring2="Defending Ring",
        back=gear.RudianosTP,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Flamma Gambieras +1" ]]})
     
    sets.idle.Weak = set_combine(sets.idle,{back=gear.RudianosEnm,legs="Sulevia's Cuisses +2"})
     
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)

    sets.idle.HP = {
        ammo="Staunch Tathlum",
        head="Souv. Schaller +1",
        body="Sacro Breastplate",
        hands="Souv. Handsch. +1",
        legs="Chev. Cuisses +2",
        feet="Souveran Schuhs +1",
        neck="Sacro Gorget",
        waist="Plat. Mog. Belt",
        left_ear="Eabani Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Regal Ring",
        right_ring="Meridian Ring",
        back={ name="Weard Mantle", augments={'VIT+4','DEX+1','Enmity+5','Phalanx +5',}},
    }
     
    sets.Kiting = {--[[ legs="Carmine Cuisses +1" ]]}
 
    sets.latent_refresh = {--[[ waist="Fucho-no-obi" ]]}

 

    --------------------------------------
    -- Defense sets
    --------------------------------------
     
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {--[[ ring1="Vocane Ring +1",back="Repulse Mantle" ]]}
    sets.HP = {}
    sets.MP = {--[[ ammo="Homiliary",neck="Creed Collar",]]waist="Flume Belt", } --Chev. Armet +1
    sets.MP_Knockback = set_combine(sets.MP, sets.Knockback)
     
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {--[[ main={ name="Claidheamh Soluis", augments={'Accuracy+15','"Dbl.Atk."+3','DMG:+19',}},sub="Ochain" ]]}
    sets.MagicalShield = {--[[ main={ name="Claidheamh Soluis", augments={'Accuracy+15','"Dbl.Atk."+3','DMG:+19',}}, ]]sub="Aegis"}
 
   
    -- Basic defense sets.
         
    sets.defense.PDT = {
        ammo="Staunch Tathlum", --2
        head=EMPY.Head,
        body="Sulevia's Plate. +2",
        hands="Sulev. Gauntlets +2",
        legs=EMPY.Legs,
        feet="Sulev. Leggings +2",
        neck={ name="Loricate Torque +1", augments={'Path: A',}}, --6
        waist="Flume Belt",
        left_ear="Cessance Earring",
        right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
        left_ring="Defending Ring", --10
        right_ring="Sulevia's Ring",
        back="Solemnity Cape",
        --[[ ammo="Staunch Tathlum",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1="Impregnable Earring",ear2="Creed Earring",
        body="Reverence Surcoat +2",hands="Sulevia's Gauntlets +2",ring1="Vocane Ring +1",ring2="Defending Ring",
        back=gear.RudianosTP,waist="Tempus Fugit",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +1" ]]}
    sets.defense.HP = {
        ammo="Staunch Tathlum",
        head="Souv. Schaller +1",
        body="Sacro Breastplate",
        hands="Souv. Handsch. +1",
        legs="Chev. Cuisses +2",
        feet="Souveran Schuhs +1",
        neck="Sacro Gorget",
        waist="Plat. Mog. Belt",
        left_ear="Eabani Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Regal Ring",
        right_ring="Meridian Ring",
        back={ name="Weard Mantle", augments={'VIT+4','DEX+1','Enmity+5','Phalanx +5',}},
        --[[ ammo="Plumose Sachet",
        head="Caballarius Coronet +1",neck="Twilight Torque",ear1="Oneiros Earring",ear2="Creed Earring",
        body="Reverence Surcoat +2",hands="Caballarius Gauntlets +1",ring1="Vocane Ring +1",ring2="Defending Ring",
        back=gear.Weard,
        waist="Creed Baudrier",legs="Reverence Breeches +1",feet="Reverence Leggings +1" ]]}
    sets.defense.Reraise = {
        
        --[[ ammo="Staunch Tathlum",
        head="Twilight Helm",neck="Twilight Torque",ear1="Oneiros Earring",ear2="Creed Earring",
        body="Twilight Mail",hands="Sulevia's Gauntlets +2",ring1="Vocane Ring +1",ring2="Defending Ring",
        back=gear.Weard,
        waist="Nierenschutz",legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2" ]]}
    sets.defense.Charm = {
        
        --[[ ammo="Homiliary",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1="Oneiros Earring",ear2="Creed Earring",
        body="Sulevia's Platemail +2",hands="Sulevia's Gauntlets +2",ring1="Vocane Ring +1",ring2="Defending Ring",
        back=gear.Weard,
        waist="Flume Belt",legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2" ]]}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {
        ammo="Staunch Tathlum",
        head=EMPY.Head,
        body="Sulevia's Plate. +2",
        hands="Sulev. Gauntlets +2",
        legs=EMPY.Legs,
        feet="Sulev. Leggings +2",
        neck={ name="Loricate Torque +1", augments={'Path: A',}},
        waist="Flume Belt",
        left_ear="Cessance Earring",
        right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
        left_ring="Defending Ring",
        right_ring="Sulevia's Ring",
        back="Solemnity Cape",
        --[[ ammo="Staunch Tathlum",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1={name="Merman's Earring",bag="wardrobe"},ear2={name="Merman's Earring",bag="wardrobe2"},
        body="Reverence Surcoat +2",hands="Flamma Manopolas +1",ring1="Vocane Ring +1",ring2="Defending Ring",
        back=gear.RudianosEnm,waist="Creed Baudrier",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +1" ]]}
 
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
     
    sets.engaged = {
        ammo="Ginsen",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
        feet="Sakpata's Leggings",
        neck="Asperity Necklace",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Telos Earring",
        left_ring="Chirich Ring +1",
        right_ring="Lehko's Ring",
        back="Solemnity Cape",
    }
 
    sets.engaged.Acc = {
    }
 
    sets.engaged.DW = set_combine(sets.engaged, {--[[ ear1="Suppanomimi",ear2="Brutal Earring",legs="Carmine Cuisses +1" ]]})
 
    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {--[[ ear1="Dudgeon Earring",ear2="Heartseeker Earring" ]]})
 
    sets.engaged.PDT = {
        ammo="Staunch Tathlum",
        head=EMPY.Head,
        body="Sulevia's Plate. +2",
        hands="Sulev. Gauntlets +2",
        legs=EMPY.Legs,
        feet="Sulev. Leggings +2",
        neck={ name="Loricate Torque +1", augments={'Path: A',}},
        waist="Flume Belt",
        left_ear="Cessance Earring",
        right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
        left_ring="Defending Ring",
        right_ring="Sulevia's Ring",
        back="Solemnity Cape",
        --[[ ammo="Paeapua",
        head="Sulevia's Mask +2",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Reverence Surcoat +2",hands="Sulevia's Gauntlets +2",ring1="Vocane Ring +1",ring2="Defending Ring",
        back=gear.RudianosTP,waist="Tempus Fugit",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +1" ]]}

    sets.engaged.HP = {
        ammo="Staunch Tathlum",
        head="Souv. Schaller +1",
        body="Sacro Breastplate",
        hands="Souv. Handsch. +1",
        legs="Chev. Cuisses +2",
        feet="Souveran Schuhs +1",
        neck="Sacro Gorget",
        waist="Plat. Mog. Belt",
        left_ear="Eabani Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Regal Ring",
        right_ring="Meridian Ring",
        back={ name="Weard Mantle", augments={'VIT+4','DEX+1','Enmity+5','Phalanx +5',}},
    }
     
    sets.engaged.Acc.PDT = sets.engaged.PDT
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)
 
    sets.engaged.DW.PDT = set_combine(sets.engaged.PDT, {--[[ ear1="Suppanomimi",ear2="Brutal Earring" ]]})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.PDT, {--[[ ear1="Dudgeon Earring",ear2="Heartseeker Earring" ]]})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)
 
 
    sets.Burtgang       = {main="Burtgang"}
    sets.Naegling 	    = {main="Naegling"--[[ , sub="Blurred Shield +1" ]]}	
    sets.SakpataSword   = {main="Sakpata's Sword"--[[ , sub="Aegis" ]]}
    --sets.ShiningOne      = {main="Shining One", sub="Alber Strap"}
    sets.Club           = {main="Beryllium Mace"--[[ , sub="Blurred Shield +1" ]]}

    sets.Duban          = {sub="Duban"}
    sets.Aegis          = {sub="Aegis"}
    sets.Blurred        = {sub="Blurred Shield +1"}
    sets.Demers         = {sub="Demers. Degen +1"}
    sets.Thibron        = {sub="Thibron"}

    -------------------------------------------------------------------------------------------------------------------
    -- Hybrid Sets
    -------------------------------------------------------------------------------------------------------------------    

	sets.Hybrid = set_combine(sets.engaged, { -- 50
        ammo="Ginsen",
        head="Sakpata's Helm", -- 7
        body="Sakpata's Plate", -- 10
        hands={ name="Sakpata's Gauntlets", augments={'Path: A',}}, -- 8
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}}, -- 9
        feet="Sakpata's Leggings", -- 6
        neck={ name="Loricate Torque +1", augments={'Path: A',}}, -- 6
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear={ name="Chev. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+8','Mag. Acc.+8',}},
        left_ring="Chirich Ring +1",
        right_ring="Lehko's Ring",
        back="Solemnity Cape", -- 4
    })
    --[[ sets.Hybrid.MidAcc = set_combine(sets.engaged, { })
    sets.Hybrid.FullAcc = set_combine(sets.engaged, { }) ]]

    sets.engaged.Hybrid = sets.Hybrid
    --[[ sets.engaged.MidAcc.Hybrid = sets.Hybrid.MidAcc
    sets.engaged.FullAcc.Hybrid = sets.Hybrid.FullAcc ]]


    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
    sets.buff.Doom = {--[[ ring1="Saida Ring" ]]}
    sets.buff.Cover = {--[[ head="Reverence Coronet +1", body="Caballarius Surcoat +1" ]]}
 
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" and player.status == 'Engaged' and spell.target.distance > target_distance then -- Cancel WS If You Are Out Of Range --
       eventArgs.cancel=true
       add_to_chat(123, spell.name..' Canceled: [Out of Range]')
       return
    end
end
 
 
function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's state changes (e.g. Normal to Acc Engaged mode).
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end
 
    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
     
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
    check_weaponset()
    check_shieldset()
end
 
-- Called when status changes (Idle to Engaged, Resting, etc.)
function job_status_change(newStatus, oldStatus, eventArgs)
    update_defense_mode()
    check_weaponset()
    check_shieldset()
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if world.area:contains('Adoulin') then
        idleSet = set_combine(idleSet, {body="Councilor's Garb"})
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    check_weaponset()
    check_shieldset()
     
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    check_weaponset()
    check_shieldset()

    return meleeSet
end
 
function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
     
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
     
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
     
    return defenseSet
end
 
 
function display_current_job_state(eventArgs)
    local msg = 'Melee'
     
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
     
    msg = msg .. ': '
     
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
     
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
 
    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
     
    msg = msg .. ', Casting: ' .. state.CastingMode.value
     
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
     
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end
 
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
 
    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
 
    add_to_chat(122, msg)
 
    eventArgs.handled = true
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'tds' then
        local newTargetDistance = tonumber(cmdParams[2])
        if not newTargetDistance then
            add_to_chat(123, '[Invalid parameter. Example syntax: gs c tds 5.5]')
            return
        end
        if newTargetDistance > 0 then
            target_distance = newTargetDistance
            add_to_chat(122, '[Weaponskill max range set to '..newTargetDistance..' yalms.]')
        else
            add_to_chat(123, '[Invalid parameter. Example syntax: gs c tds 5.5]')
        end
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function update_defense_mode()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end
 
function check_weaponset()
    equip(sets[state.WeaponSet.current])
end

function check_shieldset()
    equip(sets[state.ShieldSet.current])
end

 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(6, 9)
    elseif player.sub_job == 'SAM' then
        set_macro_page(7, 9)
    elseif player.sub_job == 'RNG' then
        set_macro_page(8, 9)
    elseif player.sub_job == 'PLD' then
        set_macro_page(9, 9)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'SCH' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'BLU' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'DRK' then
        set_macro_page(5, 9)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 9)
    else
        set_macro_page(1, 9)  --BRD
    end
end

------------------------------------------
-- Style Change on Job Change
------------------------------------------
function set_style(sheet)
    send_command('@input ;wait 11.0;input /lockstyleset '..sheet)
	add_to_chat (21, 'Your lockstyle looks like shit, and you should feel bad')
	add_to_chat (55, 'You are on '..('PLD '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
--	add_to_chat (60, 'Eat tendies in moderation')
end

--Use the Lockstyle Number-- 
set_style(12) 