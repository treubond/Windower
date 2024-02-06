-------------------------------------------------------------------------------------------------------------------
-- WAR Lua by Rejected
-- Thanks for all the hard work by Motenten and Arislan. 
-- This Lua is my own combination of their work and various custom functions.
-- Movement Detection Requires Gearinfo Addon
--
--
-- TODO:
-- Roll Tracking (Fighter's and SAM Roll)
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  ALT = !
--  CTL = ^
--  WIN = @
--  MENU = #

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+T ]           Cycle Treasure Hunter Mode
--              [ WIN+E ]           Cycle Weapon Set Back
--              [ WIN+R ]           Cycle Weapon Set Forward
--              [ WIN+W ]           Toggle Weapon Lock
--				[ WIN+P ]			Toggle Pause Mode (Turns off automatic gear swaps for testing, using equip sets.whatever, etc.)

-------------------------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
-------------------------------------------------------------------------------------------------------------------

-- Gear Include File (Not required.)
-- include('Rejected-gear.lua') 

function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end

------------------------------------------------------------------------------------------------------------------- 
-- Setup vars that are user-independent.
-------------------------------------------------------------------------------------------------------------------

function job_setup()	
	--Your Main + Sub Weapon Sets. Add new sets here and define below (sets.Montante etc.)
    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Lycurgos', 'KajaLance', 'Club'} --'Montante', 'Reikiono', 'Naegling'}
    state.WeaponLock = M(false, 'Weapon Lock')
    
	--CP Mode
	state.CP = M(false, "Capacity Points Mode")
	
	--Pause Mode 
	state.Pause = M(false, "Pause Mode")

	--Buffs we have gearsets for
    state.Buff.Berserk = buffactive.berserk or false
    state.Buff.Retaliation = buffactive.retaliation or false
	
	--Weaponskills we DO NOT want Gavialis Helm with
    wsList = S{'Savage Blade', 'Impulse Drive', 'Torcleaver', 'Upheaval'}
    
	--Gear we DO NOT want automatically taken off (currently only supports commonly used rings, can use pause mode for all other slots)
	no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)", "Trizek Ring", "Endorsement Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Emporox's Ring"}

    --TH Rules
	include('Mote-TreasureHunter')

	--Your Lockstyle Set Number
    lockstyleset = 13
end
 
------------------------------------------------------------------------------------------------------------------- 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'MidAcc', 'FullAcc')
    state.WeaponskillMode:options('Normal', 'MidAcc', 'FullAcc')
    state.HybridMode:options('Normal', 'Hybrid')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Regen', 'Weak')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    --Auto Kite (Auto Move Speed Gear)
	state.Auto_Kite = M(false, 'Auto_Kite')   
	moving = false
    
	-- Additional Local Binds
    send_command('bind @t gs c cycle treasuremode')
    send_command('bind @w gs c toggle WeaponLock')
    --send_command('bind @c gs c toggle CP')  
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
	send_command('bind @p gs c toggle Pause')
    send_command('bind f9 gs c cycle OffenseMode')
    send_command('bind ^f9 gs c cycle HybridMode')

    -- Ability Binds
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
    send_command('bind ^d input /ja "Warrior\'s Charge" <me>')
    send_command('bind @c input /ja "Retaliation" <me>')

    if player.sub_job == 'SAM' then
        send_command('bind ![ input /ja "Hasso" <me>')
        send_command('bind !] input /ja "Seigan" <me>')
        send_command('bind !t input /ja "Third Eye" <me>')
        send_command('bind !w input /ja "Sekkanoki" <me>')
    end

    -- WS Binds
    send_command('bind ^numpad7 input /ws "Upheaval" <t>')
    send_command('bind ^numpad9 input /ws "King\'s Justice" <t>')
    send_command('bind ^numpad4 input /ws "Ukko\'s Fury" <t>')
    send_command('bind ^numpad6 input /ws "Steel Cyclone" <t>')
	send_command('bind ^numpad1 input /ws "Savage Blade" <t>')
	
	--Macro Book and Lockstyle
    select_default_macro_book()
    set_lockstyle()
end

-------------------------------------------------------------------------------------------------------------------
-- Called when this job file is unloaded (eg: job change)
-------------------------------------------------------------------------------------------------------------------

function file_unload()
    send_command('unbind @t')
    send_command('unbind @w')
    send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')
	send_command('unbind @p')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
	send_command('unbind ^numpad-')
    send_command('unbind ^d')
    --send_command('unbind ^c')
    send_command('unbind ![')
    send_command('unbind !]')
	send_command('unbind !t')
    send_command('unbind !w')
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad9')
	send_command('unbind ^numpad4')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
