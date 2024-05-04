fx_version 'cerulean'
game 'gta5'

description 'Vehicle Information Script'
author 'Genesis'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config/shared.lua'
}

client_scripts { 
    'client.lua',
}

lua54 'yes'