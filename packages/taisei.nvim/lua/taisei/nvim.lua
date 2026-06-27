---for neovim
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 113
local M = {}

function M.create_autocmds(augroup_id)
    augroup_id = augroup_id or vim.api.nvim_create_augroup("taisei", {})
    vim.api.nvim_create_autocmd({ "BufReadCmd", "SessionLoadPost" }, {
        pattern = "taisei://*",
        group = augroup_id,
        callback = M.read_cb
    })
    vim.api.nvim_create_autocmd("BufWriteCmd", {
        pattern = "taisei://*",
        group = augroup_id,
        callback = M.write_cb
    })
end

function M.read_cb()
    vim.o.buftype = "acwrite"
    require 'taisei.nvim.progress'.read()
end

function M.write_cb()
    if vim.o.modifiable == false then
        return
    end
    require 'taisei.nvim.progress'.write()
    vim.o.modified = false
end

return M
