local fs = require 'vim.fs'
local PlatformDirs = require 'platformdirs'.PlatformDirs
local app = PlatformDirs {
    appname = 'io.github.wszqkzqk',
    version = 'PvZPortable',
}
local M = {
    user_data_dir = fs.joinpath(app:user_data_dir(), 'userdata'),
    user_config_dir = app:user_config_dir(),
}

return M
