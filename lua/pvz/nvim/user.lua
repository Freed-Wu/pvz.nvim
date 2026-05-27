---callbacks for user
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 113
local User = require 'pvz.user'.User
local M = {}

---@param id integer
function M.read(id)
    vim.o.filetype = 'yaml'
    local user = User:from_id(id)
    local lines = user:get_lines()
    vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

---@param id integer
function M.write(id)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    local user = User:from_id(id)
    user:set_lines(lines)
    user:dump()
end

return M
