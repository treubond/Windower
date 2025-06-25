include('organizer-lib') -- optional
include('Global-Binds.lua')
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes 	= M('refresh','dt','Phalanx') --,'Phalanx','MEVA','Reraise','town','test')
meleeModes 	= M('normal','aftermath','dt','ACC','SubtleBlow')
THMode 		= M('OFF','ON')
HYBRIDmode 	= M('OFF','ON')
nukeModes 	= M('normal', 'acc')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list
mainWeapon = M('Naegling','Carnwenhan','Sangoma')
subWeapon = M('Ammurapi shield','Kali','Fusetto +2','Demers. Degen +1')
--mainWeapon = M('Carnwenhan','Tauret','Naegling','Sangoma','Twashtar','Marin Staff +1','Daybreak')
--subWeapon = M('Ammurapi shield','Tauret','Gleti\'s Knife','Fusetto +2','Genmei Shield','Duplus Grip')
------------------------------------------------------------------------------------------------------

----------------------------------------------------------
-- Auto CP Cape: Will put on CP cape automatically when
-- fighting Apex mobs and job is not mastered
----------------------------------------------------------
CP_CAPE ={} -- Put your CP cape here	
DYNA_NECK = ""
----------------------------------------------------------

-- Setting this to true will stop the text spam, and instead display modes in a /UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 600    --important to update these if you have a smaller screen
hud_y_pos = 190    --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 8
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here: 
-- ! = ALT
-- ^ = CTRL
	windower.send_command('bind insert gs c nuke cycle')        -- insert to Cycles Nuke element
	windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
	windower.send_command('bind f9 gs c toggle idlemode')       -- F9 to change Idle Mode    
	windower.send_command('bind f11 gs c toggle meleemode')     -- F11 to change Melee Mode  
	windower.send_command('bind !f9 gs c toggle melee') 		-- Alt-F9 Toggle Melee mode on / off, locking of weapons
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind !` input /ja Tenuto <me>') 		-- Alt-` Quick Tenuto Shortcut.
	windower.send_command('bind home gs c nuke enspellup')		-- Home Cycle Enspell Up
	windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
	windower.send_command('bind ^f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
	windower.send_command('bind !f10 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
	windower.send_command('bind F10 gs c toggle matchsc')		-- CTRL-F10 to change Match SC Mode      	
	windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version       
	windower.send_command('bind ^end gs c hud keybinds')        -- CTRL-End to toggle Keybinds  
	windower.send_command('bind f12 gs c toggle THMode')        -- F12 to toggle TH for Horde Lullaby  
	windower.send_command('bind ^f11 gs c toggle HYBRIDmode')    -- CTRL-F11 to toggle HYBRID
	windower.send_command('bind ^- input /ja "Troubadour" <me>') 	--CTRL- Quick Troubadour
	windower.send_command('bind ^= input /ja "Nightingale" <me>') 	--CTRL= Quick Nightingale
	windower.send_command('bind ^` input /ja "Pianissimo" <me>')	--CTRL` Quick Pianissimo


--WEAPONS SKILLS AND SEND COMMANDS
	windower.send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
	windower.send_command('bind ^[ input /ws "Mordant Rime" <t>')
    windower.send_command('bind ^] input /ws "Evisceration" <t>')
	windower.send_command('bind ^\\\\ input /ws "Rudra\'s Storm" <t>')	
	
	--windower.send_command('bind ^[ input //send Europea //gs c WMAG ERS')
   -- windower.send_command('bind ^] input //send Europea //gs c WMAG PAR')
	--windower.send_command('bind ^\\\\ input //send Europea //gs c WMAG SIL')
	
	--windower.send_command('bind ^[ input //send Theroon /ma "Haste II" Devlin')
    --windower.send_command('bind ^] input //send Theroon /ma "Refresh II" Devlin')
	--windower.send_command('bind ^\\\\ input //send Theroon /ma "Phalanx II" Devlin')
	

	--EURO SEND CODES: PAR (Paralyna), SIL (Silena), CRS (Cursna), STO (Stona), ERS (Erase)
	
		
	
	--windower.send_command('bind !q input //send Jetblackblues /follow Gojiras') --FOLLOW COMMAND FOLLOW COMMAND FOLLOW COMMAND FOLLOW COMMAND FOLLOW COMMAND 
	--windower.send_command('bind !a input //send Zinthor /follow Dekar') --FOLLOW COMMAND FOLLOW COMMAND FOLLOW COMMAND FOLLOW COMMAND FOLLOW COMMAND
	
	
function self_command(command)

    local commandArgs = command

    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))

        if commandArgs[1] == 'WMAG' then
            if commandArgs[2] == 'R5' then
                send_command('input /ja "Accession" <me>; wait 1.5; input /ja "Perpetuance" <me>; wait 1.5; input /ma "Regen V" <me>')
                add_to_chat(8, '[SEND COMMAND - SELF: AOE REGEN 5]')
            elseif commandArgs[2] == 'P5' then
                send_command('input /ja "Accession" <me>; wait 1.5; input /ma "Protect V" <me>')
                add_to_chat(8, '[SEND COMMAND - SELF: AOE PROTECT 5]')
            elseif commandArgs[2] == 'S5' then
                send_command('input /ja "Accession" <me>; wait 1.5; input /ma "Shell V" <me>')
                add_to_chat(8, '[SEND COMMAND - SELF: AOE SHELL]')
            end
        end

        if commandArgs[1] == 'BMAG' then
            if commandArgs[2] == 'S1' then
                send_command('input /ja "Manifestation" <me>; wait 1.5; input /ma "Sleep" <t>')
                add_to_chat(8, '[SEND COMMAND - SELF: AOE SLEEP]')
            elseif commandArgs[2] == 'DISPEL' then
                send_command('input /ja "Manifestation" <me>; wait 1.5; input /ma "Dispel" <t>')
                add_to_chat(8, '[SEND COMMAND - SELF: AOE DISPEL]')
            end
        end
	end
end	
	
	
--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_melee'] = '(F11)'
keybinds_on['key_bind_HYBRIDmode'] = '(CTR-F11)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_THMode'] = '(F12)'
keybinds_on['key_bind_mainweapon'] = '(ALT-F8)'
keybinds_on['key_bind_subweapon'] = '(CTR-F8)'
keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
keybinds_on['key_bind_enspell_cycle'] = '(HOM + pUP)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(F10)'
send_command('gs c hud hidejob')
send_command('gs c hud keybinds')
--send_command('lua l gearinfo')
--send_command('lua l equipviewer')
--send_command('lua l partybuffs')

-- Remember to unbind your keybinds on job change.
function user_unload()
	send_command('lua u gearinfo')
    send_command('unbind insert')
    send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind !f9')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind f10')
    send_command('unbind f11')
    send_command('unbind ^f11')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind !f10')	
    send_command('unbind `f10')
    send_command('unbind !end')  
    send_command('unbind ^end')
	send_command('unbind ^`')
	send_command('unbind ^[')
    send_command('unbind ^]')	
	send_command('unbind ^\\\\')
	send_command('unbind !q')
	send_command('unbind !a')	
end

include('BRD_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,10) -- Sheet, Book
send_command('wait 10;input /lockstyleset 3')
refreshType = idleModes[1] -- leave this as is  
   
function sub_job_change(new,old)
send_command('wait 10;input /lockstyleset 3')
end

-- Setup your Gear Sets below:
function get_sets()
--///////////////////
--Gear Sets
--///////////////////
	--This creates a constant of whole armor sets, so that when you upgrade a piece, its much simpler, 
	--and upgrades that piece through all of your sets. 
	--ADD +1/2 TO ARMOR SET TO UPGRADE IT. 
	--ADD NEW .TYPE TO CREATE AUGMENT VARIATIONS OF THE SAME PIECE. 
	--EG. SUC.TP ={name="",augments={}}
	--SOME ARMOR SETS USE ABREVIATIONS FOR THEIR +1/2/3 VARIANTS. 
	--MAKE SURE YOU USE THE ABREVIATED FORMAT. E.G "Atro. Chapeau +1"
--------------------
--//////////////////
--JSE GEAR
--//////////////////		
--------------------
--------------------
--[ARTIFACT ARMOR]-[ART]
--------------------    
	ART = {}		--Leave This Empty
		ART.HED	= ""--"Brioso Roundlet +3"
		ART.BOD	= ""--"Brioso Justaucorps +3"
		ART.HND	= ""--"Brioso Cuffs +3"
		ART.LEG	= ""--"Brioso Cannions +3"
		ART.FEE	= "Brioso Slippers +3"

--------------------
--[RELIC ARMOR]-[REL]
--------------------    
	REL = {}		--Leave This Empty
		REL.HED	= ""--"Bihu Roundlet +3"
		REL.BOD	= "Bihu Justaucorps +3"
		REL.HND	= ""--"Bihu Cuffs +3"
		REL.LEG	= ""--"Bihu Cannions +3"
		REL.FEE	= ""--"Bihu Slippers +3"
		REL.NEK = ""--"Bard's Charm +2"
--------------------
--[EMPERYAN ARMOR]-[EMP]
--------------------    
	EMP = {}		--Leave This Empty
		EMP.HED	= "Fili Calot +2"
		EMP.BOD	= "Fili Hongreline +3"
		EMP.HND	= "Fili Manchettes +2"
		EMP.LEG	= "Fili Rhingrave +2"
		EMP.FEE	= "Fili Cothurnes +2"
--------------------
--[JSE CAPES]-[JSE]
--------------------  
	JSE = {}		--Leave This Empty
--[WS CAPES]
	JSE.WSD={}
		JSE.WSD.STR	= { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --STR WS damage Cape
		JSE.WSD.DEX = "" --DEX WS damage Cape	
		JSE.WSD.AGI	= "" --AGI WS damage Cape
		JSE.WSD.CHR = ""--{name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%',}} --CHR WS damage Cape
		JSE.WSD.INT	= "" --INT WS damage Cape
		JSE.WSD.MND	= "" --MND WS damage Cape
--[CASTING CAPES]
	JSE.FAS={}
		JSE.FAS.CHR	= ""--{name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}} --CHR FAST CAST CAPE
		JSE.FAS.MND	= "" --MND FAST CAST CAPE
		JSE.FAS.INT	= "" --INT FAST CAST CAPE
		
		JSE.SID		= "" --SPELL INTERRUPTION RATE CAPE
	JSE.MAB={}
		JSE.MAB.CHR = "" --MAGIC ATTACK BONUS CAPE
		JSE.MAB.INT = "" --MAGIC ATTACK BONUS CAPE
		JSE.MAB.MND = "" --MAGIC ATTACK BONUS CAPE
--[MELEE CAPES]		
		JSE.CRT		= "" --CRITICAL HIT CAPE
		JSE.STP		= ""--{name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}} --STORE TP CAPE
		JSE.DWL		= "" --Dual wield Cape
		JSE.HAS		= "" --HASTE CAPE
		JSE.DBL		= { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}} --{name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}} --Double Attack TP Cape
--[IDLE CAPES]
	JSE.IDL={}	
		JSE.IDL.REG	= "" --REGEN CAPE
		JSE.IDL.DT	= "" --DT CAPE
		JSE.IDL.RES	= "" --RES CAPE
		JSE.IDL.MEV = ""--{name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Phys. dmg. taken-10%',}} --Magic Evasison Cape (and WALTZ)
--------------------
--//////////////////
--AMBUSCADE GEAR
--//////////////////		
--------------------
--[Inyanga ARMOR]-[INY]
--------------------    
	INY = {}		--Leave This Empty
		INY.HED	= "Inyanga Tiara +1"
		INY.BOD	= "Inyanga Jubbah +2"
		INY.HND	= ""--"Inyanga Dastanas +2"
		INY.LEG	= "Inyanga Shalwar +2"
		INY.FEE	= ""--"Inyanga Crackows +2"
		INY.RNG = ""--"Inyanga Ring"
--------------------
--[AYANMO ARMOR]-[AYA]
--------------------    
	AYA = {}		--Leave This Empty
		AYA.HED	= "Ayanmo Zucchetto +2"
		AYA.BOD	= "Ayanmo Corazza +2"
		AYA.HND	= ""--"Ayanmo Manopolas +2"
		AYA.LEG	= ""--"Ayanmo Cosciales +2"
		AYA.FEE	= ""--"Ayanmo Gambieras +2"
		AYA.RNG = ""--"Ayanmo Ring"

---------------
--Telchine Gear
---------------
	Telchine_ENH_hands = { name="Telchine Gloves", augments={'"Cure" potency +7%','Enh. Mag. eff. dur. +8',}}
	Telchine_ENH_legs = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +8',}}
	Telchine_ENH_feet = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}}

