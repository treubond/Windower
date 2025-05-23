
--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
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
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm II buff of saved element  
                    
        gs c sc tier                    Cycles SC Tier (1 & 2)
        gs c sc castsc                  Cast All the stuff to create a SC burstable by the nuke element set with '/console gs c nuke element'.

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

--  ALT = !
--  CTL = ^
--  WIN = @
--  MENU = #

--  Abilities:  [ CTRL+` ]          Immanence
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+[ ]          Rapture/Ebullience
--              [ CTRL+] ]          Altruism/Focalization
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+] ]           Perpetuance
--              [ ALT+; ]           Penury/Parsimony
--]]

-------------------------------------------------------------                                        
--                              
--      ,---.     |    o               
--      |   |,---.|--- .,---.,---.,---.
--      |   ||   ||    ||   ||   |`---.
--      `---'|---'`---'``---'`   '`---'
--           |                         
-------------------------------------------------------------  

--include('organizer-lib') -- Can remove this if you dont use organizer
res = require('resources')
texts = require('texts')
include('Modes.lua')
include('Global-Binds.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt')
regenModes = M('hybrid', 'duration', 'potency')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1080    --important to update these if you have a smaller screen
hud_y_pos = 300     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 8
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here:
    windower.send_command('bind insert gs c nuke cycle')        -- insert to Cycles Nuke element
    windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
    windower.send_command('bind f9 gs c toggle idlemode')       -- F9 to change Idle Mode    
    windower.send_command('bind !f9 gs c toggle runspeed') 		-- Alt-F9 toggles locking on / off Herald's Gaiters
    windower.send_command('bind f12 gs c toggle melee')			-- F12 Toggle Melee mode on / off and locking of weapons
    windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
    windower.send_command('bind home gs c sc tier')				-- home to change SC tier between Level 1 or Level 2 SC
    windower.send_command('bind end gs c toggle regenmode')		-- end to change Regen Mode	
    windower.send_command('bind f10 gs c toggle mb')            -- F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind !f10 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
    windower.send_command('bind ^F10 gs c toggle matchsc')      -- CTRL-F10 to change Match SC Mode      	
    windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version   

    send_command('bind ^` input /ja Immanence <me>')
    --send_command('bind !` gs c toggle MagicBurst')
    send_command('bind ^- gs c scholar light')
    send_command('bind ^= gs c scholar dark')
    send_command('bind ^[ gs c scholar power')
    send_command('bind ^] gs c scholar accuracy')
    send_command('bind ^; gs c scholar speed')
    send_command('bind !w input /ma "Aspir II" <t>')
    send_command('bind !o input /ma "Regen V" <stpc>')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !] gs c scholar duration')
    send_command('bind !; gs c scholar cost')
    -- send_command('bind @c gs c toggle CP')
    send_command('bind @h gs c cycle HelixMode')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind @s gs c toggle StormSurge')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind ^numpad7 input //send Hybridkiller /ws fudo <t>')
    send_command('bind ^numpad9 input //send Hybridkiller /ws kasha <t>')
    send_command('bind ^numpad4 input //send Hybridkiller /ws shoha <t>')
    
    send_command('bind ^numpad0 input /Myrkr')

    send_command('@input /macro book '..tostring(2)..';wait 1.1;input /macro set '..tostring(1))
    --set_macro_page(1, 2)
    --select_default_macro_book()
    send_command('wait 10;input /lockstyleset 8')

--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mburst'] = '(F10)'

keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_sc_level'] = '(HOME)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind ^`')
    --send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ^;')
    send_command('unbind !w')
    send_command('unbind !o')
    send_command('unbind ![')
    send_command('unbind !]')
    send_command('unbind !;')
    send_command('unbind ^,')
    send_command('unbind !.')
    -- send_command('unbind @c')
    send_command('unbind @h')
    send_command('unbind @g')
    send_command('unbind @s')
    send_command('unbind @w')
    send_command('unbind ^numpad0')
    
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')

    send_command('unbind insert')
    send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind end')
    send_command('unbind !f10')	
    send_command('unbind `f10')
    send_command('unbind !f9')	
    send_command('unbind !end')      	
