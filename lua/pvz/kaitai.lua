---utils
local fs = require 'vim.fs'
local PlatformDirs = require 'platformdirs'.PlatformDirs
local M = {
    root = PlatformDirs {
        appname = fs.joinpath('io.github.wszqkzqk', 'PvZPortable'), version = 'userdata'
    }:user_data_dir(),
}

---@param number integer
---@param size integer
---@return integer[]
function M.number_to_bits(number, size)
    local bits = {}
    for i = 0, size - 1 do
        local bit = math.floor(number / (2 ^ 8) ^ i) % 2 ^ 8
        table.insert(bits, bit)
    end
    return bits
end

---@param f table
---@param number integer
---@param size integer
---@param be boolean?
function M.write(f, number, size, be)
    local bits = M.number_to_bits(number, size)
    for i = 1, #bits do
        if be then
            j = 1 + #bits - i
        else
            j = i
        end
        f:write(string.char(bits[j]))
    end
end

return M
