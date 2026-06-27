---progress
-- unknown content size
-- local zstd = require 'zstd'
local crc32 = require 'crc32'.crc32
local fs = require 'vim.fs'
-- local fn = require 'vim.fn'
local PlatformDirs = require 'platformdirs'.PlatformDirs
local app = PlatformDirs { appname = 'taisei' }
local yaml = require 'yaml'
local class = require("class").class
local Progress = require 'kaitai.taisei_progress'
local kaitai = require 'kaitai'
local M = {
    magic1 = 0x66746700,
    magic2 = 0x8483E36F,
    crc_in = 0xB16B00B5,
    characters = {
        { [0] = "博丽 灵梦", "laser", "star" },
        { [0] = "雾雨 魔理沙", "mirror", "haunting" },
        { [0] = "魂魄 妖梦", "spirit", "dream" }
    },
    stages = { "雾之湖遭遇战", "河畔流雏", "令人痒痒的登山之旅", "被遗忘的宅邸", "巴别塔之攀", "世界之脊" },
    difficulties = { [0] = "Any", "Easy", "Normal", "Hard", "Lunatic", "Extra" },
    progress_path = fs.joinpath(app:user_data_dir(), 'progress'),
    Progress = class(Progress),
}

---@param path string?
---@return table
function M.Progress:from_path(path)
    path = path or M.progress_path
    local user
    -- if fn.filereadable(path) == 0 then
    --     path = fs.joinpath(path, 'zst') or path
    --     local f = io.open(path, "rb")
    --     local data = ''
    --     if f then
    --         data = f:read "*a"
    --         f:close()
    --     end
    --     local raw, err = zstd.decompress(data)
    --     if err then
    --         print(err)
    --     end
    --     user = self:from_string(raw)
    --     user.zst = true
    -- else
    user = self:from_file(path)
    -- end
    user.path = path
    return user
end

---@return string[]
function M.Progress:get_lines()
    local lines = { "---" }
    local unlock_stages
    local unlock_difficulty = 0
    local hiscore = 0
    local playinfos = {}
    for _, cmd in ipairs(self.cmds) do
        if cmd.id.label == 'endings' then
            table.insert(lines, ("%s: %d"):format('ending', cmd.payload.ending))
            table.insert(lines, ("%s: %d"):format('num_achieved', cmd.payload.num_achieved))
        elseif cmd.id.label == 'game_settings' then
            table.insert(lines,
                ("%s: %d  # %s"):format('difficulty', cmd.payload.difficulty, M.difficulties[cmd.payload.difficulty]))
            table.insert(lines,
                ("%s: %d  # %s"):format('character', cmd.payload.character, M.characters[cmd.payload.character + 1][0]))
            table.insert(lines,
                ("%s: %d  # %s"):format('shotmode', cmd.payload.shotmode,
                    M.characters[cmd.payload.character + 1][cmd.payload.shotmode + 1]))
        elseif cmd.id.label == 'unlock_bgms' then
            table.insert(lines, ("%s: %d"):format('unlock_bgms', cmd.payload))
        elseif cmd.id.label == 'unlock_cutscenes' then
            table.insert(lines, ("%s: %d"):format('unlock_cutscenes', cmd.payload))
        elseif cmd.id.label == 'unlock_stages' then
            unlock_stages = cmd.payload
        elseif cmd.id.label == 'unlock_stages_with_difficulty' then
            unlock_stages = cmd.payload.stage
            unlock_difficulty = cmd.payload.difficulty
        elseif cmd.id.label == 'hiscore' or cmd.id.label == 'hiscore_64bit' then
            hiscore = cmd.payload
        elseif cmd.id.label == 'stage_playinfo' then
            for _, playinfo in ipairs(cmd.payload.playinfos) do
                local k = ("%s-%s"):format(playinfo.header.stage, playinfo.header.difficulty)
                if playinfos[k] == nil then
                    playinfos[k] = {}
                end
                playinfos[k].num_played = playinfo.num_played
                playinfos[k].num_cleared = playinfo.num_cleared
            end
        elseif cmd.id.label == 'stage_playinfo2' then
            for _, playinfo in ipairs(cmd.payload.playinfos) do
                local k = ("%s-%s"):format(playinfo.header.stage, playinfo.header.difficulty)
                if playinfos[k] == nil then
                    playinfos[k] = {}
                end
                playinfos[k].hiscore = playinfo.hiscore
                for i, percharacter in ipairs(playinfo.percharacters) do
                    playinfos[k][i] = {}
                    for j, permode in ipairs(percharacter.permodes) do
                        playinfos[k][i][j] = {}
                        playinfos[k][i][j].hiscore = permode.hiscore
                        playinfos[k][i][j].num_cleared = permode.num_cleared
                        playinfos[k][i][j].num_played = permode.num_played
                    end
                end
            end
        end
    end
    if unlock_stages then
        table.insert(lines, ("%s: %d  # %s"):format('unlock_stages', unlock_stages, M.stages[unlock_stages]))
        table.insert(lines,
            ("%s: %d  # %s"):format('unlock_difficulty', unlock_difficulty, M.difficulties[unlock_difficulty]))
    end
    if hiscore then
        table.insert(lines, ("%s: %d"):format('hiscore', hiscore))
    end
    table.insert(lines, "playinfo:")
    for k, playinfo in pairs(playinfos) do
        table.insert(lines, ("  -  # %s"):format(k))
        local stage = tonumber(k:match("^%d+")) or 0
        local difficulty = tonumber(k:match("%d+$")) or 0
        table.insert(lines, ("    %s: %d  # %s"):format('stage', stage, M.stages[stage]))
        table.insert(lines, ("    %s: %d  # %s"):format('difficulty', difficulty, M.difficulties[difficulty]))
        if playinfo.num_played then
            table.insert(lines, ("    %s: %d"):format('num_played', playinfo.num_played))
        end
        if playinfo.num_cleared then
            table.insert(lines, ("    %s: %d"):format('num_cleared', playinfo.num_cleared))
        end
        if playinfo.hiscore then
            table.insert(lines, ("    %s: %d"):format('hiscore', playinfo.hiscore))
        end
        table.insert(lines, ("    %s:"):format('percharacters'))
        for i, permodes in ipairs(playinfo) do
            table.insert(lines, ("      -  # %s"):format(M.characters[i][0]))
            for j, permode in ipairs(permodes) do
                table.insert(lines, ("        -  # %s"):format(M.characters[i][j]))
                table.insert(lines, ("          %s: %d"):format("num_played", permode.num_played))
                table.insert(lines, ("          %s: %d"):format("num_cleared", permode.num_cleared))
                table.insert(lines, ("          %s: %d"):format("hiscore", permode.hiscore))
            end
        end
    end
    return lines