---------------
--GENERIC SETS
---------------
    sets.me = {}        		-- leave this empty
	sets.buff = {} 				-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          -- leave this empty
    sets.weapons = {}			-- leave this empty
--//////////////
--IDLE SETS
--//////////////	
	--USE HOTKEY TO CYCLE IDLE SETS BASED ON CONTENT. 
	--USE PDT/MDT IF FACING AN AOE HAZARD AS A CASTER. 
	--USE REFRESH ALL OTHER TIMES. 	
	--DT/PDT/MDT/BDT CAP AT 50%
	--DT IS ADDITIVE TO PDT/MDT/BDT TOTALS
	--EG: 20DT+30PDT = 50%PDT, WHICH IS THE CAP. 

---------------
--[IDLE]-[REFRESH]-[NORMAL]
---------------
 	sets.me.idle.refresh = {
		range="Daurdabla",
		head={ name="Chironic Hat", augments={'Pet: Attack+11 Pet: Rng.Atk.+11','STR+9','"Refresh"+2','Accuracy+6 Attack+6','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
		body="Artsieq Jubbah",
		hands=EMP.HND,
		legs=INY.LEG,
		feet=EMP.FEE,
		neck="Sanctity Necklace",
		waist="Embla Sash",
		left_ear="Telos Earring",
		right_ear="Ethereal Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
		--[[ range="Gjallarhorn", 
		head="Fili Calot +3",
		body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
		hands="Fili Manchettes +3",
		legs="Assid. Pants +1",
		feet="Volte Gaiters",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Mendicant's Earring",
		right_ear="Gifted Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape", -- 9 Refresh :: 49 PDT :: 26 MDT :: 23 BDT]]
	}	-- 0 Refresh :: 34 PDT :: 40 MDT :: 34 BDT
---------------
--[IDLE]-[REFRESH]-[PDT]
---------------
	sets.me.idle.dt = {
		range="Daurdabla",
		head=EMP.HED,
		body=EMP.BOD,
		hands=EMP.HND,
		legs=INY.LEG,
		feet=EMP.FEE,
		neck="Sanctity Necklace",
		waist="Embla Sash",
		left_ear="Telos Earring",
		right_ear="Ethereal Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
		--[[ range="Gjallarhorn",
		head="Fili Calot +3",
		body="Nyame Mail",
		hands="Fili Manchettes +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's charm +1",
		waist="Plat. Mog. Belt",
		left_ear="Hearty Earring",
		right_ear="Etiolation Earring",
		left_ring="Shadow Ring",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape", -- 5 Refresh :: 50 PDT :: 55 MDT]]
	}	-- 0 Refresh :: 34 PDT :: 40 MDT :: 34 BDT
---------------
--[IDLE]-[REFRESH]-[DYNA]
---------------
	sets.me.idle.MEVA = {
		--[[ range="Gjallarhorn",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		left_ear="Mendicant's Earring",
		right_ear="Gifted Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape", ]]
	} --26 PDT (36 w/ Genmei Shield) :: 41 MDT (w/o Shell V)
	
	
	sets.me.idle.Reraise = {
		-- range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		-- head="Nyame Helm",
		-- body="Annoint. Kalasiris",
		-- hands="Nyame Gauntlets",
		-- legs="Nyame Flanchard",
		-- feet="Nyame Sollerets",
		-- neck="Warder's Charm +1",
		-- waist="Carrier's Sash",
		-- left_ear="Hearty Earring",
		-- right_ear="Etiolation Earring",
		-- left_ring="Defending Ring",
		-- right_ring="Shadow Ring",
		-- back="Moonlight Cape",
	}	-- 5 Refresh :: 50 PDT :: 55 MDT
	
	sets.me.idle.Phalanx = set_combine(sets.me.idle.dt, {
		legs={ name="Chironic Hose", augments={'AGI+2','Attack+1','Phalanx +4','Accuracy+6 Attack+6','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		feet={ name="Chironic Slippers", augments={'"Store TP"+2','Pet: STR+8','Phalanx +4','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		--[[ range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head={ name="Chironic Hat", augments={'Attack+9','STR+7','Phalanx +4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
		body={ name="Chironic Doublet", augments={'Pet: "Regen"+3','CHR+15','Phalanx +4',}},
		hands={ name="Chironic Gloves", augments={'Attack+5','Accuracy+14','Phalanx +4','Accuracy+6 Attack+6',}},
		legs={ name="Chironic Hose", augments={'MND+1','"Subtle Blow"+1','Phalanx +4','Accuracy+3 Attack+3',}},
		feet={ name="Chironic Slippers", augments={'Chance of successful block +2','Pet: STR+8','Phalanx +5','Accuracy+16 Attack+16','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Damage taken-5%',}}, ]]
	})
	
	sets.me.idle.test = {
		--[[ range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Hearty Earring",
		right_ear="Etiolation Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Damage taken-5%',}}, ]]
	}
	
	
---------------
--[IDLE]-[REFRESH]-[DYNA]
---------------
	sets.me.idle.town = {}
---------------
--[RESTING]
---------------
    sets.me.resting = {}
---------------
--[LATENT]-[REFRESH]
---------------
    sets.me.latent_refresh = {--[[ waist="Fucho-no-obi" ]]}  
--//////////////
--MELEE SETS
--//////////////
	--USE HOTKEY TO CYCLE MELEE SETS BASED ON CONTENT. 
	--USE ACC WHEN YOU CANT HIT, AND PDT/MDT IF FACING AN AOE HAZARD	
	--DT/PDT/MDT/BDT CAP AT 50%
		--DT IS ADDITIVE TO PDT/MDT/BDT TOTALS
		--EG: 20DT+30PDT = 50%PDT, WHICH IS THE CAP. 
	--NOTE:DONT DISCOUNT SWORD AND BOARD SUB PLD/WAR/BLU TANKING, OR /THF FARMING. 
		--WE GET A STUPID POWERFUL SHIELD IN THE BEATIFIC SHIELD, WHICH GIVES +25%MDT, AND BLOCK RATES. 
		--WE CAN EASILY SIT AT CAPPED REDUCTION WITHOUT HURTING OUR ABILITY TO PERFORM MUCH.
---------------	
--[MELEE]-[NORMAL]
---------------
--Only need to Add Dual wield + to dual wield specific sets
--Set names are "Set" "Melee type" "Hybrid Toggle"
-- E.G. Your "Normal" "Dualwield" "Hybrid set", would be normaldwdt
-- E.G.  your "Normal" "Dualwield" set would be "normaldw"
--Set combine flow is  NormalSW > NormalDW & NormalSWDT > NormalDWDT
    sets.me.melee.normalsw 		={
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		head=AYA.HED,
		body=AYA.BOD,
		hands=EMP.HND,
		legs="Nyame flanchard",
		feet=EMP.FEE,
		neck={ name="Bard's Charm +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Lehko's Ring",
		back=JSE.DBL,
		--[[ range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head="Ayanmo zucchetto +2",
		neck="bard's charm +1",
		ear1="Telos Earring",
		ear2="Brutal Earring",
        body="Ayanmo Corazza +2",
		hands="Bunzi's Gloves",
		ring1="Ilabrat ring",
		ring2="Lehko's Ring",
        back=JSE.DBL,
		waist="Sailfi Belt +1",
		legs="Nyame flanchard",
		feet="Nyame sollerets" ]]
	}
	
    sets.me.melee.normalswdt 	=set_combine(sets.me.melee.normalsw,{
		ring2="Defending Ring",
		--[[ ring1="Defending Ring",
		ring2="Moonlight Ring" ]]
	}) --45 PDT :: 35 MDT
		
    sets.me.melee.normaldw		=set_combine(sets.me.melee.normalsw, {
		--[[ back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
		legs={ name="Chironic Hose", augments={'CHR+10','Accuracy+16','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
		ear2="Eabani Earring",
		waist="Reiki Yotai", ]]			
	})
	
    sets.me.melee.normaldwdt 	=set_combine(sets.me.melee.normalswdt,{
		--waist="Reiki Yotai",
		--ear2="Eabani Earring" old gear in green.  This was also in the set directly above this one.
		--[[ head="Bunzi's Hat",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
		legs={ name="Chironic Hose", augments={'CHR+10','Accuracy+16','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
		ear2="Eabani Earring",
		waist="Reiki Yotai",
		ring1="Defending Ring",
		ring2="Moonlight Ring" ]]
	})
	
---------------
--[MELEE]-[AFTERMATH]
---------------
    sets.me.melee.aftermathsw 	= {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		head=AYA.HED,
		body=AYA.BOD,
		hands=EMP.HND,
		legs="Nyame flanchard",
		feet=EMP.FEE,
		neck={ name="Bard's Charm +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Lehko's Ring",
		back=JSE.DBL,
		--[[ range={ name="Linos", augments={'Accuracy+14','"Store TP"+4','Quadruple Attack +3',}},
		head=AYA.HED,
		neck=REL.NEK,
		ear1="Telos Earring",
		ear2="Brutal Earring",
        body="Ashera Harness",
		hands={ name="Chironic Gloves", augments={'Enmity+2','Pet: CHR+9','"Store TP"+9','Accuracy+13 Attack+13',}},
		ring1="Ilabrat Ring",
		ring2="Lehko's Ring",
		back=JSE.STP,
		waist="Sailfi Belt +1",
		legs={ name="Chironic Hose", augments={'CHR+10','Accuracy+16','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
		feet={ name="Chironic Slippers", augments={'"Store TP"+6','Attack+7','Accuracy+19 Attack+19',}}, ]]
	}
	
    sets.me.melee.aftermathswdt = set_combine(sets.me.melee.aftermathsw,{
		--[[ hands="Bunzi's Gloves",
		ring1="Defending Ring",
		ring2="Moonlight Ring", ]]
	})
	
    sets.me.melee.aftermathdw 	= set_combine(sets.me.melee.aftermathsw,{
		--waist="Reiki Yotai",
		--ear2="Eabani Earring",
		--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	})	
		
    sets.me.melee.aftermathdwdt = set_combine(sets.me.melee.aftermathswdt, {
		--waist="Reiki Yotai",
		--ear2="Eabani Earring",
		--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	})
		
---------------  
--[MELEE]-[ACC]
---------------
    sets.me.melee.ACCsw 	= {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		head=AYA.HED,
		body=AYA.BOD,
		hands=EMP.HND,
		legs="Nyame flanchard",
		feet=EMP.FEE,
		neck={ name="Bard's Charm +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Lehko's Ring",
		back=JSE.DBL,
		--[[ range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head=AYA.HED,
		body="Ashera Harness",
		hands=AYA.HND,
		legs=AYA.LEG,
		feet=AYA.FEE,
		neck=REL.NEK,
		waist="Grunfeld Rope",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back=JSE.DBL,	 ]]
	} --36 PDT :: 19 MDT (48 MDT w/ Shell V)
	
	sets.me.melee.ACCswdt 	= set_combine(sets.me.melee.ACCsw, {
		--[[ ring1="Defending Ring",
		hands="Bunzi's Gloves",
		ring2="Moonlight Ring" ]]
		}) --35 PDT :: 35 MDT
		
	sets.me.melee.ACCdw 	= set_combine(sets.me.melee.ACCsw, {
		--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}) --26 PDT :: 19 MDT (48 w/ Shell V)
	
	sets.me.melee.ACCdwdt 	= set_combine(sets.me.melee.ACCswdt, {
		--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},	
	}) --35 PDT :: 35 MDT
---------------
--[MELEE]-[DT]
---------------
    sets.me.melee.dtsw 		= {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		head=EMP.HED,
		body=AYA.BOD,
		hands=EMP.HND,
		legs="Nyame flanchard",
		feet=EMP.FEE,
		neck={ name="Bard's Charm +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Lehko's Ring",
		back=JSE.DBL,
		--[[ range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head="Bunzi's Hat",
		body="Ashera Harness",
		hands="Bunzi's Gloves",
		legs=AYA.LEG,
		feet=AYA.FEE,
		neck="Bard's Charm +1	",
		waist="Sailfi Belt +1",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back=JSE.DBL, ]]
	} --50 PDT :: 38 MDT
	
	sets.me.melee.dtswdt 	= set_combine(sets.me.melee.dtsw, {})
	
	sets.me.melee.dtdw 		= set_combine(sets.me.melee.dtsw, {
		--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}) --40 PDT :: 38 MDT
	
	sets.me.melee.dtdwdt 	= set_combine(sets.me.melee.dtswdt, {
		--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}) --40 PDT :: 38 MDT
	
--SUBTLE BLOW TEST AREA BELOW--	
---------------
--[MELEE]-[SUBTLE BLOW]
---------------
    sets.me.melee.SubtleBlowsw 		= {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		head=AYA.HED,
		body=AYA.BOD,
		hands=EMP.HND,
		legs="Nyame flanchard",
		feet=EMP.FEE,
		neck={ name="Bard's Charm +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Rajas Ring",
		back=JSE.DBL,
		--[[ range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head=AYA.HED,
		body="Ashera Harness",
		hands="Volte Mittens",
		legs="Volte Tights",
		feet={ name="Chironic Slippers", augments={'"Store TP"+6','Attack+7','Accuracy+19 Attack+19',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}, ]]
	} --50 PDT :: 38 MDT
	
	sets.me.melee.SubtleBlowswdt 	= set_combine(sets.me.melee.SubtleBlowsw , {})
	
	sets.me.melee.SubtleBlowdw 		= set_combine(sets.me.melee.SubtleBlowsw , {
		--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
		}) 
		
	sets.me.melee.SubtleBlowdwdt 	= set_combine(sets.me.melee.SubtleBlowsw , {
		--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
		}) 	

--SUBTLE BLOW TEST AREA ABOVE--

--/////////////////
--WEAPONSKILL SECTION
--/////////////////
	--ALL WEAPONSKILLS USE ATTACK, OR MAGIC ATTACK. IT IS LISTED IN THE MODIFIERS SECTION
	--IF A WEAPONSKILL TRANSFERS fTP ACROSS ALL HITS, IT WILL LIST GORGET IN THE MODIFIERS SECTION, THE GORGET MATCHES ANY ELIGIBLE ELEMENTS	

---------------
--[WEAPONSKILL]-[SWORD]-[SAVAGE BLADE]-[MOD:50%MND/50%STR/P.ATTK]-[ELEMENT:Fragmentation/Scission]
---------------
    sets.me["Savage Blade"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		head="Nyame Helm",
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		feet="Nyame Sollerets",
		neck={ name="Bard's Charm +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Cessance Earring",
		left_ring="Lehko's Ring",
		right_ring="Rajas Ring",
		back=JSE.WSD.STR,
		--[[ range="Linos",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Bihu Jstcorps. +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Rajas ring",
		right_ring="Sroda Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+8','Weapon skill damage +10%','Damage taken-5%',}}, ]]
	}

---------------
--[WEAPONSKILL]-[DAGGER]-[]-[]  
---------------
    sets.me["Mordant Rime"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range="Linos",
		head=REL.HED,
		body=REL.BOD,
		hands=REL.HND,
		legs=REL.LEG,
		feet=REL.FEE,
		neck=REL.NEK,
		waist="Grunfeld Rope",
		left_ear="Ishvara Earring",
		right_ear="Regal Earring",
		left_ring="Carb. Ring",
		right_ring="Ilabrat Ring",
		back=JSE.WSD.CHR, ]]
    }
	
---------------
--[WEAPONSKILL]-[DAGGER]-[]-[MOD:80%DEX/P.ATTK]
---------------
    sets.me["Rudra's Storm"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range="Linos",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +1", augments={'Path: A',}},
		waist="Chiner's belt +1",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Ilabrat Ring",
		right_ring="Lehko's Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}, ]]
	}
	
---------------
--[WEAPONSKILL]-[DAGGER]-[EXTENERATOR]-[MOD:85%AGI/P.ATTK/GORGET]-[ELEMENT:FRAGMENTATION/SCISSION]
---------------
    sets.me["Exenterator"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head=REL.HED,
		body=REL.BOD,
		hands="Volte Mittens",
		legs="Volte Tights",
		feet=REL.FEE,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Digni. Earring",
		left_ring="Garuda Ring",
		right_ring="Ilabrat Ring",
		back=JSE.DBL, --This needs to be... uh something? I dunno this ws sucks ]]
    }
	
---------------
--[WEAPONSKILL]-[DAGGER]-[EVISCERATION]-[MOD:50%DEX/P.ATTK/GORGET]-[ELEMENT:GRAVITATION/TRANSFIXION]
---------------
    sets.me["Evisceration"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head=AYA.HED,
		body=REL.BOD,
		hands="Volte Mittens",
		legs="Jokushu Haidate",
		feet=AYA.FEE,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Moonshade Earring",
		left_ring="Begrudging Ring",
		right_ring="Lehko's Ring",
		back=JSE.DBL, --I NEED TO GET A CRIT HIT RATE+ FOR THIS PIECE. ]]
    }
	
---------------
--[WEAPONSKILL]-[DAGGER]-[AEOLIAN EDGE]-[MOD:40%DEX/40%INT/M.ATTK]-[ELEMENT: IMPACTION/SCISSION/DETONATION]
---------------
    sets.me["Aeolian Edge"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range="Linos",
		head="Nyame Helm",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity Necklace",
		waist="Hachirin-no-Obi",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Acumen Ring",
		right_ring="Ilabrat Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%',}},  --This needs to be MAB and WS DMG and INT ]]
    }

---------------
--[WEAPONSKILL]-[DAGGER]-[ENERGY DRAIN]-[MOD:100%MND/NO ATTK MOD]-[ELEMENT:DARK (NO SC ELEMENT)]
---------------
    sets.me["Energy Drain"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range={ name="Linos", augments={'Attack+17','Weapon skill damage +3%','Quadruple Attack +3',}},
		head=ART.HED,
		body=REL.BOD,
		hands=ART.HND,
		legs=REL.LEG,
		feet=INY.FEE,
		neck="Mizu. Kubikazari",
		waist="Luminary Sash",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.WSD.CHR, --This needs to be...MND and WSD? ]]
    }
	
---------------
--[WEAPONSKILL]-[DAGGER]-[ENERGY STEAL]-[MOD:100%MND/NO ATTK MOD]-[ELEMENT:DARK (NO SC ELEMENT)]
---------------
    sets.me["Energy Steal"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range={ name="Linos", augments={'Attack+17','Weapon skill damage +3%','Quadruple Attack +3',}},
		head=ART.HED,
		body=REL.BOD,
		hands=ART.HND,
		legs=REL.LEG,
		feet=INY.FEE,
		neck="Mizu. Kubikazari",
		waist="Luminary Sash",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.WSD.CHR, --This needs to be..MND and WSD? ]]
    }
	
---------------
--[WEAPONSKILL]-[STAFF]-[SHELL CRUSHER]-[MOD:100%STR]-[DETONATION)]
---------------
    sets.me["Shell Crusher"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
		legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
		feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}, ]]
    }	
	
	
---------------
--[WEAPONSKILL]-[STAFF]-[SHATTERSOUL]-[MOD:73~85%INT]-[GRAVITATION/INDURATION)]
---------------
    sets.me["Shattersoul"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range={ name="Linos", augments={'Attack+17','Weapon skill damage +3%','Quadruple Attack +3',}},
		head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
		legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
		feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Regal Earring",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Ilabrat Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}, ]]
    }	
	
	
---------------
--[WEAPONSKILL]-[STAFF]-[RETRIBUTION]-[MOD:50% MND/30% STR]-[GRAVITATION/RREVERBERATION)]
---------------
    sets.me["Retribution"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range={ name="Linos", augments={'Attack+17','Weapon skill damage +3%','Quadruple Attack +3',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Grunfeld Rope",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Ilabrat Ring",
		right_ring="Rajas Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%',}}, ]]
	}
	
---------------
--[WEAPONSKILL]-[STAFF]-[CATACLYSM]-[MOD:30% STR/30% INT]-[GRAVITATION/REVERBERATION)]
---------------
    sets.me["Cataclysm"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range={ name="Linos", augments={'Attack+17','Weapon skill damage +3%','Quadruple Attack +3',}},
		head="Pixie Hairpin +1",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Bunzi's Gloves",
		legs="Nyame Flanchard",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity Necklace",
		waist="Hachirin-no-Obi",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Archon Ring",
		right_ring="Acumen Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%',}}, ]]
    }		

---------------
--[WEAPONSKILL]-[CLUB]-[FLASH NOVA]-[MOD:50% STR/50% MND]-[REVERBERATION/INDURATION)]
---------------
    sets.me["Flash Nova"] = {
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+1','Quadruple Attack +3',}},
		body=REL.BOD,
		hands={ name="Chironic Gloves", augments={'Rng.Acc.+3','STR+8','Weapon skill damage +8%',}},
		legs={ name="Chironic Hose", augments={'"Dbl.Atk."+1','Attack+26','Weapon skill damage +9%','Accuracy+20 Attack+20',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		back=JSE.WSD.STR,
		--[[ range={ name="Linos", augments={'Attack+17','Weapon skill damage +3%','Quadruple Attack +3',}},
		head="Nyame Helm",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Bunzi's Gloves",
		legs="Nyame Flanchard",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity Necklace",
		waist="Luminary Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Rufescent Ring",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%',}}, ]]
    }

	sets.me["Shining Strike"] = set_combine(sets.me["Flash Nova"],{	
	})
	
	sets.me["Seraph Strike"] = set_combine(sets.me["Flash Nova"],{	
	})
	
--////////////////
--Spellcasting sets
--////////////////
---------------
--[CASTING SETS]
---------------
    sets.precast = {}   			--Leave This Empty
    sets.midcast = {}    			--Leave This Empty
    sets.aftercast = {}  			--Leave This Empty
    sets.midcast.nuking = {}		--Leave This Empty
    sets.midcast.MB	= {}			--Leave This Empty  
    sets.midcast.enhancing = {} 	--Leave This Empty
	sets.midcast.Enfeebling = {} 	--Leave This Empty
	sets.midcast.cure = {} 			--Leave This Empty
	sets.midcast.songs = {}
---------------
--[JOB ABILITIES]	
---------------
	sets.precast["Soul Voice"] 		= {legs=REL.LEG,}
	sets.precast["Pianissimo"] 		= {}
	sets.precast["Nightingale"] 	= {feet=REL.FEE,}
	sets.precast["Troubadour"] 		= {body=REL.BOD,}
	sets.precast["Tenuto"] 			= {}
	sets.precast["Marcato"]			= {}
	sets.precast["Clarion Call"] 	= {}
	sets.precast["Curing Waltz"] 	= {back=JSE.IDL.MEV,}	
	sets.precast["Curing Waltz II"] = {back=JSE.IDL.MEV,}	
	sets.precast["Curing Waltz III"]= {back=JSE.IDL.MEV,}	
	sets.precast["Curing Waltz IV"] = {back=JSE.IDL.MEV,}	
	sets.precast["Curing Waltz V"] 	= {back=JSE.IDL.MEV,}	
	sets.precast["Healing Waltz"] 	= {}	
	sets.precast["Divine Waltz"] 	= {back=JSE.IDL.MEV,}

---------------
--[PRECASTING]-[FAST CAST]
--[FAST CAST]: +30TRAIT|+8GIFT|GEAR NEEDS MIN+42 MAX+50, REDUCE FOR GIFTS
--	[TRAIT TOTAL]	: +30
--	[GIFT TOTAL]	: +0
--	[GEAR TOTAL]	: +50 (Exactly at cap)
--[RECAST] - RECAST CAPS AT 80%
--	[TRAIT TOTAL]			: +15
--	[GIFT TOTAL]			: +0
--	[GEAR HASTE TOTAL]		: +22
--	[GEAR FAST CAST TOTAL]	: +25
--	[MAGIC HASTE2]			: +30
--	[GRAND TOTAL]			: +92 (overcapped by 10)
--WITH MAX FAST CAST GIFTS, GEAR, AND SPELL HASTE, YOU NEED 20 HASTE ON YOUR GEAR TO CAP RECASTING TIME
--RECASTING TIME ONLY BENEFITS SPELLS WITH NO DIRECT MODIFIERS, LIKE UTSUSEMI. IT IS POSSIBLE TO GET A 9 SECOND RECAST ON UTSU NI. 
--NON MOD SPELLS DEFAULT TO PRECASTING FOR THEIR MIDCASTING SETS
--TL/DR GET 20-24 HASTE, AND CAP FASTCAST ON THIS SET NO MATTER WHAT. 
---------------
    sets.precast.casting = {
		--sub="Culminus",
		--range="Gjallarhorn",
		head=EMP.HED,
		body=INY.BOD, -- 14
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs=INY.LEG,
		feet=EMP.FEE, -- 10
		neck="Voltsurge Torque", --4
		waist="Embla Sash", -- 5
		left_ear="Aredan Earring",
		right_ear="Ethereal Earring",
		left_ring="Kishar Ring", -- 4
		right_ring="Stikini Ring +1",
		back="Fi Follet Cape +1", -- 10
		--[[ range={ name="Linos", augments={'Attack+15','Weapon skill damage +3%','Quadruple Attack +3',}},
		head="Fili Calot +3",
		body=INY.BOD, --14
		hands="Fili Manchettes +3",
		legs="Ayanmo cosciales +1",
		feet="Fili Cothurnes +3",
		neck="Voltsurge Torque", --4
		waist="Embla Sash", --5
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring", --1
		left_ring="Kishar Ring", --4
		right_ring="Defending Ring", --2
		back=JSE.FAS.CHR, --10 ]]
    }	--68 FC in gear
	
    sets.precast.songs = { -- 69
		--sub="Culminus",
		range="Gjallarhorn",
		head=EMP.HED, -- 15 (songs)
		body=INY.BOD, -- 14
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, -- 7
		legs=INY.LEG,
		feet=EMP.FEE, -- 10
		neck="Voltsurge Torque", -- 4
		--neck="Mnbw. Whistle +1",
		waist="Embla Sash", -- 5
		left_ear="Aredan Earring",
		right_ear="Ethereal Earring",
		left_ring="Kishar Ring", -- 4
		right_ring="Stikini Ring +1",
		back="Fi Follet Cape +1", -- 10
		--[[ sub="Genmei Shield",
		range="Gjallarhorn",
		head="Fili Calot +3", -- 16
		body="Inyanga Jubbah +2", -- 14
		hands="Gendewitha Gages", -- 7
		legs="Aya. Cosciales +2", -- 6
		feet="Fili Cothurnes +3", -- 13
		neck="Voltsurge Torque", -- 4
		waist="Embla Sash", -- 5
		left_ear="Mendi. Earring",
		right_ear="Gifted Earring",
		left_ring="Kishar Ring", -- 4
		right_ring="Prolix Ring", -- 2
	    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+1','"Fast Cast"+10',}}, -- 10]]
    }	--88 FC (git gud fast cast)
---------------
--[PRECASTING]-[HONOR MARCH]
--LEAVE THIS BLANK. THIS FORCES YOU BACK INTO YOUR FAST CAST SET
---------------
    sets.precast["Honor March"] = set_combine(sets.precast.songs,{range="Marsyas",})
	
---------------
--[PRECASTING]-[DISPELGA]
--LEAVE THIS BLANK. THIS FORCES YOU BACK INTO YOUR FAST CAST SET
---------------
    sets.precast["Dispelga"] = set_combine(sets.precast.casting,{main="Daybreak",})
	
---------------
--[PRECASTING]-[STUN]
--LEAVE THIS BLANK. THIS FORCES YOU BACK INTO YOUR FAST CAST SET
---------------
    sets.precast["Stun"] = set_combine(sets.precast.casting,{})
	
---------------
--[PRECASTING]-[ENHANCING]
--LEAVE THIS BLANK UNLESS USING AN ENHANCING MAGIC SPELL CASTING TIME DOWN PIECE IN PLACE OF FAST CAST
---------------
    sets.precast.enhancing = set_combine(sets.precast.casting,{waist="Siegel Sash"}) --8 (76% FC Total w/o Kali) 	
	
---------------
--[PRECASTING]-[STONESKIN]
--LEAVE THIS BLANK UNLESS USING A STONESKIN SPELL CASTING TIME DOWN PIECE IN PLACE OF FAST CAST
---------------
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{head="Umuthi Hat",}) --15  (83% FC Total w/o Kali)
		
---------------
--[PRECASTING]-[CURE]
--LEAVE THIS BLANK UNLESS USING A CURE SPELL CASTING TIME DOWN PIECE IN PLACE OF FAST CAST
---------------
    sets.precast.cure = set_combine(sets.precast.casting,{
		--feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --15
		--ear1="Mendicant's Earring"
	}) --(88% FC Total w/o Kali)

--//////////////////
--MIDCASTING
--EACH SET IN THIS GROUP NEEDS TO BE TAILORED TO MATCH WHAT YOU ARE DOING. IF A PIECE IS LEFT UNSPECIFIED, IT WILL DEFAULT
--TO THE GENERIC CASTING SET FOR THAT SLOT. A RECOMMENDED STRATEGY IS TO SET THIS SET TO 'CONSERVE MP' TO CATCH SPELLS THAT DO NOT
--HAVE A SPECIFIED CASTING SET ATTACHED TO THEM TO MINIMIZE THEIR MP DRAIN
--EG. SPELLS LIKE BLINK	

	sets.midcast["Curing Waltz"] = {
		--[[ range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head={ name="Telchine Cap", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +9',}},
		legs="Dashing Subligar",
		feet={ name="Telchine Pigaches", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Damage taken-5%',}}, ]]
	}	
	
	sets.midcast["Curing Waltz II"] = {
		--[[ range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head={ name="Telchine Cap", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +9',}},
		legs="Dashing Subligar",
		feet={ name="Telchine Pigaches", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Damage taken-5%',}}, ]]
	}	
	
	sets.midcast["Curing Waltz III"] = {
		--[[ range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head={ name="Telchine Cap", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +9',}},
		legs="Dashing Subligar",
		feet={ name="Telchine Pigaches", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Damage taken-5%',}}, ]]
	}		
		
	sets.midcast["Divine Waltz"] 	= {
		--[[ range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head={ name="Telchine Cap", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +9',}},
		legs="Dashing Subligar",
		feet={ name="Telchine Pigaches", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Damage taken-5%',}}, ]]
	}
	
	sets.midcast["Healing Waltz"] 	= {}
	
	sets.midcast["Curing Waltz IV"] = {back=JSE.IDL.MEV,}	
	sets.midcast["Curing Waltz V"] 	= {back=JSE.IDL.MEV,}
	
---------------
--[MIDCASTING]-[ELEMENTAL OBI]
--USE THIS IF YOU HAVE YOUR OBI
---------------
    sets.midcast.Obi = {--[[ Waist = "Hachirin-no-obi" ]]}
---------------
--[MIDCASTING]-[ORPHEUS SASH]
--USE THIS IF USING AN ORPHEUS SASH
---------------
    sets.midcast.Orpheus = {}  

---------------
--[MIDCASTING]-[DEFAULT]
--GENERAL CASTING - WILL BE THE DEFAULT SET UNLESS SPELL BEING CAST IS A PART OF ANOTHER SPECIFIED GROUP.
--EG. GETS REPLACED BY ANY SPELLS IN THE NUKING CATEGORY WITH THE NUKING NORMAL SET. 
---------------
    sets.midcast.casting = {

    }
	
---------------
--[MIDCASTING]-[NUKING]
---------------
    sets.midcast.nuking.normal = {
		--[[ main="Daybreak",
		sub="Ammurapi Shield",
		range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Sanctity Necklace",
		waist="Channeler's Stone",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Twilight Cape", ]]
	}
	
	sets.midcast.Banish = {
		--[[ main="Daybreak",
		sub="Ammurapi Shield",
		range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Sanctity Necklace",
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Metamorph Ring +1",
		back="Twilight Cape", ]]
	}
	
	sets.midcast.Holy = {
		--[[ main="Daybreak",
		sub="Ammurapi Shield",
		range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		neck="Sanctity Necklace",
		waist="Refoccilation Stone",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Metamorph Ring +1",
		back="Twilight Cape", ]]
	}
	
---------------
--[MIDCASTING]-[MAGIC BURSTING]
--USES MAGIC BURST PIECES WHEN CASTING A MAGIC BURST. 
--USE F10 TO TURN ON MAGIC BURSTING. THIS WILL TURN OFF NORMAL NUKING, 
--SHOULD ONLY BE USED IF PURELY BURSTING. ALL OTHER SITUATIONS KEEP IT OFF. 
--RECCOMENDED TO SWAP INTO A STAFF IF DOING FULL BURSTING OFF OF YOUR OWN SC. 
--GS WILL AUTO RE-EQUIP MELEE WEAPONS AFTER CAST. 
---------------
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {})
---------------
--[MIDCASTING]-[MAGIC ACCURACY]
--USE THIS SET WHEN IN MAGIC ACCURACY MODE
---------------
    sets.midcast.nuking.acc = {

	}
---------------
--[MIDCASTING]-[MAGIC BURSTING MAGIC ACCURACY]
-- SEE MAGIC BURST SET FOR DETAILS. 
--USES THIS SET WHEN IN MAGIC ACCURACY MODE
---------------
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {})	
---------------
--[MIDCASTING]-[] --blank template for specific spells
---------------
    --sets.midcast[""] = {}

---------------
--[MIDCASTING]-[ENFEEBLING MAGIC ACCURACY]
---------------
    sets.midcast.Enfeebling.macc = {
		--[[ main="Daybreak",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Fili calot +3",
		body="Fili Hongreline +3",
		hands="Fili manchettes +3",
		legs="Inyanga shalwar +2",
		feet="Fili Cothurnes +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Metamorph Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, --I need a specific cape for this. ]]
    }
	
	 sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeebling.macc,{main="Daybreak",})
	 
---------------
--[MIDCASTING]-[ENFEEBLING Raw Potency]
---------------
    sets.midcast.Enfeebling.potency = {
		--[[ main={ name="Carnwenhan", augments={'Path: A',}},
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Fili calot +3",
		body="Fili hongreline +3",
		hands="Fili manchettes +3",
		legs="Inyanga shalwar +2",
		feet="Brioso slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, --I need a specific cape for this. ]]
	}
---------------
--[MIDCASTING]-[ENFEEBLING MIND]
---------------
    sets.midcast.Enfeebling.mndpot = {
		--[[ main={ name="Carnwenhan", augments={'Path: A',}},
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Fili calot +3",
		body="Fili hongreline +3",
		hands="Fili manchettes +3",
		legs="Inyanga shalwar +2",
		feet="Fili Cothurnes +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, --I need a specific cape for this. ]]
    }
---------------
--[MIDCASTING]-[ENFEEBLING MIND & SKILL]
---------------
    sets.midcast.Enfeebling.skillmndpot = {
		--[[ main="Daybreak",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Fili calot +3",
		body="Fili hongreline +3",
		hands="Fili manchettes +3",
		legs="Inyanga shalwar +2",
		feet="Brioso slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, --I need a specific cape for this.	 ]]
	}
---------------
--[MIDCASTING]-[ENFEEBLING INTELLIGENCE]
---------------
    sets.midcast.Enfeebling.intpot = {
		--[[ main="Daybreak",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Fili calot +3",
		body="Fili hongreline +3",
		hands="Fili manchettes +3",
		legs="Inyanga shalwar +2",
		feet="Brioso slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, --I need a specific cape for this. ]]
    }
---------------
--[MIDCASTING]-[ENFEEBLING SKILL]
---------------
    sets.midcast.Enfeebling.skillpot = {
		--[[ main="Daybreak",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Fili calot +3",
		body="Fili hongreline +3",
		hands="Fili manchettes +3",
		legs="Inyanga shalwar +2",
		feet="Brioso slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, --I need a specific cape for this. ]]
    }
	
---------------
--[MIDCASTING]-[STUN]
---------------
	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {})

---------------
--[MIDCASTING]-[ENHANCING DURATION (SELF)]
---------------
    sets.midcast.enhancing.duration = {
		hands=Telchine_ENH_hands,
		legs=Telchine_ENH_legs,
		feet=Telchine_ENH_feet,
		sub="Ammurapi Shield",
		waist="Embla Sash",
		--[[ main=Carnwenhan,
		sub="Ammurapi Shield",
		range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head={ name="Telchine Cap", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +8',}},
		feet={ name="Telchine Pigaches", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		neck="Colossus's Torque",
		waist="Embla Sash",
		left_ear="Andoaa Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, ]]
    }
---------------
--[MIDCASTING]-[ENHANCING POTENCY (SELF)]
---------------
    sets.midcast.enhancing.potency = set_combine(sets.midcast.enhancing.duration, {

    })

---------------
--[MIDCASTING]-[ENHANCING DURATION (OTHERS)]
--USE EMPY SET, OR ENHANCING MAGIC DURATION +15% OR GREATER. 
--EMPY SET GIVES FOR PIECES 2-5 +10%/20%/35%/50%. THIS MEANS ARTIFACT GLOVES+1 > EMPY GLOVES+1
--EMPY BOOTS GIVE A MASSIVE +35-45% BONUS IF USED WITH AT LEAST ONE OTHER PIECE.
--SET BONUS STACKS ACROSS UPGRADE LEVELS. 
---------------

---------------
--[MIDCASTING]-[PHALANX]
--TAEON CAN BE AUGMENTED WITH +1-3 PHALANX USING DUSKDIM STONES. 
--+15PHALANX CAN LET YOU IMMORTAL MODE TRASH MOBS. 
--PHALANX CAPS AT -35 DAMAGE FROM SKILL. THIS LETS YOU GET -50 DAMAGE, AND BE BASICALLY IMMORTAL TO 
--MOST TRASH UP TO AND INCLUDING ESCHA ZITAH IF USING A PDT SET. CAN LET YOU TAKE AS LITTLE AS 50 DAMAGE FROM EVEN APEX MOBS.  
---------------
    sets.midcast.phalanx ={
		hands=Telchine_ENH_hands,
		legs=Telchine_ENH_legs,
		feet=Telchine_ENH_feet,
		left_ring="Stikini Ring +1",
		--[[ range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head={ name="Telchine Cap", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +8',}},
		feet={ name="Telchine Pigaches", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
		neck="Colossus's Torque",
		waist="Embla Sash",
		left_ear="Andoaa Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, ]]
    }
---------------
--[MIDCASTING]-[STONESKIN]
---------------
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.duration, {
		waist="Siegel Sash",
		--[[ ear1="Earthcry Earring",
		neck="Nodens Gorget",
		waist="Siegel Sash",
		legs="Shedir Seraweels",	 ]]
	})
	
---------------
--[MIDCASTING]-[REFRESH]
--HUGELY IMPORTANT. CAN GET REFRESH3 TO ABSURD LEVELS OF RECOVERY
---------------
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
		--back="Grapevine Cape",
		--waist="Gishdubar Sash"
	})
---------------
--[MIDCASTING]-[AQUAVEIL]
---------------
    sets.midcast.aquaveil = set_combine(sets.midcast.refresh, {
		--head={ name="Chironic Hat", augments={'CHR+6','Pet: Mag. Acc.+6','"Refresh"+1','Accuracy+3 Attack+3','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		--legs="Shedir Seraweels",
		})

---------------
--[MIDCASTING]-[CURE]
--CURE POTENCY CAPS AT 50%. 
--PRIORITIZE HEALING MAGIC SKILL > CURE POTENCY. RDMS HEALING MAGIC IS VERY LOW. 
--BECAUSE CURE POT IS A % INCREASE, IT PERFORMS BETTER IF WE INCREASE ITS BASE VALUE THROUGH HEALING SKILL. 
---------------
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		--[[ main=Carnwenhan,
		sub="Genmei Shield",
		range={ name="Linos", augments={'Mag. Evasion+13','Phys. dmg. taken -4%','HP+15',}},
		head={ name="Kaykaus Mitra +1", augments={'MND+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		legs={ name="Kaykaus Tights +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Mendi. Earring",
		right_ear="Magnetic Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Damage taken-5%',}}, ]]
	}) --55 Cure Potency :: 14 Cure Potency II :: -30 Enmity :: 28 Fast Cast
	
---------------
--[MIDCASTING]-[CURE WEATHER]
---------------
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		--[[ waist="Hachirin-no-obi",
		back="Twilight Cape", ]]		
    })   
	
---------------
--[MIDCASTING]-[REGEN+]
--RDM ONLY GETS REGEN 2. NEED TO MAX OUT ITS POWER USING GEAR
--BOLELABUNGA GIVES +10%
--TELCHINE BODY GIVES +12 SECONDS (EXTENDED UNDER COMPOSURE)
--TELCHINE GIVES +3 POTENCY AUGMENT PER PIECE USING DUSKDIM AUGMENTATION, FOR +15 TOTAL HP
--RDM CAN GET REGEN 2 UP TO 30 HP PER TIC, WHICH IS INCREDIBLY STRONG - ALMOST AS STRONG AS A FULL POWER REGEN 5  
---------------
	sets.midcast.regen = set_combine(sets.midcast.enhancing.duration, {
		main="Bolelabunga",
		head=INY.HED,
		hands=Telchine_ENH_hands,
		legs=Telchine_ENH_legs,
		feet=Telchine_ENH_feet,
		--body={ name="Telchine Chas.", augments={'"Waltz" potency +5%','Enh. Mag. eff. dur. +10',}},
    })

--------------
--[MIDCASTING]-[SONGS]
--------------

	sets.midcast.songs.normal = { -- +7 by default
		--sub="Ammurapi Shield",
		main="Carnwenhan",
		range="Gjallarhorn", -- +4
		head=EMP.HED,
		body=EMP.BOD,
		hands=EMP.HND,
		legs=INY.LEG,
		feet=ART.FEE,
		neck="Mnbw. Whistle +1", -- +3
		waist="Embla Sash",
		left_ear="Aredan Earring",
		right_ear="Ethereal Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back=JSE.DBL,
		--[[ main="Carnwenhan",
		sub="Genmei Shield",
		-- range="Gjallarhorn",
		-- head="Fili Calot +3",
		-- body="Fili Hongreline +3",
		-- hands="Fili Manchettes +3",
		-- legs="Inyanga Shalwar +2",
		-- feet="Brioso Slippers +3",
		-- neck="Mnbw. Whistle +1",
		-- waist="Flume Belt +1",
		-- left_ear="Genmei Earring",
		-- right_ear="Etiolation Earring",
		-- left_ring="Defending Ring",
		-- right_ring="Moonlight Ring",
		-- back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Damage taken-5%',}},
		range="Gjallarhorn",
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Waltz" potency +10%','Damage taken-5%',}}, ]]
	}
	
	sets.midcast.songs.debuff = {
		main="Carnwenhan",
		--sub="Ammurapi Shield",
		range="Gjallarhorn",
		head=EMP.HED,
		body=EMP.BOD,
		hands=EMP.HND,
		legs=INY.LEG,
		feet=ART.FEE,
		neck="Mnbw. Whistle +1",
		waist="Embla Sash",
		left_ear="Crep. Earring",
		right_ear="Fili Earring +1",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring +1",
		back=JSE.DBL,
		--[[ main={ name="Carnwenhan", augments={'Path: A',}},
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Fili calot +3",
		body="Fili hongreline +3",
		hands="Fili manchettes +3",
		legs="Inyanga shalwar +2",
		feet="Brioso slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Kobo Obi",
		left_ear="Crepuscular Earring",
		right_ear="Fili Earring +1",
		left_ring="Crepuscular Ring",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, --I probably need a better MACC cape for my debuffs...
		-- sub="Genmei Shield",
		-- range="Gjallarhorn",
		-- head="Bunzi's Hat",
		-- body={ name="Nyame Mail", augments={'Path: B',}},
		-- hands="Fili Manchettes +3",
		-- legs="Inyanga Shalwar +2",
		-- feet={ name="Nyame Sollerets", augments={'Path: B',}},
		-- neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		-- waist="Sailfi Belt +1",
		-- left_ear="Friomisi Earring",
		-- right_ear="Cryptic Earring",
		-- left_ring="Defending Ring",
		-- right_ring="Petrov Ring",
		-- back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}}, ]]
	}
	
	sets.midcast.songs.dummy = {
		head=EMP.HED,
		body="Nyame Mail",
		hands=EMP.HND,
		legs=EMP.LEG,
		feet=EMP.FEE,
		neck="Mnbw. Whistle +1",
		waist="Embla Sash",
		left_ear="Aredan Earring",
		right_ear="Ethereal Earring",
		left_ring="Defending Ring",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
		--[[ head="Nyame Helm",
		body="Ashera Harness",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Ayanmo Ring",
		back="Moonlight Cape", ]]
	}

	sets.midcast.HonorMarch	= set_combine(sets.midcast.songs.normal, {
		range="Marsyas",
		hands=EMP.HND,
	})
	
	sets.midcast.Minuet 	= set_combine(sets.midcast.songs.normal, {
		range="Gjallarhorn",
		body=EMP.BOD,
	})
	
	sets.midcast.Minne 		= set_combine(sets.midcast.songs.normal, {
		range="Gjallarhorn",
		--legs="Mousai Seraweels +1",
	})
	
	sets.midcast.March 		= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",hands=EMP.HND,})
	sets.midcast.Madrigal 	= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",head=EMP.HED,--[[back=JSE.FAS.CHR, ]]})
	sets.midcast.Prelude 	= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",--[[back=JSE.FAS.CHR, ]]})
	sets.midcast.Mambo 		= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",})
	sets.midcast.Mazurka 	= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",})
	sets.midcast.Etude 		= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",--[[head="Mousai Turban +1", ]]})
	sets.midcast.Ballad 	= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",legs=EMP.LEG,})
	sets.midcast.Paeon 		= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",--[[head=ART.HED, ]]})
	sets.midcast.Carol 		= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",--[[hands="Mousai Gages +1", ]]})
	
	sets.midcast.NormlLullaby 	= set_combine(sets.midcast.songs.debuff, {
		range="Marsyas", --Duration Instrument. Don't forget to disable the other instruments. 
		--range="Gjallarhorn", --Magic Accuracy Instrument.  Don't forget to disable the other instruments.
		body=EMP.BOD,
		--hands=ART.HND,
		legs=INY.LEG, --(Duration +17% instead of the standard raw MACC of AF Legs)  Simply --the AF Hands to use this
		feet=ART.FEE,
	})
	
	--Marysas gives duration +50% for the longest sleep.  
	--Gjallarhorn gives duration +40% but has the best magic accuracy.  
	--Daurdabla gives duration +30% and needs at least 486 String Skill for max AOE.
	--EMP.LEG -8 Song Reast for quick sleep recast.
	
	sets.midcast.THLullaby 	= set_combine(sets.midcast.songs.debuff, {
		range="Marsyas", --Duration Instrument. Don't forget to disable the other instruments. 
		--range="Gjallarhorn", --Magic Accuracy Instrument.  Don't forget to disable the other instruments.
		--[[ body=ART.BOD,
		hands=ART.HND,
	    legs={ name="Chironic Hose", augments={'Crit.hit rate+2','Pet: Attack+28 Pet: Rng.Atk.+28','"Treasure Hunter"+2','Accuracy+17 Attack+17','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		feet={ name="Chironic Slippers", augments={'DEX+4','AGI+5','"Treasure Hunter"+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}}, ]]
	})
		
	sets.midcast.Threnody 	= set_combine(sets.midcast.songs.debuff, {
		range="Gjallarhorn",
		body=EMP.BOD,
	})
	
	sets.midcast.Elegy 		= set_combine(sets.midcast.songs.debuff, {range="Gjallarhorn",})
	sets.midcast.Requiem 	= set_combine(sets.midcast.songs.debuff, {range="Gjallarhorn",})
	sets.midcast.Finale 	= set_combine(sets.midcast.songs.debuff, {range="Gjallarhorn",legs=EMP.LEG,})
		
	sets.midcast.Scherzo 	= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",feet=EMP.FEE,})
	sets.midcast.Hymnus 	= set_combine(sets.midcast.songs.normal, {range="Marsyas",})
	sets.midcast.Dirge 		= set_combine(sets.midcast.songs.normal, {range="Marsyas",})
	sets.midcast.Sirvente 	= set_combine(sets.midcast.songs.normal, {range="Gjallarhorn",})
	
	sets.midcast["Pining Nocturne"] 	= {
		--[[ main={ name="Carnwenhan", augments={'Path: A',}},
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head=ART.HED,
		body=ART.BOD,
		hands=INY.HND,
		legs=ART.LEG,
		feet=ART.FEE,
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=JSE.FAS.CHR, --I probably need a better MACC cape for my debuffs... ]]
	}
	
	sets.midcast.Virelai 	= set_combine(sets.midcast.songs.debuff, {
		--[[ main={ name="Carnwenhan", augments={'Path: A',}},
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Bunzi's Hat",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Friomisi Earring",
		right_ear="Cryptic Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}}, ]]
	})
	
--------------
--[MIDCASTING]-[DUMMYSONGS]
--------------

-- Type Spell name between "" to have specific set for spell. will join any dummy song gear in by default. 	
	sets.midcast["Army's Paeon"] 	= set_combine(sets.midcast.songs.dummy, {range="Daurdabla",head=ART.HED,neck="Mnbw. Whistle +1",})
	sets.midcast["Army's Paeon II"] = set_combine(sets.midcast.songs.dummy, {range="Daurdabla",head=ART.HED,neck="Mnbw. Whistle +1",})
	sets.midcast["Army's Paeon III"]= set_combine(sets.midcast.songs.dummy, {range="Daurdabla",head=ART.HED,neck="Mnbw. Whistle +1",})
	sets.midcast["Army's Paeon IV"] = set_combine(sets.midcast.songs.dummy, {range="Daurdabla",head=ART.HED,neck="Mnbw. Whistle +1",})
	sets.midcast["Goblin Gavotte"] 	= set_combine(sets.midcast.songs.dummy, {range="Daurdabla",})
	sets.midcast["Herb Pastoral"] 	= set_combine(sets.midcast.songs.dummy, {range="Daurdabla",})
end