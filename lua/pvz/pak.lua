---unpak main.pak
local user_config_dir = require 'pvz'.user_config_dir
local bit = require 'bit'
local fn = require 'vim.fn'
local fs = require 'vim.fs'
local uv = require 'vim.uv'
local kaitai = require 'kaitai'
local Pak = require 'kaitai.pvz_main_pak'
local M = {
    key = 0xF7,
    magic = 0xbac04ac0,
    depth = 16,
    pak_path = fs.joinpath(user_config_dir, 'main.pak'),
    pak_xor_path = fs.joinpath(user_config_dir, 'main.pak.xor'),
    unpak_path = fs.joinpath(user_config_dir, 'main'),
    usage = [[
%s xor|ls|unpak|pak]]
}

---@param fname string?
---@param outfile string?
---@param key integer?
function M.xor(fname, outfile, key)
    fname = fname or M.pak_path
    outfile = outfile or fname .. '.xor'
    key = key or M.key

    local f = io.open(fname, 'rb')
    if f then
        local data = f:read '*a'
        f:close()
        f = io.open(outfile, 'wb')
        if f then
            for i = 1, #data do
                local byte = data:byte(i)
                local xor_byte = bit.bxor(byte, key)
                f:write(string.char(xor_byte))
            end
            f:close()
        end
    end
end

---@param fname string?
function M.ls(fname)
    fname = fname or M.pak_xor_path
    local pak = Pak:from_file(fname)
    for i = 1, #pak.files - 1 do
        local file = pak.files[i]
        local name = file.name:gsub("\\", '/')
        print(name)
    end
end

---@param fname string?
---@param dir string?
function M.unpak(fname, dir)
    fname = fname or M.pak_xor_path
    dir = dir or M.unpak_path
    local pak = Pak:from_file(fname)
    for i = 1, #pak.files - 1 do
        local file = pak.files[i]
        local name = file.name:gsub("\\", "/")
        name = fs.joinpath(dir, name)
        fn.mkdir(fs.dirname(name), 'p')
        local f = io.open(name, "wb")
        if f then
            local bytes = pak._io._io:read(file.size)
            f:write(bytes)
            f:close()
        end
    end
end

---@param dir string?
---@param fname string?
function M.pak(dir, fname)
    dir = dir or M.unpak_path
    fname = fname or M.pak_xor_path
    local f = io.open(fname, 'wb')
    if f then
        kaitai.write(f, M.magic, 8)
        local paths = {}
        for name in fs.dir(dir, { depth = M.depth }) do
            local path = fs.joinpath(dir, name)
            if fn.isdirectory(path) == 0 then
                kaitai.write(f, 0, 1)
                kaitai.write(f, #name, 1)
                local tmp = name:gsub('/', '\\')
                f:write(tmp)
                kaitai.write(f, uv.fs_stat(path).size, 4)
                kaitai.write(f, 0, 8)
                table.insert(paths, path)
            end
        end
        f:write '\80'
        for _, path in ipairs(paths) do
            local ff = io.open(path)
            if ff then
                local data = ff:read '*a'
                f:write(data)
                ff:close()
            end
        end
        f:close()
    end
end

---@param args string[]
function M.main(args)
    if args[1] == 'xor' then
        M.xor(args[2], args[3], args[4] and tonumber(args[4]))
    elseif args[1] == 'ls' then
        M.ls(args[2])
    elseif args[1] == 'unpak' then
        M.unpak(args[2], args[3])
    elseif args[1] == 'pak' then
        M.pak(args[2], args[3])
    else
        print(M.usage:format(args[0]))
    end
end

return M