end

-------------------------------------------------------------------------------------------------------------------
-- Define sets and vars used by this job file.
-------------------------------------------------------------------------------------------------------------------

function init_gear_sets()
    sets.WSDayBonus      					= { --[[ head = "Gavialis Helm" ]] }
    sets.TreasureHunter 					= { ammo = "Per. Lucky Egg", --[[ waist = "Chaac Belt" ]] }
    sets.reive 								= { neck = "Ygnas's Resolve +1"}
    sets.Organizer 							= { }

-------------------------------------------------------------------------------------------------------------------
-- Precast Sets
-------------------------------------------------------------------------------------------------------------------

	-- Job Abilities
    sets.precast.JA['Berserk']              = { body="Pumm. Lorica +3",}
    sets.precast.JA['Retaliation'] 			= { --[[ hands = WARAF.Hands, ]] feet = "Boii Calligae +2" }
    sets.precast.JA['Restraint'] 			= { hands = "Boii Mufflers +3", }
    sets.precast.JA['Warcry'] 				= { head = "Agoge Mask +2" }
--[[     sets.precast.JA['Blood Rage'] 			= { body = WAREmpy.Body }
    sets.precast.JA['Provoke'] 				= set_combine(sets.TreasureHunter, { hands = WARAF.Hands })
    sets.precast.JA['Berserk'] 				= { body = WARAF.Body, hands = WARRelic.Hands, back = Cichols.TP, feet = WARRelic.Feet}
    sets.precast.JA['Warcry'] 				= { head = WARRelic.Head }
    sets.precast.JA['Mighty Strikes'] 		= { head = WARRelic.Head }
    sets.precast.JA['Retaliation'] 			= { hands = WARAF.Hands, feet = WAREmpy.Feet }
    sets.precast.JA['Aggressor'] 			= { head = WARAF.Head, body = WARRelic.Body }
    sets.precast.JA['Restraint'] 			= { hands = WAREmpy.Hands }
    sets.precast.JA['Warrior\'s Charge'] 	= { legs = WARRelic.Legs }
	sets.precast.JA['Tomahawk']				= { ammo = "Thr. Tomahawk", legs = WARRelic.Legs } ]]

    -- Waltz (CHR and VIT)
    sets.precast.Waltz = { }
 
	-- Fast Cast
    sets.precast.FC = { }
	
	-- Utsusemi 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { --[[ neck="Magoraga Beads" ]] })

    -- Ranged Attacks
	sets.precast.RA = { }

-------------------------------------------------------------------------------------------------------------------	
-- Midcast Sets
-------------------------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = { }
   
    -- Utsusemi
    sets.midcast.Utsusemi = { }

    -- Ranged Attacks
    sets.midcast.RA = { }

