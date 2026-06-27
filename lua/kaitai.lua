---utils for Kaitai
local M = {}

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

---@param callback function
---@param number integer
---@param size integer
---@param be boolean?
function M.callback(callback, number, size, be)
    local bits = M.number_to_bits(number, size)
    for i = 1, #bits do
        if be then
            j = 1 + #bits - i
        else
            j = i
        end
        local byte = string.char(bits[j])
        callback(byte)
    end
end

---@param f table
---@param number integer
---@param size integer
---@param be boolean?
function M.write(f, number, size, be)
    M.callback(function(byte)
        f:write(byte)
    end, number, size, be)
end

return M
