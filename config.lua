Config = {}

-- ============================================
-- PERMISSION CONFIGURATION
-- ============================================

-- Admin permissions (can manage keys globally)
Config.AdminPermissions = {
    groups = { 'admin', 'god' },
    jobs = {},
    minGrade = 0,
    onDuty = false,
    convar = 'rpa:admins',
    resourceConvar = 'admin'
}

-- Lockpick permissions (who can use lockpicks)
Config.LockpickPermissions = {
    groups = {},
    jobs = { 'police', 'mechanic', 'tow' },
    minGrade = 0,
    onDuty = false,
    -- Set to nil to allow anyone with the item
    allowAll = true
}

-- ============================================
-- GENERAL SETTINGS
-- ============================================

-- Key items
Config.LockpickItem = 'lockpick'
Config.AdvancedLockpickItem = 'advancedlockpick'

-- Time to lockpick (milliseconds)
Config.LockpickTime = 15000
Config.AdvancedLockpickTime = 8000

-- Chance to break lockpick (0-100)
Config.LockpickBreakChance = 25
Config.AdvancedBreakChance = 10

-- Alert police when lockpicking
Config.AlertPolice = true
Config.AlertChance = 50 -- Percentage chance to alert

-- ============================================
-- HOTWIRE SETTINGS
-- ============================================

Config.Hotwire = {
    enabled = true,
    time = 20000,
    minigame = true, -- Use skill check minigame
    alertPolice = true,
    alertChance = 75,
    -- Hotwire doesn't give permanent keys, just starts the vehicle
    tempKeys = true
}

-- ============================================
-- VEHICLE CLASS SETTINGS
-- ============================================

-- Different settings per vehicle class
Config.VehicleClasses = {
    -- Class 0: Compacts
    [0] = { lockpickTime = 12000, hotwireTime = 15000 },
    -- Class 1: Sedans
    [1] = { lockpickTime = 15000, hotwireTime = 18000 },
    -- Class 2: SUVs
    [2] = { lockpickTime = 18000, hotwireTime = 22000 },
    -- Class 3: Coupes
    [3] = { lockpickTime = 15000, hotwireTime = 18000 },
    -- Class 4: Muscle
    [4] = { lockpickTime = 15000, hotwireTime = 18000 },
    -- Class 5: Sports Classics
    [5] = { lockpickTime = 20000, hotwireTime = 25000 },
    -- Class 6: Sports
    [6] = { lockpickTime = 22000, hotwireTime = 28000 },
    -- Class 7: Super
    [7] = { lockpickTime = 25000, hotwireTime = 35000 },
    -- Class 8: Motorcycles
    [8] = { lockpickTime = 8000, hotwireTime = 10000 },
    -- Class 18: Emergency
    [18] = { lockpickTime = 30000, hotwireTime = 40000 }
}

-- ============================================
-- SHARED KEYS SETTINGS
-- ============================================

Config.SharedKeys = {
    enabled = true,
    maxShares = 5, -- Max number of people who can have keys to one vehicle
    -- Allow gang/job members to share keys more easily
    gangSharing = true,
    jobSharing = true
}
