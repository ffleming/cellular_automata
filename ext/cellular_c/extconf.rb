# ext/extconf.rb
require 'mkmf'
extension_name = 'cellular_c'
dir_config(extension_name)
create_header
create_makefile(extension_name)