end


--------------------------------------------------------------------------------------------------------------
include('SCH_Lib.lua')          -- leave this as is    
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------





-------------------------------------------------------------                                        
--      ,---.                         |         
--      |  _.,---.,---.,---.,---.,---.|--- ,---.
--      |   ||---',---||    `---.|---'|    `---.
--      `---'`---'`---^`    `---'`---'`---'`---'
-------------------------------------------------------------                                              

-- Setup your Gear Sets below:
function get_sets()
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.idle = {}			-- leave this empty

    Telchine_ENH_head = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}}
    Telchine_ENH_body = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
    Telchine_ENH_hands = { name="Telchine Gloves", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}}
    Telchine_ENH_legs = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
    Telchine_ENH_feet = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}

	--Sets
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
	
	EMPY.Head = "Arbatel Bonnet +2"
	EMPY.Body = "Arbatel Gown +2"
	EMPY.Hands = "Arbatel Bracers +2"
	EMPY.Legs = "Arbatel Pants +2"
	EMPY.Feet = "Arbatel Loafers +2"

    -- Your idle set
    sets.me.idle.refresh = {
        main="Daybreak", --1
        sub="Genbu's Shield",
        ammo="Staunch Tathlum +1",
        head="Befouled Crown", --1
        body="Jhakri Robe +2", --4
        hands="Nyame Gauntlets",
        legs=EMPY.Legs,
        feet="Mallquis Clogs",
        neck="Morgana's Choker",
        waist="Hierarch Belt",
        left_ear="Magnetic Earring",
        right_ear="Loquac. Earring",
        left_ring="Shneddick Ring",
        right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        back={ name="Fi Follet Cape +1", augments={'Path: A',}},
    }

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.idle.sublimation = set_combine(sets.me.idle.refresh,{

    })   
    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle[refreshType],{ --DT 53 + 7%dmg to MP
        --main="Malignance Pole", --20
        --sub="Benthos Grip",
        ammo="Staunch Tathlum +1", --3
        head=EMPY.Head, --9
        body="Jhakri Robe +2",
        hands="Nyame Gauntlets", --7
        legs=EMPY.Legs, --11
        feet="Mallquis Clogs", --7% dmg to MP
        neck={ name="Loricate Torque +1", augments={'Path: A',}}, --6
        waist="Plat. Mog. Belt", --3
        left_ear="Magnetic Earring",
        right_ear="Eabani Earring",
        left_ring="Shneddick Ring",
        right_ring="Defending Ring", --10
        back="Solemnity Cape", --4
    })  
    sets.me.idle.mdt = set_combine(sets.me.idle[refreshType],{

    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
    sets.me.melee = set_combine(sets.me.idle[idleModes.current],{
    --[[ ammo="Hasty Pinion +1",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Battlecast Gaiters",
	neck="Sanctity Necklace",
    waist="Cetl Belt",
	left_ear="Brutal Earring",
	right_ear="Moonshade Earring",
    left_ring="Karieyh Ring",
    right_ring="Rajas Ring",
    back="Bookworm's Cape", ]]
    })
      
    -- Weapon Skills sets just add them by name.
    sets.me["Shattersoul"] = {
    --[[ ammo="Oreiad's Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
	neck="Erra Pendant",
    waist="Eschan Stone",
	left_ear="Brutal Earring",
	right_ear="Moonshade Earring",
    left_ring="Karieyh Ring",
    right_ring="Rajas Ring",
    back="Bookworm's Cape" ]]
    }
    sets.me["Myrkr"] = {
    --[[ ammo="Oreiad's Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
	neck="Erra Pendant",
    waist="Eschan Stone",
	left_ear="Brutal Earring",
	right_ear="Moonshade Earring",
    left_ring="Karieyh Ring",
    right_ring="Rajas Ring",
    back="Bookworm's Cape" ]]
    }
     
    sets.me["Black Halo"] = {
    --[[ ammo="Oreiad's Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
	neck="Erra Pendant",
    waist="Eschan Stone",
	left_ear="Brutal Earring",
	right_ear="Moonshade Earring",
    left_ring="Karieyh Ring",
    right_ring="Rajas Ring",
    back="Bookworm's Cape" ]]
    }
    sets.me["Realmrazer"] = {
    --[[ ammo="Oreiad's Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
	neck="Erra Pendant",
    waist="Eschan Stone",
	left_ear="Brutal Earring",
	right_ear="Moonshade Earring",
    left_ring="Karieyh Ring",
    right_ring="Rajas Ring",
    back="Bookworm's Cape" ]]
    }


	 
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
  
    ------------
    -- Buff Sets
    ------------	
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    -- Fill up following with your avaible pieces.
    sets.buff['Rapture'] = {head=EMPY.Head}
    sets.buff['Perpetuance'] = {hands=EMPY.Hands}
    sets.buff['Immanence'] = {hands=EMPY.Hands}
    sets.buff['Penury'] = {legs=EMPY.Legs}
    sets.buff['Parsimony'] = {legs=EMPY.Legs}
    sets.buff['Celerity'] = {--[[ feet="Peda. Loafers" ]]}
    sets.buff['Alacrity'] = {--[[ feet="Peda. Loafers" ]]}
    sets.buff['Klimaform'] = {feet=EMPY.Feete}	
    -- Ebulience set empy now as we get better damage out of a good Merlinic head
    sets.buff['Ebullience'] = {head=EMPY.Head} -- I left it there still if it becomes needed so the SCH.lua file won't need modification should you want to use this set
   
   	
	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
	sets.midcast.nuking = {}	-- leave this empty
	sets.midcast.MB	= {}		-- leave this empty      
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast 
    -- Grimoire: 10(cap:25) / rdm: 15
    sets.precast.casting = {
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Mallquis Clogs",
        left_ear="Magnetic Earring",
        right_ear="Loquac. Earring",
        left_ring="Kishar Ring",
        right_ring="Jhakri Ring",        
        back={ name="Fi Follet Cape +1", augments={'Path: A',}},
    }

	sets.precast["Stun"] = {

	}

    -- When spell school is aligned with grimoire, swap relevent pieces -- Can also use Arbatel +1 set here if you value 1% quickcast procs per piece. (2+ pieces)  
    -- Dont set_combine here, as this is the last step of the precast, it will have sorted all the needed pieces already based on type of spell.
    -- Then only swap in what under this set after everything else. 
    sets.precast.grimoire = {
 --[[        main="Nibiru Staff",
        sub="Clerisy Strap",
        ammo="Incantor Stone",
        head="Amalric Coif",
        body="Rosette Jaseran",
        hands="Acad. Bracers +1",
        legs="Orvail Pants +1",
        feet={ name="Peda. Loafers", augments={'Enhances "Stormsurge" effect',}},
        waist="Witful Belt",
        left_ring="Prolix Ring",
        right_ring="Kishar Ring",
        back="Swith Cape"
 ]]
    }

	
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
	    waist="Siegal Sash"
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
        head="Umuthi Hat",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
        main="Vadose Rod", --16
        sub="Sors Shield",
        ammo="Staunch Tathlum +1",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Phalaina Locket",
        waist="Sacro Cord",
        left_ear="Magnetic Earring",
        right_ear="Loquac. Earring",
        left_ring="Jhakri Ring",
        right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        back="Pahtli Cape",
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Tabula Rasa"] = {--[[ legs="Pedagogy Pants" ]]}
    sets.precast["Enlightenment"] = {--[[ body="Pedagogy gown" ]]}	 
    sets.precast["Sublimation"] = {
        body="Argute Gown",
        left_ear="Savant's Earring",
        --[[ head="Acad. Mortar. +1",
        body="Pedagogy gown", ]]
    }	 

	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist="Hachirin-no-Obi",
    }
	
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Boots that aren't arbatel +1 (15% of small numbers meh, amalric+1 does more)
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = {
        head="Pixie Hairpin +1",
        body=EMPY.Body,
        hands=EMPY.Hands,
        legs=EMPY.Legs,
        feet=EMPY.Feet,
        neck={ name="Argute Stole +1", augments={'Path: A',}},
        right_ring="Archon Ring",
        waist="Sacro Cord",
        right_ring="Mallquis Ring",
    }
    sets.midcast.LightHelix = {
        main="Daybreak",
        sub="Culminus",
        head=EMPY.Head,
        body=EMPY.Body,
        hands=EMPY.Hands,
        legs=EMPY.Legs,
        feet=EMPY.Feet,
        neck={ name="Argute Stole +1", augments={'Path: A',}},
        waist="Sacro Cord",
        right_ring="Mallquis Ring",
    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
        head=EMPY.Head,
        body=EMPY.Body,
        hands=EMPY.Hands,
        legs=EMPY.Legs,
        feet=EMPY.Feet,
        neck={ name="Argute Stole +1", augments={'Path: A',}},
        waist="Sacro Cord",
        right_ring="Mallquis Ring",
    }	

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {

    }

	sets.midcast["Sublimation"] = {
	--[[ head="Acad. Mortar. +1", 
	body="Pedagogy gown", ]]
	    waist="Embla Sash",
	}
    
    sets.midcast.nuking.normal = {  --MAB 345, MACC 303, MB 26/0
        main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head=EMPY.Head,
        body=EMPY.Body,
        hands={ name="Agwu's Gages", augments={'Path: A',}},
        legs=EMPY.Legs,
        feet={ name="Agwu's Pigaches", augments={'Path: A',}},
        neck="Saevus Pendant +1",
        waist="Sacro Cord",
        left_ear="Malignance Earring",
        right_ear={ name="Arbatel Earring", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+10',}},
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Freke Ring",
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	    --[[
        legs="Amalric Slops",
        feet="Jhakri Pigaches +2",
	    neck="Saevus Pendant +1",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Acumen Ring",
        right_ring="Strendu Ring",
        back="Bookworm's Cape" ]]
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, { -- MAB 327, MACC 334, MB 31/8
        main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}}, --10
        sub="Elan Strap",
        ammo="Ghastly Tathlum +1",
        head=EMPY.Head,
        body=EMPY.Body,
        hands={ name="Agwu's Gages", augments={'Path: A',}}, --8/3
        legs=EMPY.Legs,
        feet={ name="Agwu's Pigaches", augments={'Path: A',}}, --6
        neck={ name="Argute Stole +1", augments={'Path: A',}}, --7
        waist="Sacro Cord",
        left_ear="Malignance Earring",
        right_ear={ name="Arbatel Earring", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+10',}},
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Mujin Band", --0/5
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	    --[[ main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Elan Strap",
        ammo="Ghastly Tathlum +1",
        head=EMPY.Head,
        body=EMPY.Body,
        hands=EMPY.Hands,
        legs=EMPY.Legs,
        feet="Jhakri Pigaches +2",
        neck={ name="Argute Stole +1", augments={'Path: A',}},
        waist="Penitent's Rope",
        left_ear="Malignance Earring",
        right_ear={ name="Arbatel Earring", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+10',}},
        left_ring="Jhakri Ring",
        right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        back="Izdubar Mantle", ]]
    })
	
    sets.midcast.nuking.acc = {  -- MAB 329, MACC 379, MAB 19/4
        --main="Bunzi's Rod",
        --sub="Ammurapi Shield",
        main="Marin Staff +1",
        sub="Khonsu",
        ammo="Ghastly Tathlum +1",
        head=EMPY.Head,
        body=EMPY.Body,
        hands=EMPY.Hands,
        legs=EMPY.Legs,
        feet=EMPY.Feete,
        neck={ name="Argute Stole +1", augments={'Path: A',}},
        waist="Acuity Belt +1",
        left_ear="Malignance Earring",
        right_ear={ name="Arbatel Earring", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+10',}},
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Freke Ring",
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }
    
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {  -- MAB 314, MACC , MB 29/4
        sub="Khonsu",
        hands=EMPY.Hands,
        feet=EMPY.Feete,
        waist="Acuity Belt +1",
        right_ring="Freke Ring",
    })	
	
    -- Enfeebling
	sets.midcast["Stun"] = {

	}	

    sets.midcast.IntEnfeebling = {
        main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Grip",
        ammo="Ghastly Tathlum +1",
        head=EMPY.Head,
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck={ name="Argute Stole +1", augments={'Path: A',}},
        waist="Actuiy Belt +1",
        left_ear="Malignance Earring",
        right_ear="Regal Earring",
        left_ring="Omega Ring",
        right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	--[[ main="Daybreak",
    sub="Culminus",
    ammo="Oreiad's Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
	neck="Erra Pendant",
    waist="Eschan Stone",
	left_ear="Hermetic Earring",
	right_ear="Hecate's Earring",
    left_ring="Stikini Ring",
    right_ring="Kishar Ring",
    back="Bookworm's Cape"
 ]]
    }
    sets.midcast.MndEnfeebling = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Elis Tome",
        head=EMPY.Head,
        body="Jhakri Robe +2",
        hands=EMPY.Hands,
        legs=EMPY.Legs,
        feet=EMPY.Feete,
        neck={ name="Argute Stole +1", augments={'Path: A',}},
        waist="Sacro Cord",
        left_ear="Malignance Earring",
        right_ear="Regal Earring",
        left_ring="Omega Ring",
        right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        back="Refraction Cape",
--[[ 	main="Daybreak",
    sub="Culminus",
    ammo="Oreiad's Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
	neck="Erra Pendant",
    waist="Eschan Stone",
	left_ear="Hermetic Earring",
	right_ear="Hecate's Earring",
    left_ring="Stikini Ring",
    right_ring="Kishar Ring",
    back="Bookworm's Cape" ]]
    }
	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
        main="Daybreak",
        sub="Ammurapi Shield",
        head=Telchine_ENH_head,
        body=Telchine_ENH_body,
        hands=Telchine_ENH_hands,
        legs=Telchine_ENH_legs,
        feet=Telchine_ENH_feet,
        waist="Embla Sash",
    --[[ head="Arbatel bonnet +1",
    body="Pedagogy gown",
    hands="Arbatel Bracers +1",
    legs="Portent Pants",
    feet="Rubeus Boots",
	neck="Incanter's Torque",
    waist="Olympus Sash",
	left_ear="Mimir Earring",
	right_ear="Hecate's Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Merciful Cape", ]]
    })
    sets.midcast.storm = set_combine(sets.midcast.enhancing,{

    })       
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
	--left_ear="Earthcry Earring",legs="Haven Hose",
        waist="Siegel Sash",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
	--head="Amalric Coif",
        waist="Embla Sash",
    })
    sets.midcast.aquaveil = sets.midcast.refresh
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
        feet={ name="Agwu's Pigaches", augments={'Path: A',}},
        left_ring="Kishar Ring",
        right_ring="Excelsis Ring",
	--[[ main="Daybreak",
    sub="Culminus",
    ammo="Oreiad's Tathlum",
    head="Pixie Hairpin +1",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
	neck="Erra Pendant",
    waist="Eschan Stone",
	left_ear="Hermetic Earring",
	right_ear="Hecate's Earring",
    left_ring="Stikini Ring",
    right_ring="Kishar Ring",
    back="Bookworm's Cape", ]]
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
 	sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{ --51%
        main="Daybreak", --30
        sub="Sors Shield",
        ammo="Clarus Stone",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands=Telchine_ENH_hands, --10
        legs="Jhakri Slops +2",
        feet="Mallquis Clogs",
        neck="Phalaina Locket", --4
        waist="Sacro Cord",
        left_ear="Malignance Earring",
        right_ear="Regal Earring",
        left_ring="Omega Ring",
        right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        back="Solemnity Cape", --7
    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		--main="Chatoyant Staff",

    })    

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = {} 	-- leave this empty
	-- Normal hybrid well rounded Regen
    sets.midcast.regen.hybrid = {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head=EMPY.Head,
        body=Telchine_ENH_body,
        hands=Telchine_ENH_hands,
        legs=Telchine_ENH_legs,
        feet=Telchine_ENH_feet,
        waist="Embla Sash",
    }
	-- Focus on Regen Duration 	
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid,{

    }) 
	-- Focus on Regen Potency 	
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid,{

    }) 
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end

