--Built off of my BLU GS
---Thanks to various sources such as LS members and BlueGartr for the help building this GearSwap.
--------------------------------------------------------------------------------------------------
--This lua starts off defaulted in tanking TP gear. Press alt + F8 or the following macro to disable tanking TP mode:
---/console gs c toggle TankingTP

--Once that is taken off you will automatically be placed back in the TP set index. If you were previously in a set and put tanking gear back on it will resume the previous set in the index.
---Sets between 1H and 2H weapons are automatically activated after the tanking TP set is off, based on your equiped weapon. 2H weapons get the 2HTP sets and 1H the 1H set.
----This occasionally throws an error for the rule somewhere around line 1871 depending on what you edit, when you first load the lua. I have never bothered to address this bug as it doesnt impact anything.

--Pressing F9 (or a macro, similar to above for tanking) will toggle the currently active set. If tanking is on F9 will toggle tanking TP and ignore the other sets. If 1H TP is active F9 will toggle that and nothing else.
---If 2H TP is active then it will toggle that and AM3 for Epeo, and vice versa.

--Alt + F9 will cycle backwards, F9 just cycles fowards. Useful for pressing buttons once instead of 3 times to cycle one set backwards.
	
--You may cycle tanking TP with alt + f7 regardless of which TPing mode is active. This is useful for using tanking TP sets like MDT or magic evasion as DT sets while DDing with alt + f8 to equip the tanking set back on.


--Augmented Gear--

function get_sets()
	maps()

    --------------------
    --[ARTIFACT ARMOR]-[AF]
    --------------------    
    AF = {}		--Leave This Empty
    AF.Head	= "Runeist Bandeau +2"
    AF.Body	= "Runeist Coat +2"
    AF.Hands = "Runeist Mitons"
    AF.Legs	= "Runeist Trousers"
    AF.Feet	= "Runeist Bottes"

    --------------------
    --[RELIC ARMOR]-[RELIC]
    --------------------    
    RELIC = {}		--Leave This Empty
    RELIC.Head	= "Futhark Bandeau +3"
    RELIC.Body	= "Futhark Coat"
    RELIC.Hands	= "Futhark Mitons"
    RELIC.Legs	= "Futhark Trousers +1"
    RELIC.Feet	= "Futhark Boots"
    RELIC.Neck  = "Futhark Torque +1"
    --------------------
    --[EMPERYAN ARMOR]-[EMPY]
    --------------------    
    EMPY = {}		--Leave This Empty
    EMPY.Head	= "Erilaz Galea +2"
    EMPY.Body	= "Erilaz Surcoat +2"
    EMPY.Hands	= "Erilaz Gauntlets +2"
    EMPY.Legs	= "Eri. Leg Guards +2"
    EMPY.Feet	= "Erilaz Greaves +2"
    EMPY.Earring = ""

	AdhemarJacket = {}
	AdhemarJacket.Accuracy = { name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	AdhemarJacket.FC = { name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}}
	
	HerculeanHelm = {}
    HerculeanHelm.Nuke = { name = "Herculean Helm", augments = { 'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Fast Cast"+1','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+12', } }
    HerculeanHelm.DT = { name = "Herculean Helm", augments = { 'Attack+12', 'Phys. dmg. taken -4%', 'STR+9', 'Accuracy+8', } }
    HerculeanHelm.Refresh = { name = "Herculean Helm", augments = { 'Weapon skill damage +2%','Pet: Accuracy+11 Pet: Rng. Acc.+11','"Refresh"+2', } }
	HerculeanHelm.Reso =  { name="Herculean Helm", augments = {'Accuracy+27','"Triple Atk."+3','STR+3',} }
	
	HerculeanVest = {}
	HerculeanVest.Phalanx = { name="Herculean Vest", augments = {'Chance of successful block +3','Pet: Attack+4 Pet: Rng.Atk.+4','Phalanx +5','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}
    HerculeanVest.CDC  = { name="Herculean Vest", augments={'Accuracy+19 Attack+19','Crit. hit damage +3%','DEX+14','Accuracy+3',}}
	
	AdhemarWrists = {}
	AdhemarWrists.Attack = { name="Adhemar Wrist. +1", augments = {'STR+12','DEX+12','Attack+20',} }
	AdhemarWrists.Accuracy = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',} }
	
	HerculeanGloves = {}
    HerculeanGloves.DT = { name = "Herculean Gloves", augments = { 'Accuracy+13', 'Damage taken-3%', 'AGI+1', 'Attack+5', } }
    HerculeanGloves.Refresh = { name = "Herculean Gloves", augments = { 'Spell interruption rate down -1%','"Repair" potency +4%','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+16 "Mag.Atk.Bns."+16', } }
    HerculeanGloves.Crit = { name = "Herculean Gloves", augments = { 'Attack+23', 'Crit. hit damage +4%', 'DEX+8', 'Accuracy+11', } }
    HerculeanGloves.Phalanx = { name="Herculean Gloves", augments={'INT+5','Pet: "Dbl. Atk."+3','Phalanx +4',}}
    HerculeanGloves.PhysicalSpells = { name="Herculean Gloves", augments={'Accuracy+11 Attack+11','"Triple Atk."+2','STR+10','Accuracy+15','Attack+5', } }
	
	HerculeanLegs = {}
    HerculeanLegs.TH = { name = "Herculean Trousers", augments = { 'INT+5','MND+6','"Treasure Hunter"+1','Mag. Acc.+17 "Mag.Atk.Bns."+17', } }
    HerculeanLegs.Phalanx = { name = "Herculean Trousers", augments = { 'Attack+13','Pet: Haste+4','Phalanx +4', } }
	HerculeanLegs.Refresh = { name = "Herculean Trousers", augments = { 'Pet: INT+3','STR+4','"Refresh"+2','Accuracy+19 Attack+19', } }
	
	LustFeet = {}
	LustFeet.STRDEX = { name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}}
	LustFeet.STRDA = { name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}}
	
	HerculeanFeet = {}
	HerculeanFeet.QA = { name = "Herculean Boots", augments = { 'Enmity-2','Crit.hit rate+1','Quadruple Attack +3','Accuracy+20 Attack+20','Mag. Acc.+16 "Mag.Atk.Bns."+16', } }
    HerculeanFeet.TA = { name = "Herculean Boots", augments = { 'Accuracy+14 Attack+14', '"Triple Atk."+4', 'DEX+3', 'Accuracy+2', 'Attack+15' } }
    HerculeanFeet.STP = { name = "Herculean Boots", augments = { '"Conserve MP"+4','MND+9','"Store TP"+8','Accuracy+10 Attack+10','Mag. Acc.+13 "Mag.Atk.Bns."+13', } }
    HerculeanFeet.Idle = { name = "Herculean Boots", augments = { 'Crit. hit damage +1%','STR+10','"Refresh"+2','Accuracy+15 Attack+15','Mag. Acc.+17 "Mag.Atk.Bns."+17', } }
    HerculeanFeet.DTP = { name = "Herculean Boots", augments = { '"Conserve MP"+4','MND+9','"Store TP"+8','Accuracy+10 Attack+10','Mag. Acc.+13 "Mag.Atk.Bns."+13', } }
    HerculeanFeet.DW = { name = "Herculean Boots", augments = { 'Accuracy+3 Attack+3','"Dual Wield"+4','AGI+3','Accuracy+14', } }
    HerculeanFeet.Phalanx = { name = "Herculean Boots", augments = { '"Store TP"+1','INT+10','Phalanx +3','Accuracy+16 Attack+16','Mag. Acc.+19 "Mag.Atk.Bns."+19' } }
    HerculeanFeet.TH = { name="Herculean Boots", augments = { 'Phys. dmg. taken -2%','Pet: Phys. dmg. taken -2%','"Treasure Hunter"+2','Accuracy+16 Attack+16','Mag. Acc.+18 "Mag.Atk.Bns."+18', } }
	
	Ogma = {}
	--Ogma.STP = { name= "Ogma's cape", augments = { 'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%', } }
	--Ogma.Tank = { name= "Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}
	--Ogma.Parry = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%', } } 
	Ogma.WSD = { name = "Ogma's Cape", augments = { 'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%', } }
	Ogma.SIR = { name="Ogma's Cape", augments={'Enmity+10','Spell interruption rate down-10%',}}
	Ogma.DA = { name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	--Ogma.DA = { name= "Ogma's cape", augments={ 'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%', } }
	--Ogma.FC = { name =  "Ogma's Cape", augments = { 'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%', } }
	--Ogma.Evasion =  { name= "Ogma's Cape", augments={ 'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15', } }
	--Ogma.Cure =  { name= "Ogma's Cape", augments={ 'MND+20','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Phys. dmg. taken-10%', } }
	
------End of Augmented Gear-----------------------------------------------------------------------------------------------------------------------------
	--Idle Sets--
	sets.Idle = {}
	sets.Idle.index = { 'Standard', 'DT', 'Evasion', 'Kiting', 'Phalanx'	}
	Idle_ind = 1

	sets.Idle.Standard = {
		ammo="Yamarang",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body=EMPY.Body,
		hands=EMPY.Hands,
		legs=EMPY.Legs,
		feet=EMPY.Feet,
		neck = "Warder's Charm +1",
		waist = "Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back=Ogma.DA,
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Futhark Torque +2",
		ear1 = "Odnowa Earring +1",
		ear2 = "Erilaz Earring +1",
		body = "Runeist Coat +3",
		hands = "Turms Mittens +1",
		ring2 = "Stikini Ring +1",
		ring1 = "Moonlight Ring",
		back = Ogma.Parry,
		waist = "Plat. Mog. Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Turms Leggings +1", ]]
	}
	
	sets.Idle.DT = {
		ammo = "Staunch Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body=EMPY.Body,
		hands=EMPY.Hands,
		legs=EMPY.Legs,
		feet=EMPY.Feet,
		neck = "Warder's Charm +1",
		waist = "Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Shneddick Ring",
		right_ring="Shadow Ring",
		back=Ogma.DA,
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Warder's Charm +1",
		ear2 = "Tuisto Earring",
		ear1 = "Odnowa Earring +1",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring2 = "Shadow Ring",
		ring1 = "Moonlight Ring",
		back = Ogma.Parry,
		waist = "Plat. Mog. Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Erilaz Greaves +3" ]]
	}
	
	sets.Idle.Evasion = {
		ammo="Yamarang",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body=EMPY.Body,
		hands=EMPY.Hands,
		legs=EMPY.Legs,
		feet=EMPY.Feet,
		neck = "Warder's Charm +1",
		waist = "Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back=Ogma.DA,
		--[[ ammo = "Yamarang",
		head = "Nyame Helm",
		neck = "Bathy Choker +1",
		ear1 = "Eabani Earring",
		ear2 = "Infused Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring2 = "Gelatinous Ring +1",
		ring1 = "Moonlight Ring",
		back = Ogma.Evasion,
		waist = "Kasiri Belt",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets" ]]
	}
	sets.Idle.Kiting = {
		ammo="Yamarang",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body=EMPY.Body,
		hands=EMPY.Hands,
		legs=EMPY.Legs,
		feet=EMPY.Feet,
		neck = "Warder's Charm +1",
		waist = "Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back=Ogma.DA,
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Warder's Charm +1",
		ear2 = "Erilaz Earring +1",
		ear1 = "Odnowa Earring +1",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring2 = "Shadow Ring",
		ring1 = "Moonlight Ring",
		back = Ogma.Parry,
		waist = "Plat. Mog. Belt",
		legs = "Carmine Cuisses +1",
		feet = "Erilaz Greaves +3" ]]
	}
	sets.Idle.Phalanx = {
		head=RELIC.Head,
		body={ name="Herculean Vest", augments={'Attack+2','"Triple Atk."+1','Phalanx +2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Phalanx +3',}},
		Ogma.SIR,
		--[[ ammo="Staunch Tathlum +1",
		head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+14 Rng.Atk.+14','"Conserve MP"+2','Phalanx +4','Accuracy+17 Attack+17',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Herculean Boots", augments={'Enmity+4','STR+8','Phalanx +4',}},
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Audumbla Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Erilaz Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}}, ]]
}
		--Dat Waifu--
	-- sets.Idle.Town = set_combine(sets.Idle.Standard, {
		-- legs = "Carmine Cuisses +1",
	-- })

