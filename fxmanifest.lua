fx_version 'cerulean'
game 'gta5'

author 'DevDyls | Created on: 28/12/2024'
description 'FiveM Delivery Script with NativeUI Integration'
version '2.0.0'

-- NativeUI must be loaded first
client_scripts {
    'client/NativeUI.lua',
    'client/client.lua'
}

server_script 'server/server.lua'