end

---@param lines string[]
function M.Progress:set_lines(lines)
    local data = yaml.load(table.concat(lines, "\n"))
    for _, cmd in ipairs(self.cmds) do
        if data.unlock_stages then
            if cmd.id.label == 'unlock_stages' then
                cmd.payload = data.unlock_stages
            elseif cmd.id.label == 'unlock_stages_with_difficulty' then
                cmd.payload.stage = data.unlock_stages
            end
        end
        if data.unlock_difficulty and cmd.id.label == 'unlock_difficulty' then
            cmd.payload.difficulty = data.unlock_difficulty
        end
        if data.unlock_bgms and cmd.id.label == 'unlock_bgms' then
            cmd.payload = data.unlock_bgms
        end
        if data.unlock_cutscenes and cmd.id.label == 'unlock_cutscenes' then
            cmd.payload = data.unlock_cutscenes
        end
        if cmd.id.label == 'game_settings' then
            if data.difficulty then
                cmd.payload.difficulty = data.difficulty
            end
            if data.character then
                cmd.payload.character = data.character
            end
            if data.shotmode then
                cmd.payload.shotmode = data.shotmode
            end
        end
        if data.hiscore and (cmd.id.label == 'hiscore' or cmd.id.label == 'hiscore_64bit') then
            cmd.payload = data.hiscore
        end
        for k, playinfo in ipairs(data.playinfo) do
            if cmd.id.label == 'stage_playinfo' or cmd.id.label == 'stage_playinfo2' then
                if cmd.payload.playinfos[k] == nil then
                    cmd.payload.playinfos[k] = {}
                end
                cmd.payload.playinfos[k].stage = playinfo.stage or 0
                cmd.payload.playinfos[k].difficulty = playinfo.difficulty or 0
            end
            if cmd.id.label == 'stage_playinfo' then
                cmd.payload.playinfos[k].num_played = playinfo.num_played or 0
                cmd.payload.playinfos[k].num_cleared = playinfo.num_cleared or 0
            elseif cmd.id.label == 'stage_playinfo2' then
                cmd.payload.playinfos[k].hiscore = playinfo.hiscore or 0
                for i, permodes in ipairs(playinfo.percharacters) do
                    cmd.payload.playinfos[k].percharacters = cmd.payload.playinfos[k].percharacters or {}
                    if cmd.payload.playinfos[k].percharacters[i] == nil then
                        cmd.payload.playinfos[k].percharacters[i] = {}
                    end
                    for j, permode in ipairs(permodes) do
                        cmd.payload.playinfos[k].percharacters[i].permodes = cmd.payload.playinfos[k].percharacters[i]
                            .permodes or {}
                        if cmd.payload.playinfos[k].percharacters[i].permodes[j] == nil then
                            cmd.payload.playinfos[k].percharacters[i].permodes[j] = {}
                        end
                        cmd.payload.playinfos[k].percharacters[i].permodes[j].num_played = permode.num_played or 0
                        cmd.payload.playinfos[k].percharacters[i].permodes[j].num_cleared = permode.num_cleared or 0
                        cmd.payload.playinfos[k].percharacters[i].permodes[j].hiscore = permode.hiscore or 0
                    end
                end
            end
        end
    end