-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets
-------------------------------------------------------------------------------------------------------------------

    -- General Set
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Agoge Mask +2",
        body="Pumm. Lorica +3",
        hands="Boii Mufflers +3",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Sulev. Leggings +2",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Rajas Ring",
        --left_ring="Sroda Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
    sets.precast.WS.MidAcc = set_combine(sets.precast.WS, { })
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS.MidAcc, { })
	
	--Great Sword	
    sets.precast.WS['Resolution'] = { }
    sets.precast.WS['Resolution'].MidAcc = set_combine(sets.precast.WS['Resolution'], { })
    sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'].MidAcc, { })

    sets.precast.WS['Shockwave'] = { }
    sets.precast.WS['Shockwave'].MidAcc = set_combine(sets.precast.WS['Resolution'], { })
    sets.precast.WS['Shockwave'].FullAcc = set_combine(sets.precast.WS['Resolution'].MidAcc, { })

    
	--Great Axe
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, { })  -- VIT 73%+
    sets.precast.WS['Upheaval'].MidAcc = set_combine(sets.precast.WS['Upheaval'], { })
    sets.precast.WS['Upheaval'].FullAcc = set_combine(sets.precast.WS['Upheaval'].MidAcc, { })
	
    sets.precast.WS['Ukko\'s Fury'] = set_combine(sets.precast.WS, { })  -- STR 80%
    sets.precast.WS['Ukko\'s Fury'].MidAcc = set_combine(sets.precast.WS['Ukko\'s Fury'], { })
    sets.precast.WS['Ukko\'s Fury'].FullAcc = set_combine(sets.precast.WS['Ukko\'s Fury'].MidAcc, { })

    sets.precast.WS['King\'s Justice'] = set_combine(sets.precast.WS, { })  -- STR 50%
    sets.precast.WS['King\'s Justice'].MidAcc = set_combine(sets.precast.WS['King\'s Justice'], { })
    sets.precast.WS['King\'s Justice'].FullAcc = set_combine(sets.precast.WS['King\'s Justice'].MidAcc, { })

	--Polearm
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, { })  -- STR 73%+
    sets.precast.WS['Stardiver'].MidAcc = set_combine(sets.precast.WS['Stardiver'], { })
    sets.precast.WS['Stardiver'].FullAcc = set_combine(sets.precast.WS['Stardiver'].MidAcc, { })
	
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, { })  -- STR 100%
    sets.precast.WS['Impulse Drive'].MidAcc = set_combine(sets.precast.WS['Impulse Drive'], { })
    sets.precast.WS['Impulse Drive'].FullAcc = set_combine(sets.precast.WS['Impulse Drive'].MidAcc, { })
	
	--Sword
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, { })  -- STR 50% MND 50%
    sets.precast.WS['Savage Blade'].MidAcc = set_combine(sets.precast.WS['Savage Blade'], { })
    sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].MidAcc, { })
	
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, { })  -- STR 30% MND 50%
    sets.precast.WS['Sanguine Blade'].MidAcc = set_combine(sets.precast.WS['Sanguine Blade'], { })
    sets.precast.WS['Sanguine Blade'].FullAcc = set_combine(sets.precast.WS['Sanguine Blade'].MidAcc, { })

    sets.precast.WS['Requiscat'] = set_combine(sets.precast.WS, { })  -- MND 73%+
    sets.precast.WS['Requiscat'].MidAcc = set_combine(sets.precast.WS['Requiscat'], { })
    sets.precast.WS['Requiscat'].FullAcc = set_combine(sets.precast.WS['Requiscat'].MidAcc, { })

	--Axe
    sets.precast.WS['Decimation'] = set_combine(sets.precast.WS, { })
    sets.precast.WS['Decimation'].MidAcc = set_combine(sets.precast.WS['Decimation'], { })
    sets.precast.WS['Decimation'].FullAcc = set_combine(sets.precast.WS['Decimation'].MidAcc, { })

    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS, { })
    sets.precast.WS['Cloudsplitter'].MidAcc = set_combine(sets.precast.WS['Cloudsplitter'], { })
    sets.precast.WS['Cloudsplitter'].FullAcc = set_combine(sets.precast.WS['Cloudsplitter'].MidAcc, { })

