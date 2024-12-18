fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Niknock HD'
description 'Revivestation'
version '1.5.0'

client_script{
	'client.lua',
	'config.lua'
}

server_script{
	'config.lua',
	'server.lua',
	'update.lua'
}

shared_scripts {
	'config.lua'
}

dependencies {
	'es_extended'
}