end

---@param path string?
function M.Progress:dump(path)
    path = path or self.path or M.progress_path
    local str = ''
    local function callback(byte)
        str = str .. byte
    end

    kaitai.callback(callback, M.magic1, 4)
    kaitai.callback(callback, M.magic2, 4)
    local data = self:get_data()
    kaitai.callback(callback, crc32(M.crc_in, data), 4)
    str = str .. data

    local raw = str
    -- local err
    -- if self.zst then
    --     raw, err = zstd.compress(str)
    -- end
    -- if err then
    --     print(err)
    --     return
    -- end
    local f = io.open(path, "wb")
    if f then
        f:write(raw)
        f:close()
    end
end

---@return string
function M.Progress:get_data()
    local str = ''
    local function callback(byte)
        str = str .. byte
    end

    for _, cmd in ipairs(self.cmds) do
        kaitai.callback(callback, cmd.id.value, 1)
        if cmd.id.label == 'game_version' then
            kaitai.callback(callback, cmd.len_payload, 2)
            kaitai.callback(callback, cmd.payload.major, 1)
            kaitai.callback(callback, cmd.payload.minor, 1)
            kaitai.callback(callback, cmd.payload.patch, 1)
            kaitai.callback(callback, cmd.payload.tweak, 2)
        elseif cmd.id.label == 'game_settings' then
            kaitai.callback(callback, cmd.len_payload, 2)
            kaitai.callback(callback, cmd.payload.difficulty, 1)
            kaitai.callback(callback, cmd.payload.character, 1)
            kaitai.callback(callback, cmd.payload.shotmode, 1)
        elseif cmd.id.label == 'hiscore' then
            kaitai.callback(callback, 4, 2)
            kaitai.callback(callback, cmd.payload, 4)
        elseif cmd.id.label == 'hiscore_64bit' then
            kaitai.callback(callback, 8, 2)
            kaitai.callback(callback, cmd.payload, 8)
        elseif cmd.id.label == 'unlock_bgms' then
            kaitai.callback(callback, 8, 2)
            kaitai.callback(callback, cmd.payload, 8)
        elseif cmd.id.label == 'unlock_cutscenes' then
            kaitai.callback(callback, 8, 2)
            kaitai.callback(callback, cmd.payload, 8)
        elseif cmd.id.label == 'unlock_stages' then
            kaitai.callback(callback, 2, 2)
            kaitai.callback(callback, cmd.payload, 2)
        elseif cmd.id.label == 'unlock_stages_with_difficulty' then
            kaitai.callback(callback, 3, 2)
            kaitai.callback(callback, cmd.payload.stage, 2)
            kaitai.callback(callback, cmd.payload.difficulty, 1)
        elseif cmd.id.label == 'endings' then
            kaitai.callback(callback, 5, 2)
            kaitai.callback(callback, cmd.payload.ending, 1)
            kaitai.callback(callback, cmd.payload.num_achieved, 4)
        elseif cmd.id.label == 'stage_playinfo' then
            kaitai.callback(callback, 11 * #cmd.payload.playinfos, 2)
            for _, playinfo in ipairs(cmd.payload.playinfos) do
                kaitai.callback(callback, playinfo.header.stage, 2)
                kaitai.callback(callback, playinfo.header.difficulty, 1)
                kaitai.callback(callback, playinfo.num_played, 4)
                kaitai.callback(callback, playinfo.num_cleared, 4)
            end
        elseif cmd.id.label == 'stage_playinfo2' then
            kaitai.callback(callback, 107 * #cmd.payload.playinfos, 2)
            for _, playinfo in ipairs(cmd.payload.playinfos) do
                kaitai.callback(callback, playinfo.header.stage, 2)
                kaitai.callback(callback, playinfo.header.difficulty, 1)
                kaitai.callback(callback, playinfo.hiscore, 8)
                for _, percharacter in ipairs(playinfo.percharacters) do
                    for _, permode in ipairs(percharacter.permodes) do
                        kaitai.callback(callback, permode.num_played, 4)
                        kaitai.callback(callback, permode.num_cleared, 4)
                        kaitai.callback(callback, permode.hiscore, 8)
                    end
                end
            end
        end
    end
    return str
end

return M
