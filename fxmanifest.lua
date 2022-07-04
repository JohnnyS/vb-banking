fx_version 'adamant'

game 'gta5'
author 'VB-Scripts (VisiBait#0712) | Edited by Team Smoove'
description 'Banking for ESX'
version '1.0.0'
lua54 'yes'
ui_page "html/index.html"

shared_script {'@es_extended/imports.lua', '@ox_lib/init.lua'}

client_scripts {
    'client/*.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'config.lua'
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/img/*.PNG',
    'html/img/*.jpg',
    'html/css/*.css',
    'html/img/fonts/*.ttf',
    'html/img/fonts/*.otf',
    'html/img/fonts/*.woff',
}