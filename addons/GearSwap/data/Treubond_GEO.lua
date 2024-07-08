
--[[
        Custom commands:
		
		Because /sch can be a thing... I've opted to keep this part 

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
		gs c scholar power				Rapture					Ebullience
        gs c scholar addendum           Addendum: White         Addendum: Black
        

        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
		
        Casting functions:
        these are to set fewer macros (2 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle              	Cycles element type for nuking & SC
		gs c nuke cycledown				Cycles element type for nuking & SC	in reverse order
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke ra1                   Cast tier 1 -ra nuke of saved element 
        gs c nuke ra2                   Cast tier 2 -ra nuke of saved element 
        gs c nuke ra3                   Cast tier 3 -ra nuke of saved element
		gs c nuke helix					Cast helix of saved element
		gs c nuke storm					Cast storm of saved element
		
		gs c geo geocycle				Cycles Geomancy Spell
		gs c geo geocycledown			Cycles Geomancy Spell in reverse order
		gs c geo indicycle				Cycles IndiColure Spell
		gs c geo indicycledown			Cycles IndiColure Spell in reverse order
		gs c geo geo					Cast saved Geo Spell
		gs c geo indi					Cast saved Indi Spell

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.

        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]


include('organizer-lib') -- Remove if you dont use Organizer


--------------------------------------------------------------------------------------------------------------
res = require('resources')      -- leave this as is    
texts = require('texts')        -- leave this as is    
include('Modes.lua')            -- leave this as is    

include('Global-Binds.lua')
--------------------------------------------------------------------------------------------------------------

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('normal', 'dt', 'mdt')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 950    --important to update these if you have a smaller screen
hud_y_pos = 50     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Arial'

-- Setup your Key Bindings here:  
    windower.send_command('bind ^delete gs c nuke cycle')            -- insert Cycles Nuke element
    windower.send_command('bind delete gs c nuke cycledown')        -- delete Cycles Nuke element in reverse order   
    windower.send_command('bind home gs c geo geocycle') 			-- home Cycles Geomancy Spell
    windower.send_command('bind end gs c geo geocycledown') 		-- end Cycles Geomancy Spell in reverse order	
    windower.send_command('bind PAGEUP gs c geo indicycle') 		-- PgUP Cycles IndiColure Spell
    windower.send_command('bind PAGEDOWN gs c geo indicycledown') 	-- PgDown Cycles IndiColure Spell in reverse order	
    windower.send_command('bind !f12 gs c toggle runspeed') 		-- Alt-F9 toggles locking on / off Herald's Gaiters
	windower.send_command('bind !f10 gs c toggle mb')				-- Alt-F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind f10 gs c toggle nukemode')			-- F10 to change Nuking Mode
    windower.send_command('bind ^F10 gs c toggle matchsc')			-- CTRL-F10 to change Match SC Mode         
    windower.send_command('bind f12 gs c toggle melee')				-- F12 Toggle Melee mode on / off and locking of weapons
	windower.send_command('bind f9 gs c toggle idlemode')			-- F9 Toggles between MasterRefresh or MasterDT when no luopan is out
	windower.send_command('bind ^end gs c hud keybinds')
	windower.send_command('bind !end gs c hud lite')  

	windower.send_command('bind ^f input /ja "Full Circle" <me>')
	windower.send_command('bind ^n input /ja "Entrust" <me>')

	windower.send_command('bind ^numpad1 input //send Hybridkiller /ws fudo <t>')
    windower.send_command('bind ^numpad3 input //send Hybridkiller /ws kasha <t>')
    windower.send_command('bind ^numpad2 input //send Hybridkiller /ws shoha <t>')

--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]																	-- or between Full Pet Regen+DT or Hybrid PetDT and MasterDT when a Luopan is out
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(F10)'
keybinds_on['key_bind_mburst'] = '(ALT-F10)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'

keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
keybinds_on['key_bind_geo_cycle'] = '(HOME + END)'
keybinds_on['key_bind_indi_cycle'] = '(PgUP + PgDOWN)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F12)'


-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind ^delete')
    send_command('unbind delete')
    send_command('unbind home')
    send_command('unbind PAGEUP')
    send_command('unbind PAGEDOWN')
    send_command('unbind end')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind f9')
    send_command('unbind !f12')
	send_command('unbind !end')

	send_command('unbind ^numpad1')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad2')
	send_command('unbind !e')
	send_command('unbind !r')

	send_command('unbind ^f')
	send_command('unbind ^n')
end

--------------------------------------------------------------------------------------------------------------
include('GEO_Lib.lua')          -- leave this as is     
--------------------------------------------------------------------------------------------------------------

geomancy:set('Geo-Frailty')     -- Geo Spell Default      (when you first load lua / change jobs the saved spells is this one)
indicolure:set('Indi-Haste')    -- Indi Spell Default     (when you first load lua / change jobs the saved spells is this one)
validateTextInformation()

-- Optional. Swap to your geo macro sheet / book
set_macros(1,7) -- Sheet, Book 
send_command('wait 10;input /lockstyleset 10')
    
-- Setup your Gear Sets below:
function get_sets()
	if player.sub_job == "RDM" then
		send_command('bind !r input /ma "Refresh" <stpc>')
		send_command('bind !e input /ma "Haste" <stpc>')
	end

	if player.sub_job == "WHM" then
		send_command('bind !e input /ma "Haste" <stpc>')
	end
		
	
	AF = {}
	RELIC = {}
	EMPY ={}
	
	AF.Head = "Geomancy Galero"
	AF.Body = "Geomancy Tunic"
	AF.Hands = "Geomancy Mitaines +3"
	AF.Legs = "Geomancy Pants"
	AF.Feet = "Geomancy Sandals"
	
	RELIC.Head = "Bagua Galero"
	RELIC.Body = "Bagua Tunic"
	RELIC.Hands = "Bagua Mitaines"
	RELIC.Legs = "Bagua Pants"
	RELIC.Feet = "Bagua Sandals +3"
	
	EMPY.Head = "Azimuth Hood +3"
	EMPY.Body = "Azimuth Coat"
	EMPY.Hands = "Azimuth Gloves"
	EMPY.Legs = "Azimuth Tights"
	EMPY.Feet = "Azimuth Gaiters +2"
	
	GEOCape = {}
	
	GEOCape.Idle = { name = "Nantosuelta's Cape"}
	GEOCape.PetIdle = {}
	GEOCape.Nuke = {}
	GEOCape.FC = {}
	
    Telchine_ENH_head = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}}
    Telchine_ENH_body = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
    Telchine_ENH_hands = { name="Telchine Gloves", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}}
    Telchine_ENH_legs = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
    Telchine_ENH_feet = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}

    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my.pan's behaviour or abilities are under .pan', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        -- leave this empty
    sets.pan = {}       -- leave this empty
	sets.me.idle = {}	-- leave this empty    
	sets.pan.idle = {}	-- leave this empty 

	-- sets starting with sets.me means you DONT have a luopan currently out.
	-- sets starting with sets.pan means you DO have a luopan currently out.

    -- Your idle set when you DON'T have a luopan out
    sets.me.idle.normal = {
		main="Bolelabunga",
		sub="Culminus",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Befouled Crown",
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Hierarch Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
		--[[ main = "Daybreak",
		sub = "Culminus",
		range = "Dunna",
		neck = "Sibyl Scarf",
		head = "Befouled Crown",
		body = EMPY.Body,
		hands = RELIC.Hands,
		legs = EMPY.Legs,
		feet = EMPY.Feet,
		left_ear = "Eabani Earring",
		right_ear = "Odnowa Earring +1",
		left_ring = "Defending Ring",
		right_ring = "Gelatinous Ring +1",
		waist = "Slipor Sash",
		back = GEOCape.Idle, ]]

    }
	
	-- This or herald gaiters or +1 +2 +3... 
	sets.me.movespeed = {--[[ feet=AF.Feet ]]}	
	
    -- Your idle MasterDT set (Notice the sets.me, means no Luopan is out)
    sets.me.idle.dt = set_combine(sets.me.idle.normal,{
		main="Bolelabunga",
		sub="Culminus",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Nyame Helm",
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
	--[[ 		main = "Malignance Pole",
			sub = "Enki Strap",
			body = "Mallquis Saio +2",
			hands = AF.Hands,
			feet = "Mallquis Clogs +2" ]]

    })
    sets.me.idle.mdt = set_combine(sets.me.idle.normal,{

    })	
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
	
	sets.me.latent_refresh = {waist="Fucho-no-obi"}
	
	
    -----------------------
    -- Luopan Perpetuation
    -----------------------
      
    -- Luopan's Out --  notice sets.pan 
    -- This is the base for all perpetuation scenarios, as seen below
    sets.pan.idle.normal = {
		main="Idris",
		sub="Culminus",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = EMPY.Head,
		body="Jhakri Robe +2",
		hands=AF.Hands,
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet=RELIC.Feet,
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Isa Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}},
		--[[ main = "Solstice",
		sub = "Culminus",
		range = "Dunna",
		head = EMPY.Head,
		body = "Mallquis Saio +2",
		hands = AF.Hands,
		neck = "Elite Royal Collar",
		feet = RELIC.Feet,
		left_ear = "Eabani Earring",
		ring_ear = "Odnowa Earring +1",
		left_ring = "Defending Ring",
		right_ring = "Gelatinous Ring +1",
		waist = "Slipor Sash",
		back = GEOCape.PetIdle, ]]

    }
	
	-- This is when you have a Luopan out but want to sacrifice some slot for master DT, put those slots in.
    sets.pan.idle.dt = set_combine(sets.pan.idle.normal,{

    })   
    sets.pan.idle.mdt = set_combine(sets.pan.idle.normal,{

    })   
    -- Combat Related Sets
      
    -- Melee
    -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
	-- No Luopan out
	-- they end in [idleMode] so it will derive from either the normal or the dt set depending in which mode you are then add the pieces filled in below.
    sets.me.melee = set_combine(sets.me.idle[idleMode],{
		head = "Jhakri Coronal +2",
		body = "Jhakri Robe +2",
		hands = "Jhakri Cuffs +2",
		legs = "Jhakri Slops +2",
		feet = "Jhakri Pigaches +2",
		neck = "Asperity Necklace",
		waist = "Potent Belt",
		left_ear = "Telos Earring",
		right_ear = "Cessance Earring",
		left_ring = "Chirich Ring +1",
		right_ring = "Chirich Ring",
		--[[ neck = "Lissome Necklace",
		waist = "Goading Belt",
		left_ear = "Suppanomimi",
		right_ear = "Brutal Earring",
		left_ring = "Rajas Ring",
		right_ring = "Petrov Ring" ]]
    })
	
    -- Luopan is out
	sets.pan.melee = set_combine(sets.pan.idle.normal,{ --[idleMode],{
		left_ear = "Telos Earring",
		right_ear = "Cessance Earring",
		left_ring = "Chirich Ring +1",
		right_ring = "Lehko's Ring",
		waist="Isa Belt",
		back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}},
    }) 
    
    -- Weapon Skill sets
	-- Example:
	sets.me["Hexa Strike"] = {
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
	}
	sets.me["Judgment"] = {
		--[[ neck = "Rep. Plat. Medal", ]]
		
		left_ear = "Moonshade Earring",
		
	}
	
    sets.me["Flash Nova"] = {

    }
	
	sets.me["Black Halo"] = {
		hands = "Jhakri Cuffs +2",
		left_earring = "Moonshade Earring",	
	}

    sets.me["Realmrazer"] = {
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
    }
	
    sets.me["Exudation"] = {
		--neck = "Sibyl Scarf",
		waist = "Acuity Belt +1",
		left_ear = "Malignance Earring",
		--right_ear = "", --Regal
		left_ring = { name="Metamor. Ring +1", augments={'Path: A',}},

    }
	
	sets.me["Cataclysm"] = {
		--[[ head = "Pixie Hairpin +1",
		
		left_ring = "Archon Ring", ]]
		
	}
    -- Feel free to add new weapon skills, make sure you spell it the same as in game.
  
    ---------------
    -- Casting Sets
    ---------------
      
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty    
    sets.midcast.nuking = {}        -- leave this empty
    sets.midcast.MB = {}            -- leave this empty    
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast  
    sets.precast.casting = {
		main="Daybreak",
		sub="Culminus",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Jhakri Ring",
		right_ring="Kishar Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
		--[[ main = "Solstice",
		range = "Dunna",
		body = "Merlinic Jubbah",
		legs = AF.Legs,
		left_ear = "Malignance Earring",
		left_ring = "Kishar Ring",
		back = GEOCape.FC ]]

    }   

    sets.precast.geomancy = set_combine(sets.precast.casting,{
        neck={ name="Bagua Charm +2", augments={'Path: A',}},
    })
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
		waist="Siegel Sash",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{

    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
		main="Vadose Rod",
		sub="Sors Shield",
		back="Pahtli Cape",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    })
    sets.precast.regen = set_combine(sets.precast.casting,{

    })     
    ---------------------
    -- Abilities
    ---------------------
	
	-- JAs on yourself
    sets.precast["Life Cycle"] = {
    	body = AF.Body,
    }
    sets.precast["Bolster"] = {
    	body = RELIC.Body,
    }
    sets.precast["Full Circle"] = {
    	head = EMPY.Head,
		--hands = RELIC.Hands, -- Curative Recantation
    }
	
	-- JAs that emanate from the loupan
    sets.pan["Mending Halation"] = {
    	--legs = RELIC.Legs,
    }
    sets.pan["Radial Arcana"] = {
    	feet = RELIC.Feet,
    }
	sets.pan["Concentric Pulse"] = {
		--head = RELIC.Head
	}

    ----------
    -- Midcast
    ----------
            
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
		head = EMPY.Head,
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},

    }
	
	-- For Geo spells /
    sets.midcast.geo = set_combine(sets.midcast.casting,{
		main = "Idris",
		head = EMPY.Head,
		feet = EMPY.Feet,
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		--[[ main = "Solstice",
		sub = "Culminus",
		range = "Dunna",
		head = EMPY.Head,
		body = RELIC.Body,
		hands = AF.Hands,
		legs = RELIC.Legs,
		feet = EMPY.Feet,
		neck = "Incanter's Torque",
		back = "Lifestream Cape", ]]
		

    })
	-- For Indi Spells
    sets.midcast.indi = set_combine(sets.midcast.geo,{

    })
	sets.midcast.indi.entrust = set_combine(sets.midcast.indi,{
		--main = "Solstice"
    })

	sets.midcast.Obi = {
	    waist="Hachirin-no-Obi",
	}
	-- Nuking
    sets.midcast.nuking.normal = set_combine(sets.midcast.casting,{
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head=EMPY.Head,
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet=EMPY.Feet,
		neck="Saevus Pendant +1",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear = "Azimuth Earring",
		left_ring="Jhakri Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Izdubar Mantle",
		--[[ ammo = "Ghastly Tathlum +1",
		head = EMPY.Head,
		body = EMPY.Body,
		hands = EMPY.Hands,
		legs = EMPY.Legs,
		feet = EMPY.Feet,
		neck = "Sibyl Scarf",
		left_ear = "Malignance Earring",
		right_ear = "Azimuth Earring",
		waist = "Eschan Stone", ]]


    })
	sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, { --I/II  43/19
		main="Bunzi's Rod", --10
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head="Ea Hat", --6/6
		body="Ea Houppelande", --8/8
		hands="Ea Cuffs", --5/5
		legs={ name="Nyame Flanchard", augments={'Path: B',}}, --6/0  
		feet={ name="Agwu's Pigaches", augments={'Path: A',}}, --6/0
		neck="Saevus Pendant +1",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear = "Azimuth Earring",
		left_ring="Jhakri Ring", --2/0
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Izdubar Mantle",
	})
    sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal,{

    })
    sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {

    })
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Belt that isn't Obi.
	-- Noctohelix automatically looks for pixie hairpin +1.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.
	sets.midcast.helix =  {
			
	}

	-- Enfeebling
	sets.midcast.IntEnfeebling = set_combine(sets.midcast.casting,{
		--right_ring="Metamorph Ring",
    })
	sets.midcast.MndEnfeebling = set_combine(sets.midcast.casting,{
		--right_ring="Metamorph Ring",
    })
	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
		head=Telchine_ENH_head,
		body=Telchine_ENH_body,
		hands=Telchine_ENH_hands,
		legs=Telchine_ENH_legs,
        feet=Telchine_ENH_feet,
    })
	
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		--neck = "Stone Gorget"

    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh, {
		main = "Vadose Rod",
		sub = "Culminus",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
	})
	
	sets.midcast["Drain"] = set_combine(sets.midcast.IntEnfeebling, {
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
		left_ring="Excelsis Ring",
		right_ring = "Archon Ring",
		--[[ -- Sinister Reign Club
		-- Omen Shield
		head = RELIC.Head,
		body = AF.Body,
		hands = "", --Merlinic
		legs = EMPY.Legs,
		feet = "", --Agwu
		neck = "Erra Pendant",
		left_ring = "Archon Ring",
		right_ring = "Evanescence Ring" ]]
	})

	sets.midcast["Aspir"] = sets.midcast["Drain"]
     
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		main = "Daybreak",
		sub = "Culminus",
		hands=Telchine_ENH_hands,
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{

    })    
    sets.midcast.regen = set_combine(sets.midcast.enhancing,{
		main="Bolelabunga",
    }) 
   
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have a Luopan pan out?
  
end