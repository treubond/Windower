_addon.name = 'init'
_addon.author = 'selk'
_addon.version = '0.1'

files = require 'files'

default = 'init_default'

windower.register_event('login',function (name)
char = 'init_%s':format(name:lower())

if files.exists('..\\..\\scripts\\%s.txt':format(char)) then
default = char
end

windower.send_command('exec %s':format(default))
windower.send_command('lua unload init')
end)