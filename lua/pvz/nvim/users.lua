---callbacks for users
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 113
local Users = require 'pvz.users'.Users
local M = {
    users = Users:from_path()
}

function M.read()
    vim.o.filetype = 'csv'
    local lines = M.users:get_lines()
    vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

function M.write()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    M.users:set_lines(lines)
    M.users:dump()
end

return M
