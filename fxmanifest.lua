fx_version 'cerulean'
game 'gta5'

author 'RP-Alpha'
description 'RP-Alpha Vehicle Keys'
version '1.1.0'

dependency 'rpa-lib'

shared_script 'config.lua'

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
