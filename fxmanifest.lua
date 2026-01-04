fx_version 'cerulean'
game 'gta5'

author 'RP-Alpha'
description 'RP-Alpha Vehicle Keys'
version '1.0.0'

dependency 'rpa-lib'

client_script 'client/main.lua'
server_script 'server/main.lua'

-- Client exports
exports {
    'GiveKeys',
    'HasKeys',
    'RemoveKeys'
}

-- Server exports
server_exports {
    'GiveKeys',
    'GiveTempKeys',
    'RemoveKeys',
    'HasKeys'
}

lua54 'yes'
