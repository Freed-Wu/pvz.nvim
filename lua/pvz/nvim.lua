---for neovim
---@diagnostic disable: undefined-global
-- luacheck: ignore 111 113
local M = {}

function M.create_autocmds(augroup_id)
    augroup_id = augroup_id or vim.api.nvim_create_augroup("pvz", {})
    vim.api.nvim_create_autocmd({ "BufReadCmd", "SessionLoadPost" }, {
        pattern = "pvz://*",
        group = augroup_id,
        callback = M.read_cb
    })
    vim.api.nvim_create_autocmd("BufWriteCmd", {
        pattern = "pvz://*",
        group = augroup_id,
        callback = M.write_cb
    })
end

---@return integer?
function M.get_id()
    local url = vim.api.nvim_buf_get_name(0)
    local id = url:match("^pvz://(%d+)")
    return id
end

function M.read_cb()
    vim.o.buftype = "acwrite"
    local id = M.get_id()
    if id then
        require 'pvz.nvim.user'.read(id)
    else
        require 'pvz.nvim.users'.read()
    end
end

function M.write_cb()
    if vim.o.modifiable == false then
        return
    end
    local id = M.get_id()
    if id then
        require 'pvz.nvim.user'.write(id)
    else
        require 'pvz.nvim.users'.write()
    end
    vim.o.modified = false
end

return M
