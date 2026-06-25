---callbacks for user
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 113
local Progress = require 'taisei.progress'.Progress
local M = {}

function M.read()
    vim.o.filetype = 'yaml'
    local progress = Progress:from_path()
    local lines = progress:get_lines()
    vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

function M.write()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    local progress = Progress:from_path()
    progress:set_lines(lines)
    progress:dump()
end

return M
