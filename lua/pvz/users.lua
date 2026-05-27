---users
local fs = require 'vim.fs'
local class = require("class").class
local Users = require 'pvz.kaitai.users'
local kaitai = require 'pvz.kaitai'
local M = {
    users_path = fs.joinpath(kaitai.root, 'users.dat'),
    Users = class(Users),
    header = 'id,timestamp,name'
}

---@param path string?
---@return table
function M.Users:from_path(path)
    path = path or M.users_path
    local users = self:from_file(path)
    users.path = path
    return users
end

---@return string[]
function M.Users:get_lines()
    local lines = { M.header }
    for _, user in ipairs(self.users) do
        local line = ("%s,%s,%s"):format(user.id, user.timestamp, user.name)
        table.insert(lines, line)
    end
    return lines
end

---@param lines string[]
function M.Users:set_lines(lines)
    local i = 0
    for _, line in ipairs(lines) do
        local id = line:match('^%d+')
        local timestamp = line:match('^%d+,(%d+)')
        local name = line:match('^%d+,%d+,(.*)')
        if id and timestamp and name then
            i = i + 1
            if self.users[i] == nil then
                self.users[i] = {
                    id = 0,
                    timestamp = 0,
                    name = '',
                    len_name = 0,
                }
            end
            self.users[i].id = tonumber(id)
            self.users[i].timestamp = tonumber(timestamp)
            self.users[i].name = name
            self.users[i].len_name = #name
        end
    end
    self.num_users = i
end

---@param path string?
function M.Users:dump(path)
    path = path or self.path or M.users_path
    local f = io.open(path, 'wb')
    if f then
        kaitai.write(f, self.version, 4)
        kaitai.write(f, self.num_users, 2)
        for _, user in ipairs(self.users) do
            kaitai.write(f, user.len_name, 2)
            f:write(user.name)
            kaitai.write(f, user.timestamp, 4)
            kaitai.write(f, user.id, 4)
        end
        f:close()
    end
end

return M
