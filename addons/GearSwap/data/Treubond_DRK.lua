
--Elendnur

-- Load and initialize the include file.
include('Mirdain-Include')
include('Global-Binds.lua')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "21"
MacroBook = "17"
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

--Uses Items Automatically
AutoItem = false

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

-- Set to true to run organizer on job changes
Organizer = false

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assign equipsets for them
state.OffenseMode:options('DT','TP','PDL','ACC','SB') -- ACC effects WS and TP modes
state.OffenseMode:set('TP')

--Weapon Modes
state.WeaponMode:options('Apocalypse','Caladbolg','Sword','Club','Great Axe')
state.WeaponMode:set('Caladbolg')

-- Initialize Player
jobsetup(LockStylePallet,MacroBook,MacroSet)

function get_sets()

	--Abilities

	--if player.sub_job == 'SAM' then
        send_command('bind ![ input /ja "Hasso" <me>')
        send_command('bind !] input /ja "Seigan" <me>')
        send_command('bind !t input /ja "Third Eye" <me>')
        send_command('bind !w input /ja "Sekkanoki" <me>')
    --end

    -- WS Binds
    send_command('bind ^numpad7 input /ws "Torcleaver" <t>')
    send_command('bind ^numpad9 input /ws "Ground Strike" <t>')
    send_command('bind ^numpad4 input /ws "Resolution" <t>')
    send_command('bind ^numpad5 input /ws "Shockwave" <t>')
    send_command('bind ^numpad6 input /ws "Steel Cyclone" <t>')
	send_command('bind ^numpad1 input /ws "Savage Blade" <t>')

	--Sets
	AF = {}
	RELIC = {}
	EMPY ={}
	
	AF.Head = ""
	AF.Body = ""
	AF.Hands = ""
	AF.Legs = ""
	AF.Feet = ""
	
	RELIC.Head = "Fall. Burgeonet +3"
	RELIC.Body = ""
	RELIC.Hands = "Fall. Fin. Gaunt. +2"
	RELIC.Legs = "Fallen's Flanchard +3"
	RELIC.Feet = ""
	
	EMPY.Head = "Heath. Burgeon. +2"
	EMPY.Body = "Heath. Cuirass +2"
	EMPY.Hands = "Heath. Gauntlets +2"
	EMPY.Legs = "Heath. Flanchard +2"
	EMPY.Feet = "Heath. Sollerets +2"


	sets.Weapons = {}

	sets.Weapons['Apocalypse'] = {
		main="Apocalypse",
		sub="Utu Grip",
	}

	sets.Weapons['Great Axe'] = {
		main="Lycurgos",
		sub="Utu Grip",
	}

	sets.Weapons['Caladbolg'] = {
		main="Caladbolg",
		sub="Utu Grip",
	}

	sets.Weapons['Sword'] = {
		main="Naegling",
		sub="Blurred Shield +1",
	}

	sets.Weapons['Club'] = {
		main={ name="Loxotic Mace +1", augments={'Path: A',}},
		sub="Blurred Shield +1",
	}

	sets.Idle = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		--waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Eabani Earring",
		--right_ear="Etiolation Earring",
		left_ring="Shneddick Ring",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
		--back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

	sets.Idle.DT = set_combine(sets.Idle, {

	})

	--Regain set
	sets.Idle.TP = set_combine(sets.Idle, {

	})
	

	sets.Movement = {
		legs="Carmine Cuisses +1",
		--legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
	}

	-- Set to be used if you get 
	sets.Cursna_Received = {
	    --neck="Nicander's Necklace",
	    --left_ring={ name="Saida Ring", bag="wardrobe1", priority=2},
		--right_ring={ name="Saida Ring", bag="wardrobe3", priority=1},
		--waist="Gishdubar Sash",
	}

	sets.OffenseMode = {}

	--Base TP set to build off
	sets.OffenseMode.TP = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
		legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
		feet="Flam. Gambieras +2",
		neck="Abyssal Beads +2",
		--neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Lehko's Ring",
		back="Null Shawl",
		--[[ ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Flam. Gambieras +2",
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Crep. Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}, ]]
	}

	sets.OffenseMode.DT = set_combine(sets.OffenseMode.TP, {
	    head="Sakpata's Helm",
		--head="Nyame Helm",
		--hands="Nyame Gauntlets",
		--legs="Nyame Flanchard",
	})
	
	--Same TP set but WSD can be altered also
	sets.OffenseMode.PDL = set_combine(sets.OffenseMode.TP, {

	})

	sets.OffenseMode.SB =  set_combine(sets.OffenseMode.TP, {

	})
	
	sets.OffenseMode.ACC = set_combine(sets.OffenseMode.TP, {

	})

	sets.DualWield = {}

	sets.Precast = {}

	-- Used for Magic Spells (Fast Cast)
	sets.Precast.FastCast = { --24
		body="Sacro Breastplate", --10
		legs={ name="Founder's Hose", augments={'MND+3','Mag. Acc.+3','Attack+7','Breath dmg. taken -1%',}},
		neck="Baetyl Pendant", --4
		left_ear="Malignance Earring", --4
		right_ear="Loquac. Earring", --2
		right_ring="Kishar Ring", --4
		--[[ ammo="Sapience Orb", --2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --14
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5','HP+44',}}, --9
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, --8
		neck="Voltsurge Torque", --4
		left_ear="Etiolation Earring", --1
		left_ring="Weather. Ring", --5 ]]
	}
		
	sets.Enmity = {}

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
	
	})

	sets.Midcast.SIRD = {}

	sets.Midcast.Enfeebling = set_combine(sets.Midcast, {
	
	})

	sets.Midcast.Enfeebling.MACC = set_combine(sets.Midcast.Enfeebling, {
	
	})

	sets.Midcast.Enfeebling.Potency = set_combine(sets.Midcast.Enfeebling, {
	
	})

	sets.Midcast.Enfeebling.Duration = set_combine(sets.Midcast.Enfeebling, {
	
	})

	sets.Midcast.Enfeebling.Drain = set_combine(sets.Midcast.Enfeebling, {
		ammo="Ghastly Tathlum +1",
		head=RELIC.Head,
		body=EMPY.Body,
		hands=RELIC.Hands,
		legs=EMPY.Legs,
		feet=EMPY.Feet,
		neck="Erra Pendant",
		waist="Eschan Stone",
		left_ear="Malignance Earring",
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Kishar Ring",
		right_ring="Archon Ring",
	})

	sets.Midcast.Enfeebling.Aspir = set_combine(sets.Midcast.Drain, {
	
	})

	sets.Midcast.Enhancing = set_combine(sets.Midcast, {
		body = EMPY.Body,		
	})

	sets.Midcast.Dark = {}

	sets.Midcast.Dark.Absorb = set_combine(sets.Midcast.Dark, {
		hands = EMPY.Hands,
	})
	
	--Job Abilities
	sets.JA = {}
	sets.JA["Berserk"] = {}
	sets.JA["Warcry"] = {}
	sets.JA["Defender"] = {}
	sets.JA["Aggressor"] = {}
	sets.JA["Provoke"] = sets.Precast.Enmity
	sets.JA["Third Eye"] = {}
	sets.JA["Meditate"] = {}
	sets.JA["Warding Circle"] = {}
	sets.JA["Hasso"] = {}
	sets.JA["Seigan"] = {}

	sets.JA["Last Resort"] = {}
	sets.JA["Dark Seal"] = {}
	sets.JA["Diaboloic Eye"] = {}
	sets.JA["Nether Void"] = {legs=EMPY.Legs,}
	sets.JA["Scarlet Delirium"] = {}
	sets.JA["Blood Weapon"] = {}
	sets.JA["Souleater"] = {}
	sets.JA["Arcane Circle"] = {}
	sets.JA["Arcane Crest"] = {}
	sets.JA["Consume Mana"] = {}
	sets.JA["Soul Enslavement"] = {}

	--WS Sets
	sets.WS = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs=RELIC.Legs,
		feet=EMPY.Feet,
		neck="Abyssal Beads +2",
		--neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear={ name="Heath. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Weapon skill damage +2%',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = set_combine(sets.WS, {

	})

	sets.WS.PDL = set_combine(sets.WS, {


	})

	sets.WS.WSD = set_combine(sets.WS, {

	})

	sets.WS.CRIT = set_combine(sets.WS, {
	
	})

	sets.WS.Multi_Hit = set_combine(sets.WS, {
	
	})
	 
-- Used to Tag TH on a mob (TH4 is max in gear non-THF)
	sets.TreasureHunter = {

	}

end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)
	
end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return equipSet
end
--Function is called when a self command is issued
function self_command_custom(command)

end
--Function is called when a lua is unloaded
function user_file_unload()
	send_command('unbind ![')
    send_command('unbind !]')
	send_command('unbind !t')
    send_command('unbind !w')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad9')
	send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
end

--Function used to automate Job Ability use
function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	if player.sub_job == 'SAM' and player.sub_job_level == 49 then
		if not buffactive['Hasso'] and not buffactive['Seigan'] and ja_recasts[138] == 0 then
			buff = "Hasso"
		elseif not buffactive['Meditate'] and ja_recasts[134] == 0 then
			buff = "Meditate"
		end
	end

	if player.sub_job == 'WAR' and player.sub_job_level == 49 then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end

	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end