-------TP Sets-------------------------------------------
	
	---------------------
	--OneHanded TP Sets--
	--------------------- 
	
	sets.OneHandedTP = {}
	sets.OneHandedTP.index = { 'DualWield', 'CapHaste', 'AccuracyLite', 'AccuracyMid', 'AccuracyFull' }
	OneHandedTP_ind = 1
	--+31 needed with just Haste II
	sets.OneHandedTP.DualWield = {
		--[[ ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1",
		neck = "Anu Torque",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Attack,
		ring1 = "Epona's ring",
		ring2 = "Niqmaddu Ring",
		back = Ogma.Parry,
		waist = "Sailfi Belt +1",	
		legs = "Samnuha Tights",
		feet = HerculeanFeet.DW ]]
	}
	
	sets.OneHandedTP.CapHaste = {
		--[[ ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1",
		neck = "Anu Torque",
		ear1 = "Sherida Earring",
		ear2 = "Eabani Earring",
		body = "Ayanmo corazza +2",
		hands = AdhemarWrists.Attack,
		ring1 = "Epona's ring",
		ring2 = "Niqmaddu Ring",
		back = Ogma.Parry,
		waist = "Sailfi Belt +1",
		legs = "Samnuha Tights",
		feet = HerculeanFeet.QA ]]
	}

	sets.OneHandedTP.AccuracyLite = {
		--[[ ammo = "Yamarang",
		head = "Adhemar Bonnet +1",
		neck = "Combatant's Torque",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Attack,
		ring1 = "Epona's ring",
		ring2 = "Niqmaddu Ring",
		back = Ogma.Parry,
		waist = "Kentarch Belt",
		legs = "Samnuha Tights",
		feet = HerculeanFeet.TA ]]
	}

	sets.OneHandedTP.AccuracyMid = {
		--[[ ammo = "Yamarang",
		head = "Adhemar Bonnet +1",
		neck = "Combatant's Torque",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Attack,
		ring1 = "Epona's ring",
		ring2 = "Niqmaddu Ring",
		back = Ogma.Parry,
		waist = "Kentarch Belt +1",
		legs = "Samnuha Tights",
		feet = HerculeanFeet.TA ]]
	}

	sets.OneHandedTP.AccuracyFull = {
		--[[ ammo = "Yamarang",
		head = "Erilaz Galea +3",
		neck = "Combatant's Torque",
		ear1 = "Mache Earring +1",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Accuracy,
		ring1 = "Cacoethic Ring +1",
		ring2 = "Niqmaddu Ring",
		back = Ogma.Parry,
		waist = "Kentarch Belt +1",
		legs = "Erilaz Leg Guards +3",
		feet = HerculeanFeet.CritDmg ]]
	}
	
	---------------------
	--TwoHanded TP Sets--
	--------------------- 
	
	sets.TwoHandedTP = {}
	sets.TwoHandedTP.index = { 'CapHaste', 'AccuracyLite', 'AccuracyMid', 'AccuracyFull' }
	TwoHandedTP_ind = 1

	sets.TwoHandedTP.CapHaste = {
		ammo="Ginsen",
		head="Aya. Zucchetto +2",
		body=AdhemarJacket.Accuracy,
		hands={ name="Herculean Gloves", augments={'AGI+10','Attack+19','Accuracy+20 Attack+20','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		legs=EMPY.Legs,
		feet={ name="Herculean Boots", augments={'Weapon Skill Acc.+8','"Store TP"+2','"Treasure Hunter"+2',}},
		neck="Asperity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Lehko's Ring",
		back=Ogma.DA,
		--[[ ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1",
		neck = "Anu Torque",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Attack,
		ring1 = "Epona's ring",
		ring2 = "Niqmaddu Ring",
		back = Ogma.Parry,
		waist = "Sailfi Belt +1",
		legs = "Samnuha Tights",
		feet = HerculeanFeet.QA ]]
	}

	sets.TwoHandedTP.AccuracyLite = set_combine(sets.TwoHandedTP.CapHaste,{
	--[[{
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1",
		neck = "Combatant's Torque",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Accuracy,
		ring1 = "Epona's ring",
		ring2 = "Niqmaddu Ring",
		back = Ogma.Parry,
		waist = "Sailfi Belt +1",
		legs = "Samnuha Tights",
		feet = HerculeanFeet.TA ]]
	})

	sets.TwoHandedTP.AccuracyMid = set_combine(sets.TwoHandedTP.AccuracyLite,{
		ammo = "Yamarang",
		ear2 = "Cessance Earring",
	--[[{
		ammo = "Yamarang",
		head = "Adhemar Bonnet +1",
		neck = "Combatant's Torque",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Accuracy,
		ring1 = "Epona's ring",
		ring2 = "Niqmaddu Ring",
		back = Ogma.Parry,
		waist = "Sailfi Belt +1",
		legs = "Samnuha Tights",
		feet = HerculeanFeet.TA ]]
	})

	sets.TwoHandedTP.AccuracyFull = set_combine(sets.TwoHandedTP.AccuracyMid,{
		head = EMPY.Head,
		feet = EMPY.Feet,
		neck = "Sanctity Necklace",
		ear1 = "Crep. Earring",
		ring1 = "Chirich Ring +1",
		--[[ ammo = "Yamarang",
		head = "Erilaz Galea +3",
		neck = "Combatant's Torque",
		ear1 = "Mache Earring +1",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = "Turms Mittens +1",
		ring1 = "Chirich Ring +1",
		ring2 = "Chirich Ring +1",
		back = Ogma.Parry,
		waist = "Kentarch Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Erilaz Greaves +3" ]]
	})

	-------------------
	--EpeoAM3 TP Sets--
	------------------- 
	
	sets.EpeoAM3 = {}
	sets.EpeoAM3.index = { 'CapHaste', 'AccuracyLite', 'AccuracyMid', 'AccuracyFull' }
	EpeoAM3_ind = 1 -- In the same rule as the 2H TP Toggle so it toggles it at the same time

	sets.EpeoAM3.CapHaste = set_combine(sets.TwoHandedTP.CapHaste, {		
		--body = "Ashera Harness",
		--ring1 = "Chirich Ring +1",
		--back = Ogma.Parry,
		--waist= "Kentarch Belt +1",
		--feet = HerculeanFeet.STP
		
	})

	sets.EpeoAM3.AccuracyLite = set_combine(sets.TwoHandedTP.AccuracyLite, {		
		--[[ body = "Ashera Harness",
		ring1 = "Chirich Ring +1",
		back = Ogma.Parry,
		waist = "Kentarch Belt +1",
		feet = HerculeanFeet.STP ]]
	})

	sets.EpeoAM3.AccuracyMid = set_combine(sets.TwoHandedTP.AccuracyMid, {		
		--[[ body = "Ashera Harness",
		ring1 = "Chirich Ring +1",
		back = Ogma.Parry,		
		waist = "Kentarch Belt +1",
		feet = HerculeanFeet.STP ]]
	})

	sets.EpeoAM3.AccuracyFull = set_combine(sets.TwoHandedTP.AccuracyFull, {		
		--[[ body = "Ashera Harness",
		ring1 = "Chirich Ring +1",
		back = Ogma.Parry,		
		waist = "Kentarch Belt +1" ]]
	})
	
	-------------------
	--Tanking TP Sets--
	------------------- 
	
	sets.TankingTP = {}
	sets.TankingTP.index = { 'Tank', 'Subtleblow', 'DDHyb', 'MagicRes', 'MagicParry', 'Ailment', 'MagicEva',}
	TankingTP_ind = 1
	
	sets.TankingTP.Tank = {
		ammo="Staunch Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body=EMPY.Body,
		hands=EMPY.Hands,
		legs=EMPY.Legs,
		feet=EMPY.Feet,
		neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Lehko's Ring",
		right_ring="Shadow Ring",
		back=Ogma.DA,
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Futhark Torque +2",
		ear2 = "Erilaz Earring +1",
		ear1 = "Odnowa Earring +1",
		body = "Erilaz Surcoat +3",
		hands = "Turms Mittens +1",
		ring1 = "Moonlight Ring",
		ring2 = "Gelatinous Ring +1",
		back = Ogma.Parry,
	--	back = "Repulse Mantle",
		waist = "Plat. Mog. Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Turms Leggings +1" ]]
	}
	--Capped DT with DD Gear
	sets.TankingTP.Subtleblow = set_combine(sets.TankingTP.Tank, {
		--main={ name="Epeolatry", augments={'Path: A',}},
		--[[ sub="Utu Grip",
		ammo="Expeditious Pinion",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		--bathy choker on neck as needed
		waist="Plat. Mog. Belt",
		left_ear="Digni. Earring",
		right_ear="Sherida Earring",
		left_ring="Rajas Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, ]]
	})
	
	--Low DT with DD Gear
	sets.TankingTP.DDHyb = set_combine(sets.TankingTP.Tank, {
		ammo="Ginsen",
		head = "Aya. Zucchetto +2",
		body = "Ayanmo corazza +2",
		left_ear="Sherida Earring",
		right_ear="Cessance Earring",
		right_ring="Chirich Ring +1",

		--[[ ammo = "Coiste Bodhar",
		head = "Aya. Zucchetto +2",
		neck = "Anu Torque",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = "Ayanmo corazza +2",
		hands = "Adhemar Wrist. +1",
		ring1 = {name = "Moonlight Ring", bag = "wardrobe5"},
		ring2 = "Lehko's ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
		waist = "Goading Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Erilaz Greaves +3" ]]
	})
	--Max resist
	sets.TankingTP.MagicRes = set_combine(sets.TankingTP.Tank, {
		neck = "Warder's Charm +1",
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
--		neck = "Futhark Torque +2",
		neck = "Warder's Charm +1",
		ear1 = "Odnowa Earring +1",
		ear2 = "Erilaz Earring +1",
		body = "Runeist Coat +3",
		hands = "Nyame Gauntlets",
		ring2 = "Shadow Ring",
		ring1 = "Moonlight Ring",
		back = Ogma.Parry,
		waist = "Plat. Mog. Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Erilaz Greaves +3" ]]
	})
	-- M Eva w/ parry
	sets.TankingTP.MagicParry = set_combine(sets.TankingTP.Tank, {
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Futhark Torque +2",
		ear1 = "Odnowa Earring +1",
		ear2 = "Erilaz Earring +1",
		body = "Erilaz Surcoat +3",
		hands = "Turms Mittens +1",
		ring2 = "Shadow Ring",
		ring1 = "Moonlight Ring",
		back = Ogma.Parry,
--		waist = "Engraved Belt",
		waist = "Plat. Mog. Belt", 
		legs = "Erilaz Leg Guards +3",
		feet = "Turms Leggings +1" ]]
	})
    
	sets.TankingTP.Ailment = set_combine(sets.TankingTP.Tank, {
	    --[[ ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Erilaz Gauntlets +3",
		legs="Rune. Trousers +2",
		feet="Erilaz Greaves +3",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Hearty Earring",
		right_ear={ name="Erilaz Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Moonlight Ring",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape", ]]
	})
	
	-- Max M Eva
	sets.TankingTP.MagicEva	= set_combine(sets.TankingTP.Tank, {  --Ongo
		neck = "Warder's Charm +1",
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Warder's Charm +1",
		ear1 = "Odnowa Earring +1",
		ear2 = "Erilaz Earring +1",
		body = "Nyame Mail",
		hands = "Erilaz Gauntlets +3",
		ring2 = "Shadow Ring",
		ring1 = "Moonlight Ring",
		back = Ogma.Parry,
		waist = "Plat. Mog. Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Erilaz Greaves +3" ]]
	})	
	
------End of TP--------------------------------------------------------------------------------------------------------------------	
	---------------------
	-----WS Sets-----
	---------------------
	
	---Greatsword WS  Sets---
	
	sets.WS = {}
	
	sets.Resolution = {}

	sets.Resolution.index = { 'AttackUncap', 'AttackCap', 'Accuracy' }
	Resolution_ind = 1

	sets.Resolution.AttackUncap = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Ilabrat Ring",
		back=Ogma.WSD,
		--[[ ammo = "Coiste Bodhar",
		head = "Erilaz Galea +3",
		neck = "Fotia Gorget",
		ear1 = "Sherida Earring",
		ear2 = "Moonshade Earring",
		body = "Erilaz Surcoat +3",
		hands = "Erilaz Gauntlets +3",
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist = "Fotia Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Erilaz Greaves +3" ]]
	}

	sets.Resolution.AttackCap = set_combine(sets.Resolution.AttackUncap, {
		--[[ ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Ayanmo Corazza +2",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Meg. Chausses +2",
		feet="Erilaz Greaves +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}, ]]
	})
	
	sets.Resolution.Accuracy = set_combine(sets.Resolution.AttackUncap, {
		--[[ ammo = "Voluspa Tathlum",
		head = "Nyame Helm",
		neck = "Fotia Gorget",
		ear1 = "Sherida Earring",
		ear2 = "Moonshade Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Attack,
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = Ogma.DA,
		waist = "Fotia Belt",
		legs = "Meghanada Chausses +2",
		feet = HerculeanFeet.TA ]]
	})	
	
	sets.Dimidiation = {}

	sets.Dimidiation.index = { 'AttackUncap', 'AttackCap', 'Accuracy' }
	Dimidiation_ind = 1

	sets.Dimidiation.AttackUncap = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Ilabrat Ring",
		back=Ogma.WSD,
		--[[ ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back = Ogma.Da, ]]
	}
		
	sets.Dimidiation.AttackCap = set_combine(sets.Dimidiation.AttackUncap, {
		--[[ ammo="Knobkierrie",
		head = "Nyame Helm",
		neck="Caro Necklace",
		ear1="Sherida earring",
		ear2="Moonshade Earring",
		body=AdhemarJacket.Accuracy,
		hands="Nyame Gauntlets",
		ring2="Epaminondas's Ring",
		ring1="Sroda Ring",
		back=Ogma.WSD,
		waist="Fotia Belt",
		legs="Meghanada Chausses +2",
		feet="Nyame Sollerets", ]]
	})						   
							   
	sets.Dimidiation.Accuracy = set_combine(sets.Dimidiation.AttackUncap, {
		--[[ ammo="Voluspa Tathlum",
		head = "Nyame Helldive",
		neck="Fotia Gorget",
		ear1="Moonshade earring",
		ear2="Mache Earring +1",
		body=AdhemarJacket.Accuracy,
		hands="Nyame Gauntlets",
		ring2="Epaminondas's Ring",
		ring1="Ilabrat Ring",
		back=Ogma.WSD,
		waist="Kentarch Belt",
		legs="Erilaz Leg Guards +3",
		feet="Nyame Sollerets" ]]
	})
	
	---Sword WS  Sets---
	
	sets.Requiescat = {}

	sets.Requiescat.index = { 'AttackUncap', 'AttackCap', 'Accuracy' }
	Requiescat_ind = 1

	sets.Requiescat.AttackUncap = {
		--[[ ammo = "Quartz Tathlum +1",
		head = "Carmine Mask +1",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Attack,
		ring1 = "Epona's ring",
		ring2 = "Regal Ring",
		back = Ogma.DA,
		waist = "Fotia Belt",
		legs = "Meghanada Chausses +2",
		feet = "Carmine Greaves +1" ]]
	}

	sets.Requiescat.AttackCap = {
		--[[ ammo = "Quartz Tathlum +1",
		head = "Carmine Mask +1",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Attack,
		ring1 = "Epona's ring",
		ring2 = "Regal Ring",
		back = Ogma.DA,
		waist = "Fotia Belt",
		legs = "Meghanada Chausses +2",
		feet = "Carmine Greaves +1" ]]
	}

	sets.Requiescat.Accuracy = {
		--[[ ammo = "Yamarang",
		head = "Carmine Mask +1",
		neck = "Fotia Gorget",
		ear1 = "Crepuscular Earring",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = AdhemarWrists.Attack,
		ring1 = "Epona's ring",
		ring2 = "Regal Ring",
		back = Ogma.DA,
		waist = "Fotia Belt",
		legs = "Telchine Braconi",
		feet = "Carmine Greaves +1" ]]
	}

 --Ive never once used this WS on RUN, yet upon sharing my .lua with Carrot she called me out on this.
	sets.SanguineBlade = {
		--[[ ammo = "Knobkierrie",
		head = "Nyame Helm",
		neck = "Deviant Necklace",
		ear1 = "Hecate's Earring",
		ear2 = "Moldavite Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Arvina Ringle +1",
		ring2 = "Archon Ring",
		back = "Evasionist's Cape",
		waist = "Eschan Stone",
		--waist = "Eschan Stone",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets" ]]
	}

	sets.SavageBlade = {}

	sets.SavageBlade.index = { 'AttackUncap', 'AttackCap', 'Accuracy' }
	SavageBlade_ind = 1
	sets.SavageBlade.AttackUncap = {
		--[[ ammo = "Knobkierrie",
		head = "Nyame Helm",
		neck = "Futhark Torque +2",
		ear1 = "Moonshade Earring",
		ear2 = "Ishvara Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Regal Ring",
		ring2 = "Epaminondas's Ring",
		back = Ogma.WSD,
		waist = "Sailfi Belt +1",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets" ]]
	}
	
	sets.SavageBlade.AttackCap = {
		--[[ ammo = "Knobkierrie",
		head = "Nyame Helm",
		neck = "Futhark Torque +2",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Regal Ring",
		ring2 = "Epaminondas's Ring",
		back = Ogma.WSD,
		waist = "Sailfi Belt +1",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets" ]]
	}

	sets.SavageBlade.Accuracy = {
		--[[ ammo = "Voluspa Tathlum",
		head = "Nyame Helm",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Telos Earring",
		body = AdhemarJacket.Accuracy,
		hands = "Nyame Gauntlets",
		ring2 = "Niqmaddu Ring",
		ring1 = "Regal Ring",
		back = Ogma.WSD,
		waist = "Sailfi Belt +1",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets" ]]
	}
	
	---Club WS  Sets---
	
	sets.FlashNova = {
		--[[ ammo = "Knobkierrie",
		head = "Nyame Helm",
		neck = "Deviant Necklace",
		ear1 = "Hecate's Earring",
		ear2 = "Moldavite Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Arvina Ringlet +1",
		ring2 = "Epaminondas's ring",
		back = "Evasionist's Cape",
		waist = "Eschan Stone",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets" ]]
	}
	
	sets.BlackHalo = {}

	sets.BlackHalo.index = { 'AttackUncap', 'AttackCap', 'Accuracy' }
	BlackHalo_ind = 1
	sets.BlackHalo.AttackUncap = {
		--[[ ammo = "Knobkierrie",
		head = "Nyame Helm",
		neck = "Futhark Torque +2",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Regal Ring",
		ring2 = "Epaminondas's Ring",
		back = Ogma.WSD,
		waist = "Sailfi Belt +1",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets" ]]
	}
	
	sets.BlackHalo.AttackCap = set_combine(sets.BlackHalo.AttackUncap, {})

	sets.BlackHalo.Accuracy = set_combine(sets.BlackHalo.AttackUncap, {})
	
	sets.Realmrazer = {}

	sets.Realmrazer.index = { 'AttackUncap', 'AttackCap', 'Accuracy' }
	Realmrazer_ind = 1
	sets.Realmrazer.AttackUncap = {
		--[[ ammo = "Voluspa Tathlum",
		head = "Erilaz Galea +3",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = AdhemarJacket.Accuracy,
		hands = "Nyame Gauntlets",
		ring1 = "Regal ring",
		ring2 = "Niqmaddu Ring",
		back = "Cornflower Cape",
		waist = "Fotia Belt",
		legs = "Samnuha Tights",
		feet = "Erilaz Greaves +3" ]]
	}

	sets.Realmrazer.AttackCap = set_combine(sets.Realmrazer.AttackUncap, {})

	sets.Realmrazer.Accuracy = set_combine(sets.Realmrazer.AttackUncap, {})
	
	sets.StatusWS = {
	--[[ 	ammo = "Yamarang",
		head = "Nyame Helm",
		neck = "Combatant's Torque",
		ear1 = "Crepuscular Earring",
		ear2 = "Telos Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Chirich Ring +1",
		ring2 = "Moonlight Ring",
		waist = "Eschan Stone",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets", ]]
	}
	
------End of WS------------------------------------------------------------------------------------------
------Magic Sets---
	sets.BlueMagic = {}

	sets.BlueMagic.STR = set_combine(sets.Resolution.Attack, {
	})

	--Curing Sets--
	sets.Cures = {
		ammo="Staunch Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Nyame Mail",
		hands=EMPY.Hands,
		legs=EMPY.Legs,
		feet=EMPY.Feet,
		neck="Sacro Gorget",
		waist="Rumination Sash",
		left_ear="Cryptic Earring",
		right_ear="Magnetic Earring",
		left_ring="Shadow Ring",
		right_ring="Meridian Ring",
		back=Ogma.SIR,
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Sacro Gorget",
		ear1 = "Cryptic Earring",
		ear2 = "Magnetic Earring",
		body = "Nyame Mail",
		hands = "Erilaz Gauntlets +3",
		ring1 = "Menelaus's Ring",
		ring2 = "Eihwaz Ring",
		back = Ogma.Parry,
		waist = "Sroda Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Erilaz Greaves +3", ]]
	}
	
	sets.Cures.SelfCures = set_combine(sets.Cures, {
		--[[ neck = "Phalaina Locket",
		ear2 = "Mendicant's Earring",
		ring2 = "Kunaji Ring", ]]
	})
	--Spell Interruption Rate--
	sets.SIR = { -- 93
		ammo="Staunch Tathlum", -- 10
		head=EMPY.Head, -- 15
		body="Nyame Mail", -- 0
		hands="Rawhide Gloves", -- 15
		legs="Carmine Cuisses +1", -- 20
		feet=EMPY.Feet, -- 0
		neck={ name="Loricate Torque +1", augments={'Path: A',}}, -- 5
		waist="Rumination Sash", -- 10
		left_ear="Odnowa Earring +1", -- 0
		right_ear="Magnetic Earring", -- 8
		left_ring="Defending Ring", -- 0
		right_ring="Meridian Ring", -- 0
		back=Ogma.SIR, -- 10
		--[[ ammo = "Staunch Tathlum +1",
		head = "Erilaz Galea +3",
		neck = "Moonlight Necklace",
		ear2 = "Halasz Earring",
		ear1 = "Odnowa Earring +1",
		body = "Nyame Mail",
		hands = "Rawhide Gloves",
		ring1 = "Defending Ring",
		ring2 = "Stikini Ring +1",
		back = Ogma.Tank,
		waist = "Audumbla Sash",
		legs = "Carmine Cuisses +1",
		feet = "Erilaz Greaves +3", ]]
	}
------End of Magic-------------------------------------------------------------------------------------
	--Enmity Set--
	
	sets.Enmity = {
        ammo="Crepuscular Pebble",
        head=EMPY.Head,
        body="Emet Harness +1",
        hands=EMPY.Hands,
        legs=EMPY.Legs,
        feet=EMPY.Feet,
        neck="Unmoving Collar +1",
        waist="Plat. Mog. Belt",
        left_ear="Cryptic Earring",
        right_ear="Magnetic Earring",
        left_ring="Odium Ring",
        right_ring="Petrov Ring",
        back=Ogma.SIR,
		--[[ ammo = "Sapience Orb",
		head = "Nyame Helm",
		neck = "Moonlight Necklace",
		ear2 = "Cryptic Earring",
		ear1 = "Friomisi Earring",
		body = "Emet Harness +1",
		hands = "Kurys Gloves",
		ring1 = "Eihwaz Ring",
		ring2 = "Supershear Ring",
		back = Ogma.Tank,
		waist = "Sulla Belt",
		legs = "Erilaz Leg Guards +3",
		feet = "Erilaz Greaves +3"  ]]
	}
	
	--Utility Sets--
	
	sets.Utility = {}

    sets.Utility.TH = {
		ammo="Per. Lucky Egg",
		head="Wh. Rarab Cap +1",
		feet={ name="Herculean Boots", augments={'Weapon Skill Acc.+8','"Store TP"+2','"Treasure Hunter"+2',}},
		--[[ head = "Volte Cap",
        waist = "Chaac Belt",
		legs = HerculeanLegs.TH,
        feet = HerculeanFeet.TH ]]
    }
	
	sets.Utility.Derp = {
		neck = "Warder's Charm +1",
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Warder's Charm +1",
		ear2 = "Eabani Earring",
		ear1 = "Odnowa Earring +1",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Shadow Ring",
		ring2 = "Moonlight Ring",
		back = Ogma.Tank,
		waist = "Engraved Belt",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets" ]]
	}

	---------------------------------------------------------------
	
--	sets.Utility.Charm = {
--		ammo = "Staunch Tathlum +1",
--		head = "Futhark Bandeau +3",
--		neck = "Unmoving Collar +1",
--		ear1 = "Genmei Earring",
--		ear2 = "Hearty Earring",
--		body = "Ashera Harness",
--		body = "Runeist Coat +3",
--		hands = "Erilaz Gauntlets +3",
--		ring1 = "Defending Ring",
--		ring2 = "Wuji Ring",
--		back = "Solemnity Cape",
--		waist = "Flume Belt",
--		legs = "Runeist Trousers +3",
--		feet = "Erilaz Greaves +3"
--	}
	
	sets.Utility.Doom = {
		--[[ ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Nicander's Necklace",
		ear2 = "Eabani Earring",
		ear1 = "Odnowa Earring +1",
		body = "Futhark Coat +3",
		hands = "Nyame Gauntlets",
		ring1 = "Saida Ring",
		ring2 = "Purity Ring",
		back = Ogma.Tank,
		waist = "Gishdubar Sash",
		legs = "Erilaz Leg Guards +3",
		feet = "Erilaz Greaves +3" ]]
	}
	
	--Enhancing Sets--
	
	sets.Enhancing = {}
	
	sets.Enhancing.Base = {	
		ammo="Staunch Tathlum",
		head=EMPY.Head,
		body="Nyame Mail",
		hands=EMPY.Hands,
		legs="Carmine Cuisses +1",
		feet=EMPY.Feet,
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Rumination Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Magnetic Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back=Ogma.SIR,
		--[[ ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Erilaz Greaves +3",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Erilaz Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Defending Ring",
		right_ring="Evanescence Ring",
		back={ name="Ogma's Cape", augments={'HP+60','HP+20','Enmity+10','Spell interruption rate down-10%',}}, ]]
	}
	
	sets.Enhancing.Duration = set_combine(sets.Enhancing.Base, {
		legs=RELIC.Legs,
		--[[ head = "Erilaz Galea +3",
		hands = "Regal Gauntlets",
		legs= "Futhark Trousers +3", ]]
	})
	
	sets.Enhancing.Barspell = set_combine(sets.Enhancing.Base, {
		--[[ ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Erilaz Greaves +3",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Erilaz Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Defending Ring",
		right_ring="Evanescence Ring",
		back={ name="Ogma's Cape", augments={'HP+60','HP+20','Enmity+10','Spell interruption rate down-10%',}}, ]]
	})
	
	sets.Enhancing.Temper = set_combine(sets.Enhancing.Base, {
		--[[ ammo = "Staunch Tathlum +1",
		head = "Erilaz Galea +3",
		neck = "Melic Torque",
		ear2 = "Mimir Earring",
		ear1 = "Odnowa Earring +1",
		body = "Manasa Chasuble",
		hands = "Runeist Mitons +3",
		ring1 = "Defending Ring",
		ring2 = "Stikini Ring +1",
		back = "Merciful Cape",
		waist = "Olympus Sash",
		legs = "Carmine Cuisses +1",
		feet = "Erilaz Greaves +3", ]]
	})
	
	sets.Enhancing.Crusade = set_combine(sets.Enhancing.Base, {
		legs=RELIC.Legs,
		--[[ ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}},
		legs="Futhark Trousers +3",
		feet="Erilaz Greaves +3",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Erilaz Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Defending Ring",
		right_ring="Evanescence Ring",
		back={ name="Ogma's Cape", augments={'HP+60','HP+20','Enmity+10','Spell interruption rate down-10%',}}, ]]
	})
	
	sets.Enhancing.Phalanx = set_combine(sets.Enhancing.Base, {
		head=RELIC.Head,
		hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Phalanx +3',}},
		--[[ ammo="Staunch Tathlum +1",
		head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+14 Rng.Atk.+14','"Conserve MP"+2','Phalanx +4','Accuracy+17 Attack+17',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Herculean Boots", augments={'Enmity+4','STR+8','Phalanx +4',}},
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Mimir Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Ogma's Cape", augments={'HP+60','HP+20','Enmity+10','Spell interruption rate down-10%',}}, ]]
	})
	
	sets.Enhancing.Refresh = set_combine(sets.Enhancing.Base, {
		legs=RELIC.Legs,
		--[[ ammo = "Staunch Tathlum +1",
		head = "Erilaz Galea +3",
		neck = "Melic Torque",
		ear2 = "Erilaz Earring +1",
		ear1 = "Odnowa Earring +1",
		body = "Nyame Mail",
		hands = "Regal Gauntlets",
		ring2 = "Gelatinous Ring +1",
		ring1 = "Defending Ring",
		back = Ogma.Tank,
		waist = "Audumbla Sash",
		legs = "Futhark Trousers +3",
		feet = "Nyame Sollerets" ]]
	})
	
	sets.Enhancing.Regen = 	set_combine(sets.Enhancing.Base, {	
		head=AF.Head,
		neck="Sacro Gorget",
		legs=RELIC.Legs,
		
		--[[ ammo = "Staunch Tathlum +1",
		head = "Runeist Bandeau +3",
		neck = "Sacro Gorget",
		ear1 = "Etiolation Earring",
		ear2 = "Erilaz Earring +1",
		body = "Nyame Mail",
		hands = "Regal Gauntlets",
		ring2 = "Gelatinous Ring +1",
		ring1 = "Defending Ring",
		back = Ogma.Tank,
		waist = "Sroda Belt",
		legs = "Futhark Trousers +3",
		feet = "Nyame Sollerets", ]]
	})
	
	sets.Enhancing.ProShell = set_combine(sets.Enhancing.Duration, {
		--ear1 = "Brachyura Earring",
	})
	
	sets.Enhancing.Foil = set_combine(sets.Enmity, {
		--ammo = "Staunch Tathlum +1",
		--head = "Nyame Helm",
		--body = "Nyame Mail",
		--hands = "Nyame Gauntlets",
		--legs = "Futhark Trousers +3",
		--feet = "Nyame Sollerets"
	})
	
	--Job Ability Sets--

	sets.JA = {}
	
	sets.JA.Lunge = {
		hands = "Agwu's Gages",
		feet = "Agwu's Pigaches",
		--[[ ammo = "Pemphredo Tathlum",
		head = "Agwu's Cap",
		neck = "Baetyl Pendant",
		ear1 = "Friomisi Earring",
		ear2 = "Hecate's Earring",
		body = "Agwu's Robe",
		hands = "Agwu's Gages",
		ring1 = "Shiva Ring +1",
		ring2 = "Mujin Band",
		back = "Evasionist's Cape",
		waist = "Eschan Stone",
		legs = "Agwu's Slops",
		feet = "Agwu's Pigaches" ]]
	}

	sets.JA.Sforzo = set_combine(sets.Enmity, {
		body=RELIC.Body,
		--body = "Futhark Coat +3",
	})

	sets.JA.Swordplay = set_combine(sets.Enmity, {
		hands=RELIC.Hands,
		--hands = "Futhark Mitons +3",
	})
	
	sets.JA.Vallation = set_combine(sets.Enmity, {
		body=AF.Body,
		legs=RELIC.Legs,
		--[[ body = "Runeist Coat +3",
		legs = "Futhark Trousers +3",
		back = "Ogma's Cape", ]]
	})
	
	sets.JA.Pflug = set_combine(sets.Enmity, {
	--	feet = "Runeist Boots +3" --Unfortunately it was discovered that the feet must be equiped during the status check to add the extra resistance +4% (per rune) . 
	})
	
	sets.JA.Valiance = set_combine(sets.Enmity, {
		body=AF.Body,
		--body = "Runeist Coat +3",
		--back = Ogma.Tank
	})
	
	sets.JA.Embolden = set_combine(sets.Enmity, {
	})
	
	sets.JA.Pulse = set_combine(sets.SelfCures, {

		--[[ ammo = "Staunch Tathlum +1",
		head = "Erilaz Galea +3",
		neck = "Incanter's Torque",
		ear2 = "Etiolation Earring",
		ear1 = "Odnowa Earring +1",
		body = "Nyame Mail",
		ring1 = "Moonlight Ring",
		ring2 = "Stikini Ring +1",
		back = "Moonlight Cape",
		waist = "Engraved Belt",
		legs = "Runeist Trousers +3",
		feet = "Nyame Sollerets" ]]
	})
	
	sets.JA.Gambit = set_combine(sets.Enmity, {
		hands=AF.Hands,
		--hands = "Runeist Mitons +2"
	})
	
	sets.JA.Battuta = set_combine(sets.Enmity, {
		head=RELIC.Head,
		--head =  "Futhark Bandeau +3"
	})
	
	sets.JA.Rayke = set_combine(sets.Enmity, {
		feet=RELIC.Feet,
		--feet = "Futhark Boots +1"
	})
	
	sets.JA.Liement = set_combine(sets.Enmity, {
		body=RELIC.Body,
		--body = "Futhark Coat +3"
	})
	--One For All is HP * .2 = Magic Damage Reduction--
	sets.JA.One = {
		--[[ ammo = "Staunch Tathlum +1",
		head = "Runeist Bandeau +3",
		neck = "Unmoving Collar +1",
		ear2 = "Etiolation Earring",
		ear1 = "Odnowa Earring +1",
		body = "Runeist Coat +3",
		hands = "Nyame Gauntlets",
		ring2 = "Moonlight Ring",
		ring1 = "Gelatinous Ring +1",
		back = "Moonlight Cape",
		waist = "Kasiri Belt",
		legs = "Nyame Flanchard",
		Feet = "Carmine Greaves +1" ]]
	}
	
	sets.JA.Subterfuge = set_combine(sets.Enmity, {})
	
	---SAM---
	sets.JA.Meditate = set_combine(sets.Enmity, {})
	
	---WAR---
	sets.JA.Provoke = set_combine(sets.Enmity, {})

	sets.JA.Warcry = set_combine(sets.Enmity, {})
	
	--Precast Sets--
	sets.precast = {}

	sets.precast.FC = {}

	sets.precast.FC.Standard = {
		ammo="Staunch Tathlum",
		head=AF.Head,
		body=EMPY.Body,
		hands={ name="Agwu's Gages", augments={'Path: A',}},
		legs="Aya. Cosciales +2",
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
		neck="Baetyl Pendant",
		waist="Siegel Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back=Ogma.SIR,
		--[[ ammo = "Sapience Orb", --2 Fast Cast
		head = "Runeist Bandeau +3", --14 Fast Cast
		neck = "Voltsurge torque", --4 Fast Cast
		ear1= "Etiolation Earring", --1 Fast Cast
		ear2 = "Loquacious Earring", --2 Fast Cast
		body = "Erilaz Surcoat +3", --13 Fast Cast
		hands = "agwu's gages", --6 Fast Cast
		ring1 = "Kishar Ring", --4 Fast Cast
		ring2 = "Weather. Ring", --5 Fast Cast
		back={ name="Ogma's Cape", augments={'"Fast Cast"+10',}},
		waist = "Siegel Sash",
		legs = "Agwu's Slops", --7 Fast Cast
		feet = "Agwu's Pigaches", --4 Fast Cast ]]
	}
	
	sets.precast.FC.Enhancing = set_combine(sets.precast.FC.Standard, {
		legs=RELIC.Legs,
		--legs = "Futhark Trousers +3",
		--ring1 = "Defending Ring",
	})
	
	sets.precast.FC.Val = set_combine(sets.precast.FC.Standard, {
		--[[ ammo = "Sapience Orb",
		head = "Runeist Bandeau +3",
		neck = "Voltsurge torque",
		ear1= "Etiolation Earring",
		ear2 = "Loquacious Earring",
		body = "Erilaz Surcoat +3",
		hands = "agwu's gages",
		ring1 = "Vengeful Ring",
		ring2 = "Prolix Ring",
		back={ name="Ogma's Cape", augments={'"Fast Cast"+10',}},
		waist = "Siegel Sash",
		legs = "Agwu's Slops",
		feet = "Agwu's Pigaches", ]]
	})
	
	sets.precast.FC.ValEnhancing = set_combine(sets.precast.FC.Val, {
		legs=RELIC.Legs,
		--legs = "Futhark Trousers +3",
	})
	
end

---End of Gear---------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------
---------                   ---------
------                         ------
---         Start of Maps         ---
------                         ------
---------                   ---------
------------------------------------- 

-------------------------
--   BLU Spells List   --
-------------------------

function maps()
	PhysicalSpells = S {
		'Bludgeon', 'Body Slam', 'Feather Storm', 'Mandibular Bite', 'Queasyshroom',
		'Power Attack', 'Screwdriver', 'Sickle Slash', 'Smite of Rage',
		'Terror Touch', 'Battle Dance', 'Claw Cyclone', 'Foot Kick', 'Grand Slam', 
		'Sprout Smack', 'Helldive', 'Jet Stream', 'Pinecone Bomb', 'Wild Oats', 'Uppercut'
	}
	
	BlueMagic_Buffs = S {
		'Refueling',
	}

	BlueMagic_Healing = S {
		'Healing Breeze', 'Pollen', 'Wild Carrot'
	}

	BlueMagic_Enmity = S {
		'Blank Gaze', 'Jettatura', 'Geist Wall', 'Sheep Song', 'Soporific', 'Cocoon', 'Stinking Gas'
	}
	
	RUNMagic_Enmity = S {
		'Flash', 'Stun'
	}
end

------------------------
--   Town Gear List   --
------------------------

Town = S {
    "Ru'Lude Gardens", "Upper Jeuno", "Lower Jeuno", "Port Jeuno",
    "Port Windurst", "Windurst Waters", "Windurst Woods", "Windurst Walls", "Heavens Tower",
    "Port San d'Oria", "Northern San d'Oria", "Southern San d'Oria", "Chateau d'Oraguille",
	"Port Bastok", "Bastok Markets", "Bastok Mines", "Metalworks",
    "Aht Urhgan Whitegate", "Nashmau",
    "Selbina", "Mhaura", "Norg",  "Kazham", "Tavanazian Safehold", "Rabao",
    "Eastern Adoulin", "Western Adoulin", "Celennia Memorial Library", "Mog Garden"
}

---End of Maps----------------------------------------------------------------------------------------------------------------------------------------------------------

function msg(str)
	send_command('@input /echo <----- ' .. str .. ' ----->')
end

------------------------------------------
-- Macro and Style Change on Job Change
------------------------------------------
function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait 2;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end

function set_style(sheet)
    send_command('@input ;wait 11.0;input /lockstyleset '..sheet)
	add_to_chat (21, 'Your lockstyle looks like shit, and you should feel bad')
	add_to_chat (55, 'You are on '..('RUN '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
--	add_to_chat (60, 'Eat tendies in moderation')
end

--Page, Book--
set_macros(1,12)
--Use the Lockstyle Number-- 
set_style(11) 
------------------------------------------
-- Variables
------------------------------------------
SetLocked = false --Used to Check if set is locked before changing equipment
LockedEquipSet = {} --Placeholder to store desired lock set
LockGearSet = {}
equipSet = {} --Currently Equiped Gearset
LockGearIndex = false
LockGearIndex = false
TargetDistance = 0
TH = false -- Defaults
SIR = false -- Spell Interruption Rate
TankingTP = true -- If true, default set is tanking TP array.
TwoHandedTP = true -- TP set order, looks for Tanking TP set before 2H TP before 1H DW TP.
------------------------------------------
-- Windower Hooks              --
------------------------------------------

function buff_change(n, gain, buff_table)
	local name
	name = string.lower(n)
	if S{"terror","petrification","sleep","stun"}:contains(name) then
        if gain then
            ChangeGear(sets.Utility.Derp)
        elseif not has_any_buff_of({"terror","petrification","sleep","stun"}) then
            if player.status == 'Engaged' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
					if TankingTP == true then
						ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
					elseif EpeoAM3 == true then
						ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
					elseif TwoHandedTP == true then
						ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
					else
						ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
					end
                end
            elseif player.status == 'Idle' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
            end
        end
    elseif name == "doom" then
        if gain then
            ChangeGear(sets.Utility.Doom)
            send_command('@input /p Doomed {~o~:} !')
            disable('neck','ring1','ring2','waist')
        else
            if player.status == 'Engaged' then
                if LockGearIndex then
					send_command('@input /p Doom is off {^_^}')
                    enable('neck','ring1','ring2','waist')
                    ChangeGear(LockGearSet)
                else
					send_command('@input /p Doom is off {^_^}')
                    enable('neck','ring1','ring2','waist')
					if TankingTP == true then
						ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
					elseif EpeoAM3 == true then
						ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
					elseif TwoHandedTP == true then
						ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
					else
						ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
					end
                end
            elseif player.status == 'Idle' then
                if LockGearIndex then
					send_command('@input /p Doom is off {^_^}')
                    enable('neck','ring1','ring2','waist')
                    ChangeGear(LockGearSet)
                else
					send_command('@input /p Doom is off {^_^}')
                    enable('neck','ring1','ring2','waist')
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
            end
        end
	elseif name == "charm" then
		if gain then
			send_command('@input /p Charmed {<3_<3:} !')
		else
			send_command('@input /p Charm is off {~_^}')
		end
	elseif name == "weakness" then
		if gain then
			enable('neck','ring1','ring2','waist')
		end
	elseif name == "embolden" then
		if gain then
		ChangeGear(set_combine(equipSet, {back="Evasionist's Cape"}))
		else
            if player.status == 'Engaged' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
					if TankingTP == true then
						ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
					elseif EpeoAM3 == true then
						ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
					elseif TwoHandedTP == true then
						ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
					else
						ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
					end
                end
            elseif player.status == 'Idle' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
            end
        end
	elseif name == "hasso" then
        if gain then
		return
	else
		send_command('gs c -cd Hasso Lost!')
		end
	end
	
	if name == "aftermath: lv.3" and player.equipment.main == 'Epeolatry' then -- Mythic AM3
		if gain then
			EpeoAM3 = true
			send_command('timers create "Mythic AM3" 180 down')
			 if LockGearIndex then
			    ChangeGear(LockGearSet)
			elseif TankingTP == true then
				ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
			else
				ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
			end 
		else
			EpeoAM3 = false
			send_command('timers delete "Mythic AM3";gs c -cd AM3 Lost!!!')
		end
	end
end

------------------------------------------
--              Includes                --
------------------------------------------
include('Global-Binds.lua')

------------------------------------------
--               Binds                  --
------------------------------------------
--^ means ctl
--! means alt
--@ means win
send_command('bind f9 gs c toggle TP set') --This means if you hit f9 it toggles the sets
send_command('bind f10 gs c toggle WS set') --Changes Reso and Dimidiation sets
send_command('bind f11 gs c toggle TH') --Toggles TH mode
send_command('bind f12 gs c toggle Idle set')
send_command('bind ^f8 gs c toggle SIR') -- Turns Spell Interruption Rate set on
send_command('bind ^numpad7 input /ws "Dimidiation" <t>')
send_command('bind ^numpad9 input /ws "Resolution" <t>')
send_command('bind ^numpad4 input /ws "Ground Strike" <t>')
send_command('bind ^numpad5 input /ws "Fell Cleave" <t>')
send_command('bind ^numpad6 input /ws "Steel Cyclone" <t>')
send_command('bind ^numpad1 input /ws "Savage Blade" <t>')
send_command('bind ^numpad3 input /ws "Shockwave" <t>')
send_command('bind !f7 gs c toggle TankingTP set') --! means alt, this exists only for toggling outside of this mode being active, otherwise f9
send_command('bind !f8 gs c toggle TankingTP') --! turns tanking tp off
send_command('bind !f9 gs c toggle backwards')
send_command('bind !f10 ') --Empty
send_command('bind !f11 ') --Empty
send_command('bind !f12 gs c lockgearindex')

--Spells
send_command('bind !q input /ma "Ice Spikes" <me>')
send_command('bind !w input /ma "Cocoon" <me>')
send_command('bind !e input /ma "Regen IV" <stpc>')
send_command('bind !r input /ma "Refresh" <stpc>')
send_command('bind !t input /ma "Blink" <me>')
send_command('bind !y input /ma "Phalanx" <me>')
send_command('bind !u input /ma "Stoneskin" <me>')


--send_command('bind !e input /item "Echo Drops" <me>')
--send_command('bind !r input /item "Remedy" <me>')
--send_command('bind !p input /item "Panacea" <me>')
--send_command('bind !h input /item "Holy Water" <me>')
--send_command('bind !w input /equip ring2 "Warp Ring"; /echo Warping; wait 11; input /item "Warp Ring" <me>;')
--send_command('bind !q input /equip ring2 "Dim. Ring (Holla)"; /echo Reisenjima; wait 11; input /item "Dim. Ring (Holla)" <me>;')
--send_command('bind !t gs c ') -- alt + t

--Unload Binds
function file_unload()
	send_command('unbind ^numpad7')
	send_command('unbind ^numpad9')
	send_command('unbind ^numpad4')
	send_command('unbind ^numpad5')
	send_command('unbind ^numpad6')
	send_command('unbind ^numpad1')
	send_command('unbind ^numpad3')
	send_command('unbind ^f8')
	send_command('unbind !f7')
	send_command('unbind !f8')
	send_command('unbind !f9')
	send_command('unbind !f10')
	send_command('unbind !f11')
	send_command('unbind !f12')
	send_command('unbind f9')
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind f12')
	
	send_command('unbind !q')
	send_command('unbind !w')
	send_command('unbind !e')
	send_command('unbind !r')
	send_command('unbind !t')
	send_command('unbind !y')
	send_command('unbind !u')

	--send_command('unbind !e')
	--send_command('unbind !r')
	--send_command('unbind !p')
	--send_command('unbind !h')
	--send_command('unbind !w')
	--send_command('unbind !q')
	--send_command('unbind !t')
end

------------------------------------------
-- Console Commands             --
------------------------------------------
function self_command(command)
	if command == 'togglelock' then
		if SetLocked == false then
			msg("Equipment Set LOCKED!")
		else
			SetLocked = false
			msg("Equipment Set UNLOCKED!")
		end
	elseif command == 'lockgearindex' then
		if LockGearIndex == false then
			LockGearIndex = true
			LockGearSet = {
				ammo = player.equipment.ammo,
				head = player.equipment.head,
				neck = player.equipment.neck,
				ear1 = player.equipment.left_ear,
				ear2 = player.equipment.right_ear,
				body = player.equipment.body,
				hands = player.equipment.hands,
				ring1 = player.equipment.left_ring,
				ring2 = player.equipment.right_ring,
				back = player.equipment.back,
				waist = player.equipment.waist,
				legs = player.equipment.legs,
				feet = player.equipment.feet
			}
			msg("Gear Index Locked")
		else
			LockGearIndex = false
			msg("Gear Index Unlocked")
			if player.status == 'Engaged' then
				if TankingTP == true then
					ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
				elseif EpeoAM3 == true then
						ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
				elseif TwoHandedTP == true then
					ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
				else
					ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
				end
			else
				ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
			end
		end
	end
	if command == 'toggle TP set' then
		if TankingTP == true then
			TankingTP_ind = TankingTP_ind + 1
			if TankingTP_ind > #sets.TankingTP.index then TankingTP_ind = 1 end
			send_command('@input /echo <----- TankingTP Set changed to ' .. sets.TankingTP.index[TankingTP_ind] .. ' ----->')
			if player.status == 'Engaged' then
				ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
			end
		elseif TankingTP == false then
			if TwoHandedTP == true then
				TwoHandedTP_ind = TwoHandedTP_ind + 1
				EpeoAM3_ind = EpeoAM3_ind +1
				if TwoHandedTP_ind > #sets.TwoHandedTP.index then TwoHandedTP_ind = 1 end
				if EpeoAM3_ind > #sets.EpeoAM3.index then EpeoAM3_ind = 1 end
				send_command('@input /echo <----- 2H TP Set changed to ' .. sets.TwoHandedTP.index[TwoHandedTP_ind] .. ' ----->')	
				if player.status == 'Engaged' then
					if EpeoAM3 == true then
						ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
					else
						ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
					end
				end
			elseif TwoHandedTP == false then
				OneHandedTP_ind = OneHandedTP_ind + 1
				if OneHandedTP_ind > #sets.OneHandedTP.index then OneHandedTP_ind = 1 end
				send_command('@input /echo <----- 1H TP Set changed to ' .. sets.OneHandedTP.index[OneHandedTP_ind] .. ' ----->')
				if player.status == 'Engaged' then
					ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
				end
			end		
		end
	elseif command == 'toggle Idle set' then
		Idle_ind = Idle_ind + 1
		if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
		send_command('@input /echo <----- Idle Set changed to ' .. sets.Idle.index[Idle_ind] .. ' ----->')
		ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == 'toggle WS set' then
		Resolution_ind = Resolution_ind + 1
		Dimidiation_ind = Dimidiation_ind + 1
		SavageBlade_ind = SavageBlade_ind + 1
		Requiescat_ind = Requiescat_ind + 1
		BlackHalo_ind = BlackHalo_ind + 1
		Realmrazer_ind = Realmrazer_ind + 1
		if Resolution_ind > #sets.Resolution.index then Resolution_ind = 1 end
		if Dimidiation_ind > #sets.Dimidiation.index then Dimidiation_ind = 1 end
		if SavageBlade_ind > #sets.SavageBlade.index then SavageBlade_ind = 1 end
		if Requiescat_ind > #sets.Requiescat.index then Requiescat_ind = 1 end
		if BlackHalo_ind > #sets.BlackHalo.index then BlackHalo_ind = 1 end
		if Realmrazer_ind > #sets.Realmrazer.index then Realmrazer_ind = 1 end
		send_command('@input /echo <----- WS Sets changed to ' .. sets.Resolution.index[Resolution_ind] .. ' ----->')
	elseif command == 'toggle TankingTP set' then
		TankingTP_ind = TankingTP_ind + 1
		if TankingTP_ind > #sets.TankingTP.index then TankingTP_ind = 1 end
		send_command('@input /echo <----- TankingTP Set changed to ' .. sets.TankingTP.index[TankingTP_ind] .. ' ----->')
		if player.status == 'Engaged' then
			ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
		end
	elseif command == 'toggle TankingTP' then
		if TankingTP == true then
			TankingTP = false
			send_command('@input /echo <----- Tanking TP: [Off] ----->')
        else
			TankingTP = true
			send_command('@input /echo <----- Tanking TP: [On] ----->')
		end
		status_change(player.status)
	elseif command == 'toggle TwoHandedTP' then
		if TwoHandedTP == true then
			TwoHandedTP = false
			send_command('@input /echo <----- 2H TP: [Off] ----->')
        else
			TwoHandedTP = true
			send_command('@input /echo <----- 2H TP: [On] ----->')
		end
		status_change(player.status)
	elseif command == 'toggle SIR' then
		if SIR == true then
			SIR = false
			send_command('@input /echo <----- Spell Interruption Rate: [Off] ----->')
        else
			SIR = true
			send_command('@input /echo <----- Spell Interruption Rate: [On] ----->')
		end
		status_change(player.status)
	elseif command == 'toggle TH' then
		if TH == true then
			TH = false
			send_command('@input /echo <----- Treasure Hunter TP: [Off] ----->')
        else
			TH = true
			send_command('@input /echo <----- Treasure Hunter TP: [On] ----->')
		end
		status_change(player.status)
	elseif command == 'toggle backwards' then
		if TankingTP == true then
			TankingTP_ind = TankingTP_ind -1
			if TankingTP_ind == 0 then
				TankingTP_ind = #sets.TankingTP.index
			end
			send_command('@input /echo <----- TankingTP Set changed to ' .. sets.TankingTP.index[TankingTP_ind] .. ' ----->')
			if player.status == 'Engaged' then
				ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
			end
		elseif TankingTP == false then
			if TwoHandedTP == true then
				TwoHandedTP_ind = TwoHandedTP_ind -1
				EpeoAM3_ind = EpeoAM3_ind -1
				if TwoHandedTP_ind == 0 then
					TwoHandedTP_ind = #sets.TwoHandedTP.index
				end
				if EpeoAM3_ind == 0 then
					EpeoAM3_ind = #sets.EpeoAM3.index
				end
				send_command('@input /echo <----- 2H TP Set changed to ' .. sets.TwoHandedTP.index[TwoHandedTP_ind] .. ' ----->')	
				if player.status == 'Engaged' then
					if EpeoAM3 == true then
						ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])
					else
						ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
					end
				end
			elseif TwoHandedTP == false then
				OneHandedTP_ind = OneHandedTP_ind -1
				if OneHandedTP_ind == 0 then
					OneHandedTP_ind = #sets.OneHandedTP.index
				end
				if player.status == 'Engaged' then
					ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[TP_ind]])
				end
				send_command('@input /echo <----- 1H TP Set changed to ' .. sets.OneHandedTP.index[OneHandedTP_ind] .. ' ----->')
			end
		end
	elseif command == 'ZoneChange' then
		IdleState()
	elseif string.sub(command, 0, 4) == '-cd ' then     --If the first 4 characters of the command are '-cd '
        add_to_chat (30, string.sub(command, 5, string.len(command)))      --add everything after '-cd ' to a message in the chat
	end
end

------------------------------------------
-- Character States                     --
------------------------------------------
function IdleState()
    if LockGearIndex then
		ChangeGear(LockGearSet)
	elseif not LockGearIndex then
		ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
	end
	
    if player.mpp <= 50 and Idle_ind == 1 then --standard idle
        ChangeGear({head = HerculeanHelm.Refresh, waist = "Fucho-no-obi"})
	elseif player.mpp <= 25 and Idle_ind == 4 then -- kiting MP, probably going to hate this rule at some point or love it, idk
		ChangeGear({waist = "Fucho-no-obi"})
    end
		
	if Town:contains(world.area) and player.mpp < 75 then
        ChangeGear(set_combine(sets.Idle.Town, sets.Idle.Refresh))
		elseif Town:contains(world.area) then
		ChangeGear(sets.Idle.Town)
	end
	
	if buffactive['Embolden'] then
		ChangeGear(set_combine(equipSet, {head="Erilaz Galea +3", hands="Regal Gauntlets", back="Evasionist's Cape", legs="Furthark Trousers +3"}))
	end
	
end

windower.raw_register_event('zone change',function()
windower.send_command('@wait 9; input //gs c ZoneChange')
end)

function RestingState()

end

function EngagedState()
	if LockGearIndex then
		ChangeGear(LockGearSet)
	elseif not LockGearIndex then
		if TankingTP == true then
			ChangeGear(sets.TankingTP[sets.TankingTP.index[TankingTP_ind]])
		elseif buffactive["Aftermath: Lv.3"] and player.equipment.main == 'Epeolatry' then --am3
			EpeoAM3 = true
			ChangeGear(sets.EpeoAM3[sets.EpeoAM3.index[EpeoAM3_ind]])	
		elseif TwoHandedTP == true then
			EpeoAM3 = false
			ChangeGear(sets.TwoHandedTP[sets.TwoHandedTP.index[TwoHandedTP_ind]])
		else
			EpeoAM3 = false
			ChangeGear(sets.OneHandedTP[sets.OneHandedTP.index[OneHandedTP_ind]])
		end
	end
end

-----------------------------
--      Spell control      --
-----------------------------
unusable_buff = {
	spell={'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'},
    ability={'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}}
  --check_recast('ability',spell.recast_id)  check_recast('spell',spell.recast_id)
function check_recast(typ,id) --if spell can be cast(not in recast) return true
    local recasts = windower.ffxi['get_'..typ..'_recasts']()
    if id and recasts[id] and recasts[id] == 0 then
        return true
    else
        return false
    end
end
 --return true if spell/ability is unable to be used at this time
function spell_control(spell)
	if spell.type == "Item" then
		return false
	--Stops spell if you do not have a target
	elseif spell.target.name == nil and not spell.target.raw:contains("st") then
		return true
	--Stops spell if a blocking buff is active
	elseif spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' and spell.type ~= 'Scholar' and (has_any_buff_of(unusable_buff.ability) or not check_recast('ability',spell.recast_id)) then
		return true
	elseif spell.type == 'WeaponSkill' and player.tp < 1000 then
		return true
	elseif spell.type == 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability)) then
		msg("Weapon Skill Canceled, Can't")
		return true
	elseif spell.action_type == 'Magic' and (has_any_buff_of(unusable_buff.spell)
      or not check_recast('spell',spell.recast_id)) then
		return true
    --Stops spell if you do not have enuf mp/tp to use
	elseif spell.mp_cost and spell.mp_cost > player.mp and not has_any_buff_of({'Manawell','Manafont'}) and not spell.action_type == 'Ability' then
        msg("Spell Canceled, Not Enough MP")
		return true
	end
    --Calculate how many finishing moves your char has up to 6
	local fm_count = 0
	for i, v in pairs(buffactive) do
		if tostring(i):startswith('finishing move') or tostring(i):startswith('?????????') then
			fm_count = tonumber(string.match(i, '%d+')) or 1
		end
	end
    --Stops flourishes if you do not have enough finishing moves
	local min_fm_for_flourishes = {['Animated Flourish']=1,['Desperate Flourish']=1,['Violent Flourish']=1,['Reverse Flourish']=1,['Building Flourish']=1,
                                   ['Wild Flourish']=2,['Climactic Flourish']=1,['Striking Flourish']=2,['Ternary Flourish']=3,}
	if min_fm_for_flourishes[spell.en] then
		if min_fm_for_flourishes[spell.en] > fm_count and not buffactive[507] then
			return true
		end
	end
	--Reomves Sneak when casting Spectral Jig
	if spell.en == 'Spectral Jig' then
		send_command('cancel 71')
	end
	if spell.name == 'Utsusemi: Ichi' and overwrite and buffactive['Copy Image (3)'] then
		return true
	end
	if player.tp >= 1000 and player.target and player.target.distance and player.target.distance > 7 and spell.type == 'WeaponSkill' then
		msg("Weapon Skill Canceled  Target Out of Range")
		return true
	end
end

------------------------------------------
--              Precast                 --
------------------------------------------
function has_any_buff_of(buff_set)--returns true if you have any of the buffs given
    for i,v in pairs(buff_set) do
        if buffactive[v] ~= nil then return true end
    end
end
--JA Sets--
function pc_JA(spell, act)
	if spell.english == 'Elemental Sforzo' then
		ChangeGear(sets.JA.Sforzo)
	elseif spell.english == 'Swordplay' then
		ChangeGear(sets.JA.Swordplay)
	elseif spell.english == 'Vallation' or spell.english == 'Valiance' then
		ChangeGear(sets.JA.Vallation)
	elseif spell.english == 'Pflug' then
		ChangeGear(sets.JA.Pflug)
	elseif spell.english == 'Embolden' then
		ChangeGear(sets.JA.Embolden)
	elseif spell.english == 'Vivacious Pulse' then
		ChangeGear(sets.JA.Pulse)
	elseif spell.english == 'Gambit' then
		ChangeGear(sets.JA.Gambit)
	elseif spell.english == 'Battuta' then
		ChangeGear(sets.JA.Battuta)
	elseif spell.english == 'Rayke' then
		ChangeGear(sets.JA.Rayke)
	elseif spell.english == 'Liement' then
		ChangeGear(sets.JA.Liement)
	elseif spell.english == 'One For All' then
		ChangeGear(sets.JA.One)
	elseif spell.english == 'Odyllic Subterfuge' then
		ChangeGear(sets.JA.Subterfuge)
	elseif spell.english == 'Lunge' or spell.english == 'Swipe' then
		ChangeGear(sets.JA.Lunge)
	elseif spell.english == 'Meditate' then
		ChangeGear(sets.JA.Meditate)
	elseif spell.english == 'Provoke' then
		ChangeGear(sets.JA.Provoke)
	elseif spell.english == 'Warcry' then
		ChangeGear(sets.JA.Warcry)
	end
	
	--These spells can't override each other, and must be canceled--
	if spell.name == 'Valiance' or spell.name == 'Vallation' or spell.name == 'Liement' then
		if buffactive['Valiance']  then
			cast_delay(0.2)
			windower.ffxi.cancel_buff(535)
		elseif buffactive['Vallation']  then
			cast_delay(0.2)
			windower.ffxi.cancel_buff(531)
		elseif buffactive['Liement'] then
			cast_delay(0.2)
			windower.ffxi.cancel_buff(537)
		end
	end

	IgnoreWS = S { "Sanguine Blade", "Red Lotus Blade", "Flash Nova", "Realmrazer" }  -- Excluded from Moonshade TP override rule.
	BrutalWS = S { "Resolution"}
	STRWS = S {"Vorpal Blade", "Fell Cleave", "Circle Blade", "Swift Blade", "Shockwave" } -- Just uses the Resolution Set
	
	
	if spell.type == 'WeaponSkill' then
		if spell.english == 'Requiescat' then
			ChangeGear(sets.Requiescat[sets.Requiescat.index[Requiescat_ind]])
		elseif spell.english == 'Dimidiation' or spell.english == 'Ground Strike' or spell.english == 'Upheval' then
			ChangeGear(sets.Dimidiation[sets.Dimidiation.index[Dimidiation_ind]])
		elseif spell.english == 'Resolution' or STRWS:contains(spell.english) then
			ChangeGear(sets.Resolution[sets.Resolution.index[Resolution_ind]])
		elseif spell.english == 'Savage Blade' then
			ChangeGear(sets.SavageBlade[sets.SavageBlade.index[SavageBlade_ind]])
		elseif spell.english == 'Realmrazer' then
			ChangeGear(sets.Realmrazer[sets.Realmrazer.index[Realmrazer_ind]])
		elseif spell.english == 'Black Halo' or 'Judgement' then
			ChangeGear(sets.BlackHalo[sets.BlackHalo.index[BlackHalo_ind]])
		elseif spell.english == 'Flash Nova' or spell.english == 'Red Lotus Blade' then
			ChangeGear(sets.FlashNova)
		elseif spell.english == 'Sanguine Blade' then
			ChangeGear(sets.SanguineBlade)
		elseif spell.english == 'Armor Break' or spell.english == 'Weapon Break' then
			ChangeGear(sets.StatusWS)
		end
		if player.tp > 2025 and player.equipment.main == 'Lionheart' and buffactive['TP Bonus'] then
            if IgnoreWS:contains(spell.english) then
                return
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        elseif player.tp > 2275 and player.equipment.main == 'Lionheart' then
            if IgnoreWS:contains(spell.english) then
                return
			elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        elseif player.tp > 2550 and buffactive['TP Bonus'] then
            if IgnoreWS:contains(spell.english) then
                return
            elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        elseif player.tp > 2775 then
            if IgnoreWS:contains(spell.english) then
                return
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        end
    end

	if string.find(spell.english,'Step') then
		ChangeGear(set_combine(sets.TwoHandedTP.AccuracyFull, sets.Utility.TH))
	elseif spell.english == 'Animated Flourish' then
		ChangeGear(sets.Enmity)
	end
end

function pc_Magic(spell, act)
    if spell.action_type == 'Magic' then
        if buffactive['Vallation'] or buffactive ['Valiance'] then
            if spell.skill == 'Enhancing Magic' then
                ChangeGear(sets.precast.FC.ValEnhancing)
            else
                ChangeGear(sets.precast.FC.Val)
            end
        else
            if spell.skill == 'Enhancing Magic' then
                ChangeGear(sets.precast.FC.Enhancing)
            else
                ChangeGear(sets.precast.FC.Standard)
            end
        end
    end
end

function pc_Item(spell, act)
end

------------------------------------------
-- Midcast                 --
------------------------------------------
function mc_JA(spell, act)
end

function mc_Magic(spell, act)
	if spell.skill == 'Enhancing Magic' then
		if buffactive['Embolden'] then
			if spell.english == 'Phalanx' then
				ChangeGear(set_combine(sets.Enhancing.Phalanx, {back="Evasionist's Cape"}))
			elseif string.find(spell.english,'Shell') or string.find(spell.english,'Protect') then
				ChangeGear(set_combine(sets.Enhancing.ProShell, {back="Evasionist's Cape"}))
			else
				ChangeGear(set_combine(sets.Enhancing.Duration, {back="Evasionist's Cape"}))
			end
		elseif spell.english == 'Aquaveil' then
			ChangeGear(sets.SIR)
		elseif spell.english == 'Refresh' then
			ChangeGear(sets.Enhancing.Refresh)
		elseif string.find(spell.english,'Regen')then
			ChangeGear(sets.Enhancing.Regen)
		elseif string.find(spell.english,'Bar') then
			ChangeGear(sets.Enhancing.Barspell)
		elseif spell.english=="Temper" then
			ChangeGear(sets.Enhancing.Temper)
		elseif spell.english == 'Phalanx' then
			ChangeGear(sets.Enhancing.Phalanx)
		elseif spell.english == 'Crusade' then
			ChangeGear(sets.Enhancing.Crusade)
		elseif spell.english == 'Foil' then
			ChangeGear(sets.Enhancing.Foil)
		elseif string.find(spell.english,'Shell') or string.find(spell.english,'Protect') then
			ChangeGear(sets.Enhancing.ProShell)
		else
			ChangeGear(sets.Enhancing.Duration)
		end
	elseif spell.skill == 'Healing Magic' then
		if spell.target and spell.target.type == 'SELF' then
			ChangeGear(sets.Cures.SelfCures)
		else
			ChangeGear(sets.Cures)
		end
	elseif spell.skill == 'Enfeebling Magic' then 
		if spell.english == 'Sleepga' or spell.english == 'Poisonga' and TH == true then --For tanking/pulling Divergence to TH tag everything
			ChangeGear(set_combine(sets.SIR, sets.Utility.TH))
		end
	end

	if BlueMagic_Enmity:contains(spell.english) then
		ChangeGear(sets.Enmity)
	elseif BlueMagic_Buffs:contains(spell.english) then
		ChangeGear(sets.TankingTP.Tank)
	elseif PhysicalSpells:contains(spell.english) then
		ChangeGear(sets.BlueMagic.STR)
	elseif BlueMagic_Healing:contains(spell.english) then 
		if spell.target and spell.target.type == 'SELF' then
			ChangeGear(sets.Cures.SelfCures)
		else
			ChangeGear(sets.Cures)
		end
	elseif RUNMagic_Enmity:contains(spell.english) then
		ChangeGear(sets.Enmity)
	end
	
	if buffactive['Tenebrae'] and spell.english == 'Lunge' or spell.english == 'Swipe' then
		equip(sets.JA.Lunge,{head="Pixie Hairpin +1"})
	end
	
end

function mc_Item(spell, act)
end


------------------------------------------
-- After Cast               --
------------------------------------------
function ac_JA(spell)
end

function ac_Magic(spell)
end

function ac_Item(spell)
end

function ac_Global()
    if LockGearIndex == true then
        ChangeGear(LockGearSet)
        msg("Lock Gear is ON -- Swapping Gear")
    else
        if player.status == 'Engaged' then
            EngagedState()
        else
            IdleState()
        end
    end
end

------------------------------------------
-- Framework Core            --
------------------------------------------
function status_change(new, old)
	if new == 'Idle' then
		IdleState()
	elseif new == 'Resting' then
		RestingState()
	elseif new == 'Engaged' then
		EngagedState()
	end
	
	if player.status == 'Engaged' and TH == true then
		ChangeGear(set_combine(equipSet, sets.Utility.TH))			
	end
	
	if player.equipment.main ~= 'empty' then -- Changes 1H/2H TP during status change, combat, spell, etc.
        local weapon_skill = gearswap.res.items:with('en', player.equipment.main).skill
		if weapon_skill and S{1,4,6,7,8,10,12}:contains(weapon_skill) or player.equipment.main == 'empty' then --Checks mainhand weapon for TP set choice. See bottom notes.
            TwoHandedTP = true
        else
            TwoHandedTP = false
        end
    else
        msg("!!Main Weapon Not Equiped!!")
    end
	
end

--Numbers in the 1H 2H TP mode rule:
--1 = Hand-to-Hand
--2 = Dagger
--3 = Sword
--4 = Great Sword
--5 = Axe
--6 = Great Axe
--7 = Scythe
--8 = Polearm
--9 = Katana
--10 = Great Katana
--11 = Club
--12 = Staff


function precast(spell, act)
	if spell_control(spell) then
        cancel_spell()
        return
    end
	if spell.action_type == 'Ability' then
		pc_JA(spell, act)
	elseif spell.action_type == 'Magic' then
		pc_Magic(spell, act)
	else
		pc_Item(spell, act)
	end
end

function midcast(spell, act)
	IgnoreSIRSpell = S { "Phalanx", "Temper", "Refresh", "Regen"}  -- Excluded from Spell Interruption Rate override rule.
	if spell.action_type == 'Ability' then
		mc_JA(spell, act)
	elseif spell.action_type == 'Magic' then
		if SIR == true then
			if IgnoreSIRSpell:contains(spell.english) and not string.find(spell.english,'Bar') then
				mc_Magic(spell, act)
			elseif BlueMagic_Healing:contains(spell.english) then
				ChangeGear(set_combine(sets.SIR,{body = "Vrikodara Jupon", back = Ogma.Cure}))
			else
				ChangeGear(sets.SIR)
			end
		else
			mc_Magic(spell, act)
		end
	else
		mc_Item(spell, act)
	end
end

function aftercast(spell, act)
	if spell.action_type == 'Ability' then
		ac_JA(spell)
	elseif spell.action_type == 'Magic' then
		ac_Magic(spell)
	else
		ac_Item(spell)
	end
	ac_Global()
	
	--Countdowns--
	if not spell.interrupted then
		if spell.english == "Meditate" then
			send_command('wait 170;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
		elseif spell.english == "Sekkanoki" then
			send_command('wait 290;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
		elseif spell.english == "Swordplay" then
			send_command('wait 290;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
		elseif spell.english == "One for All" then
			send_command('wait 290;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
		elseif spell.english == "Battuta" then
			send_command('wait 290;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
		elseif spell.english == "Liement" then
			send_command('wait 170;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
		elseif spell.english == "Gambit" then
			send_command('timers create "Gabmit" 76 down')			
		elseif spell.english == "Rayke" then
			send_command('timers create "Rayke Debuff" 52 down')
		end
	end	
	
	if player.equipment.main ~= 'empty' then -- Changes action 
        local weapon_skill = gearswap.res.items:with('en', player.equipment.main).skill
        if weapon_skill and S{4,6,7,8,10,12}:contains(weapon_skill) then --Checks mainhand weapon for TP set choice.
            TwoHandedTP = true
        else
            TwoHandedTP = false
        end
    else
        msg("!!Main Weapon Not Equiped!!")
    end
	
end
	
	
function ChangeGear(GearSet)
	equipSet = GearSet
	equip(GearSet)
end

function LockGearSet(GearSet)
	LockedEquipSet = GearSet
	equip(GearSet)
	SetLocked = true
end

function UnlockGearSet()
	locked = false
	equip(equipSet)
end
