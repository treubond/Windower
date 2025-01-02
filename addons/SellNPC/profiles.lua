-- Add items to existing profiles or create your own to sell groups of items using alias commands
local profiles = {}

-- //sellnpc powder
profiles['powder'] = S{
    'prize powder',
    }

-- //sellnpc shield
profiles['shield'] = S{
    'Acheron Shield',
    'Ritter Shield',
}

profiles['cp'] = S{
    'Ryl.Sqr. Halberd',
    'Musketeer Gun',
    'Ryl.Swd. Blade',
}

-- //sellnpc ore
profiles['ore'] = S{
    'iron ore',
    'copper ore',
    'tin ore',
    }

-- //sellnpc junk
profiles['junk'] = S{
    'chestnut',
    'san d\'Or. carrot',
    }

return profiles