------------------------------------------------------------------------------------------------------------------- 
-- Idle sets
-------------------------------------------------------------------------------------------------------------------

    sets.idle.Town = {
        head="Boii Mask +3",
        body="Boii Lorica +2",
        hands="Boii Mufflers +3",
        legs="Sulev. Cuisses +2",
        feet="Boii Calligae +2",
        neck="Sanctity Necklace",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Boii Earring",
        left_ring="Chirich Ring +1",
        right_ring="Shneddick Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    
    sets.idle.Field = set_combine(sets.idle.Town, { })

    sets.idle.Regen = set_combine(sets.idle.Field, { })
 
    -- Twilight goes here
	sets.idle.Weak = set_combine(sets.idle.Field, { })

-------------------------------------------------------------------------------------------------------------------
-- Defense sets
-------------------------------------------------------------------------------------------------------------------

    sets.defense.PDT = {
        head="Boii Mask +3", --10
        body="Boii Lorica +2", --13
        hands="Sulev. Gauntlets +2", --5
        legs="Sakpata's Gauntlets", --8
        feet="Boii Calligae +2", --9
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Boii Earring",
        left_ring="Chirich Ring +1",
        right_ring="Defending Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
	
    sets.defense.Reraise = sets.idle.Weak
 
    sets.defense.MDT = set_combine(sets.defense.PDT, { })

-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------
 
    sets.engaged = {
        ammo="Ginsen",
        head="Boii Mask +3",
        body="Boii Lorica +2",
        hands="Sakpata's Gauntlets",
        legs="Boii Cuisses +2",
        feet="Pumm. Calligae +3",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Boii Earring",
        left_ring="Chirich Ring +1",
        --right_ring="Sroda Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }	
    sets.engaged.MidAcc = set_combine(sets.engaged, { })
    sets.engaged.FullAcc = set_combine(sets.engaged.MidAcc, { })

    sets.engaged.Reraise = set_combine(sets.engaged, { })

-------------------------------------------------------------------------------------------------------------------
-- Hybrid Sets
-------------------------------------------------------------------------------------------------------------------    

	sets.Hybrid = set_combine(sets.engaged, { 
        legs="Sulev. Cuisses +2",
        feet="Boii Calligae +2",
        
    })
    sets.Hybrid.MidAcc = set_combine(sets.engaged, { })
    sets.Hybrid.FullAcc = set_combine(sets.engaged, { })

    sets.engaged.Hybrid = sets.Hybrid
    sets.engaged.MidAcc.Hybrid = sets.Hybrid.MidAcc
    sets.engaged.FullAcc.Hybrid = sets.Hybrid.FullAcc
	
-------------------------------------------------------------------------------------------------------------------
-- Utility Sets
-------------------------------------------------------------------------------------------------------------------
    
	--Buffs
	sets.buff.Berserk 		= set_combine(sets.engaged, { })
    sets.buff.Retaliation 	= set_combine(sets.engaged, { })
	
	--Debuffs
	sets.Doom = set_combine(sets.engaged, { })
	
	sets.EmergencyDT = set_combine(sets.engaged, { })

    sets.Kiting 	 = set_combine(sets.engaged, { })
 
    sets.Reraise 	 = set_combine(sets.engaged, { })
	
    sets.resting 	 = set_combine(sets.engaged, { })
	
	sets.CP 		 = set_combine(sets.engaged, { })

-------------------------------------------------------------------------------------------------------------------	
-- Weapon Sets
-------------------------------------------------------------------------------------------------------------------

	--sets.Montante	 = {main="Montante +1", sub="Bloodrain Strap"}
	--sets.Reikiono	 = {main="Reikiono", sub ="Bloodrain Strap"}
    sets.Naegling 	 = {main="Naegling", sub="Blurred Shield +1"}	
    sets.Lycurgos    = {main="Lycurgos", sub="Pole Grip"}
    sets.KajaLance   = {main="Kaja Lance", sub="Pole Grip"}
    sets.Club        = {main="Beryllium Mace", sub="Blurred Shield +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
end
 
function job_post_precast(spell, action, spellMap, eventArgs)
    -- Make sure abilities using head gear don't swap 
	if spell.type:lower() == 'weaponskill' then
        -- handle Gavialis Helm
        if is_sc_element_today(spell) then
            if wsList:contains(spell.english) then
                -- do nothing
            else
                equip(sets.WSDayBonus)
            end
        end
        -- Use SOA neck piece for WS in rieves
        if buffactive['Reive Mark'] then
            equip(sets.reive)
        end
    end
end

-- Check if we need Gavialis Helm
 function is_sc_element_today(spell)
    if spell.type ~= 'WeaponSkill' then
        return
    end

   local weaponskill_elements = S{}:
    union(skillchain_elements[spell.skillchain_a]):
    union(skillchain_elements[spell.skillchain_b]):
    union(skillchain_elements[spell.skillchain_c])

    if weaponskill_elements:contains(world.day_element) then
        return true
    else
        return false
    end

end

function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (state.HybridMode.current == 'Hybrid' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
        equip(sets.buff.Berserk)
    end
end
 
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(status, eventArgs)
    check_gear()
	check_moving()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if buffactive['Terror'] or buffactive['Petrification'] or buffactive['Stun'] or buffactive['Sleep'] then
		idleSet = sets.EmergencyDT
	end
	if state.Pause.current == 'on' then
		idleSet = { } --leave this empty
		state.Auto_Kite:set(false)
	end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end
    return idleSet
end
  
function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

-- Gearinfo Hooks 
function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if buffactive['Terror'] or buffactive['Petrification'] or buffactive['Stun'] or buffactive['Sleep']  then
		meleeSet = sets.EmergencyDT
	end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
	if state.Pause.current == 'on' then
		meleeSet = { } --leave this empty
		state.Auto_Kite:set(false)
	end
    if state.CP.current == 'on' then
        meleeSet = set_combine(meleeSet, sets.CP)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
    	meleeSet = set_combine(meleeSet, sets.buff.Berserk)
    end
    check_weaponset()
    return meleeSet
end
 
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        if buffactive.Berserk and not state.Buff.Retaliation then
            equip(sets.buff.Berserk)
        end
    end
end
 
-- Called when a player gains or loses a buff.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    if buff == "Berserk" then
        if gain and not buffactive['Retaliation'] then
            equip(sets.buff.Berserk)
        else
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
end
 
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    check_weaponset()
end 

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle.Town)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle.Town)
        end
    end
)

function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 8)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 8)
	else
		set_macro_page(1, 8)
	end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end