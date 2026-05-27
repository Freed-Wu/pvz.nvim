---user
local fs = require 'vim.fs'
local yaml = require 'yaml'
local class = require("class").class
local User = require 'pvz.kaitai.user'
local kaitai = require 'pvz.kaitai'
local M = {
    User = class(User),
}

---@param id integer
---@return table
function M.User:from_id(id)
    local path = fs.joinpath(kaitai.user_data_dir, ('user%d.dat'):format(id))
    local user = self:from_file(path)
    user.path = path
    return user
end

---@return string[]
function M.User:get_lines()
    local lines = { "---" }
    for _, name in ipairs { "adventure_level", "money_div_10", "adventure_completed_times" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# Survival flags (normal)")
    for _, name in ipairs { "survival_day_flags", "survival_night_flags", "survival_pool_flags", "survival_fog_flags", "survival_roof_flags" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# Survival flags (hard)")
    for _, name in ipairs { "survival_day_hard_flags", "survival_night_hard_flags", "survival_pool_hard_flags", "survival_fog_hard_flags", "survival_roof_hard_flags" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# Survival endless streaks")
    for _, name in ipairs { "streak_day_endless", "streak_night_endless", "streak_pool_endless", "streak_fog_endless", "streak_roof_endless" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# Minigame trophies")
    for _, name in ipairs { "trophy_zombotany", "trophy_wallnut_bowling", "trophy_slot_machine", "trophy_raining_seeds", "trophy_beghouled", "trophy_invisighoul", "trophy_seeing_stars", "trophy_zombiquarium", "trophy_beghouled_twist", "trophy_big_trouble_little_zombie", "trophy_portal_combat", "trophy_column_like_you_see_em", "trophy_bobsled_bonanza", "trophy_zombie_nimble_zombie_quick", "trophy_whack_a_zombie", "trophy_last_stand", "trophy_zombotany_2", "trophy_wallnut_bowling_2", "trophy_pogo_party", "trophy_dr_zomboss_revenge" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# Hidden Minigame trophies")
    for _, name in ipairs { "trophy_art_challenge_wallnut", "trophy_sunny_day", "trophy_unsodded", "trophy_big_time", "trophy_art_challenge_sunflower", "trophy_air_raid", "trophy_ice_level", "trophy_zen_garden_limbo", "trophy_high_gravity", "trophy_grave_danger", "trophy_can_you_dig_it", "trophy_dark_stormy_night", "trophy_bungee_blitz", "trophy_squirrel" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# Misc")
    local name = "tree_of_wisdom_height"
    table.insert(lines, ("%s: %d"):format(name, self[name]))
    table.insert(lines, "# Puzzle trophies")
    for _, name in ipairs { "trophy_vasebreaker", "trophy_to_the_left", "trophy_third_vase", "trophy_chain_reaction", "trophy_m_is_for_metal", "trophy_scary_potter", "trophy_hokey_pokey", "trophy_another_chain_reaction", "trophy_ace_of_vase", "streak_vasebreaker_endless" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# I, Zombie puzzles")
    for _, name in ipairs { "trophy_i_zombie", "trophy_i_zombie_too", "trophy_can_you_dig_it_puzzle", "trophy_totally_nuts", "trophy_dead_zeppelin", "trophy_me_smash", "trophy_zomboogie", "trophy_three_hit_wonder", "trophy_all_your_brainz_r_belong_to_us", "streak_i_zombie_endless", "trophy_upsell_limbo", "trophy_intro_limbo" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# Shop plants")
    for _, name in ipairs { "has_gatling_pea", "has_twin_sunflower", "has_gloom_shroom", "has_cattail", "has_winter_melon", "has_gold_magnet", "has_spikerock", "has_cob_cannon", "has_imitater" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    for _, name in ipairs { "marigold_days_left", "marigold_days_center", "marigold_days_right", "has_golden_watering_can", "fertilizer_amount", "bug_spray_amount", "has_phonograph", "has_gardening_glove", "has_mushroom_garden", "has_wheel_barrow", "stinky_last_awoken", "seed_slots_minus_6", "has_pool_cleaner", "has_roof_cleaner", "garden_rake_uses", "has_aquarium_garden", "chocolate_amount", "tree_of_wisdom_available", "tree_food_amount", "has_wallnut_first_aid" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    for _, name in ipairs { "almanac_flag", "stinky_last_chocolate", "stinky_x", "stinky_y", "minigames_unlocked", "puzzle_mode_unlocked", "animate_minigame_unlock", "animate_vasebreaker_unlock", "animate_i_zombie_unlock", "animate_survival_unlock", "animate_limbo_unlock", "show_adventure_complete", "has_taco", "stinky_asleep" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# Zen Garden plants")
    table.insert(lines, "zen_plants:")
    for i, zen_plant in ipairs(self.zen_plants) do
        table.insert(lines, ("  - # %d"):format(i))
        for _, name in ipairs { "plant_type", "garden_location", "column", "row", "direction", "last_watered", "color", "times_fertilized", "times_watered", "water_needed", "happiness_state", "last_phono_bugspray", "last_fertilized", "last_chocolate" } do
            table.insert(lines, ("    %s: %d"):format(name, zen_plant[name]))
        end
    end
    table.insert(lines, "# Achievements")
    for _, name in ipairs { "home_lawn_security", "nobel_peas_prize", "better_off_dead", "china_shop", "spudow", "explodonator", "morticulturalist", "dont_pea_in_the_pool", "roll_some_heads", "grounded", "zombologist", "penny_pincher", "sunny_days", "popcorn_party", "good_morning", "no_fungus_among_us", "beyond_the_grave", "immortal", "towering_wisdom", "mustache_mode", "zombatar_license_accepted" } do
        table.insert(lines, ("%s: %d"):format(name, self[name]))
    end
    table.insert(lines, "# Zombatars")
    table.insert(lines, "zombatars:")
    for i, zombatar in ipairs(self.zombatars) do
        table.insert(lines, ("  - # %d"):format(i))
        for _, name in ipairs { "skin_color", "clothes_type", "clothes_color", "tidbits_type", "tidbits_color", "accessories_type", "accessories_color", "facial_hair_type", "facial_hair_color", "hair_type", "hair_color", "eyewear_type", "eyewear_color", "hat_type", "hat_color", "backdrop_type", "backdrop_color" } do
            table.insert(lines, ("    %s: %d"):format(name, zombatar[name]))
        end
    end
    local name = "dont_display_saved_jpeg_to_desktop_message"
    table.insert(lines, ("%s: %d"):format(name, self[name]))
    return lines
end

---@param lines string[]
function M.User:set_lines(lines)
    local data = yaml.load(table.concat(lines, "\n"))
    for _, name in ipairs { "adventure_level", "money_div_10", "adventure_completed_times" } do
        self[name] = data[name]
    end
    for _, name in ipairs { "survival_day_flags", "survival_night_flags", "survival_pool_flags", "survival_fog_flags", "survival_roof_flags" } do
        self[name] = data[name]
    end
    for _, name in ipairs { "survival_day_hard_flags", "survival_night_hard_flags", "survival_pool_hard_flags", "survival_fog_hard_flags", "survival_roof_hard_flags" } do
        self[name] = data[name]
    end
    for _, name in ipairs { "streak_day_endless", "streak_night_endless", "streak_pool_endless", "streak_fog_endless", "streak_roof_endless" } do
        self[name] = data[name]
    end
    for _, name in ipairs { "trophy_zombotany", "trophy_wallnut_bowling", "trophy_slot_machine", "trophy_raining_seeds", "trophy_beghouled", "trophy_invisighoul", "trophy_seeing_stars", "trophy_zombiquarium", "trophy_beghouled_twist", "trophy_big_trouble_little_zombie", "trophy_portal_combat", "trophy_column_like_you_see_em", "trophy_bobsled_bonanza", "trophy_zombie_nimble_zombie_quick", "trophy_whack_a_zombie", "trophy_last_stand", "trophy_zombotany_2", "trophy_wallnut_bowling_2", "trophy_pogo_party", "trophy_dr_zomboss_revenge" } do
        self[name] = data[name]
    end
    for _, name in ipairs { "trophy_art_challenge_wallnut", "trophy_sunny_day", "trophy_unsodded", "trophy_big_time", "trophy_art_challenge_sunflower", "trophy_air_raid", "trophy_ice_level", "trophy_zen_garden_limbo", "trophy_high_gravity", "trophy_grave_danger", "trophy_can_you_dig_it", "trophy_dark_stormy_night", "trophy_bungee_blitz", "trophy_squirrel" } do
        self[name] = data[name]
    end
    local name = "tree_of_wisdom_height"
    self[name] = data[name]
    for _, name in ipairs { "trophy_vasebreaker", "trophy_to_the_left", "trophy_third_vase", "trophy_chain_reaction", "trophy_m_is_for_metal", "trophy_scary_potter", "trophy_hokey_pokey", "trophy_another_chain_reaction", "trophy_ace_of_vase", "streak_vasebreaker_endless" } do
        self[name] = data[name]
    end
    for _, name in ipairs { "trophy_i_zombie", "trophy_i_zombie_too", "trophy_can_you_dig_it_puzzle", "trophy_totally_nuts", "trophy_dead_zeppelin", "trophy_me_smash", "trophy_zomboogie", "trophy_three_hit_wonder", "trophy_all_your_brainz_r_belong_to_us", "streak_i_zombie_endless", "trophy_upsell_limbo", "trophy_intro_limbo" } do
        self[name] = data[name]
    end
    for _, name in ipairs { "has_gatling_pea", "has_twin_sunflower", "has_gloom_shroom", "has_cattail", "has_winter_melon", "has_gold_magnet", "has_spikerock", "has_cob_cannon", "has_imitater" } do
        self[name] = data[name]
    end
    for _, name in ipairs { "marigold_days_left", "marigold_days_center", "marigold_days_right", "has_golden_watering_can", "fertilizer_amount", "bug_spray_amount", "has_phonograph", "has_gardening_glove", "has_mushroom_garden", "has_wheel_barrow", "stinky_last_awoken", "seed_slots_minus_6", "has_pool_cleaner", "has_roof_cleaner", "garden_rake_uses", "has_aquarium_garden", "chocolate_amount", "tree_of_wisdom_available", "tree_food_amount", "has_wallnut_first_aid" } do
        self[name] = data[name]
    end
    for _, name in ipairs { "almanac_flag", "stinky_last_chocolate", "stinky_x", "stinky_y", "minigames_unlocked", "puzzle_mode_unlocked", "animate_minigame_unlock", "animate_vasebreaker_unlock", "animate_i_zombie_unlock", "animate_survival_unlock", "animate_limbo_unlock", "show_adventure_complete", "has_taco", "stinky_asleep" } do
        self[name] = data[name]
    end
    if data.zen_plants == "" then
        data.zen_plants = {}
    end
    self.num_zen_plants = #data.zen_plants
    for i, zen_plant in ipairs(data.zen_plants) do
        if self.zen_plants[i] == nil then
            self.zen_plants[i] = {
                plant_type = 0,
                garden_location = 0,
                column = 0,
                row = 0,
                direction = 0,
                unknown_14 = 0,
                last_watered = 0,
                unknown_1c = 0,
                color = 0,
                times_fertilized = 0,
                times_watered = 0,
                water_needed = 0,
                happiness_state = 0,
                unknown_34 = 0,
                last_phono_bugspray = 0,
                unknown_3c = 0,
                last_fertilized = 0,
                unknown_44 = 0,
                last_chocolate = 0,
                unknown_4c = 0,
                unknown_50 = 0,
                unknown_54 = 0,
            }
        end
        for _, name in ipairs { "plant_type", "garden_location", "column", "row", "direction", "last_watered", "color", "times_fertilized", "times_watered", "water_needed", "happiness_state", "last_phono_bugspray", "last_fertilized", "last_chocolate" } do
            self.zen_plants[i][name] = zen_plant[name]
        end
    end
    for _, name in ipairs { "home_lawn_security", "nobel_peas_prize", "better_off_dead", "china_shop", "spudow", "explodonator", "morticulturalist", "dont_pea_in_the_pool", "roll_some_heads", "grounded", "zombologist", "penny_pincher", "sunny_days", "popcorn_party", "good_morning", "no_fungus_among_us", "beyond_the_grave", "immortal", "towering_wisdom", "mustache_mode", "zombatar_license_accepted" } do
        self[name] = data[name]
    end
    if data.zombatars == "" then
        data.zombatars = {}
    end
    self.num_zombatars = #data.zombatars
    for i, zombatar in ipairs(data.zombatars) do
        if self.zombatars[i] == nil then
            self.zombatars[i] = {
                unknown_00 = 0,
                skin_color = 0,
                clothes_type = 0,
                clothes_color = 0,
                tidbits_type = 0,
                tidbits_color = 0,
                accessories_type = 0,
                accessories_color = 0,
                facial_hair_type = 0,
                facial_hair_color = 0,
                hair_type = 0,
                hair_color = 0,
                eyewear_type = 0,
                eyewear_color = 0,
                hat_type = 0,
                hat_color = 0,
                backdrop_type = 0,
                backdrop_color = 0,
            }
        end
        for _, name in ipairs { "skin_color", "clothes_type", "clothes_color", "tidbits_type", "tidbits_color", "accessories_type", "accessories_color", "facial_hair_type", "facial_hair_color", "hair_type", "hair_color", "eyewear_type", "eyewear_color", "hat_type", "hat_color", "backdrop_type", "backdrop_color" } do
            self.zombatars[i][name] = zombatar[name]
        end
    end
    local name = "dont_display_saved_jpeg_to_desktop_message"
    self[name] = data[name]
end

---@param path string?
function M.User:dump(path)
    path = path or self.path or M.user_path
    local f = io.open(path, 'wb')
    if f then
        kaitai.write(f, self.version, 4)
        for _, name in ipairs { "adventure_level", "money_div_10", "adventure_completed_times" } do
            kaitai.write(f, self[name], 4)
        end
        for _, name in ipairs { "survival_day_flags", "survival_night_flags", "survival_pool_flags", "survival_fog_flags", "survival_roof_flags" } do
            kaitai.write(f, self[name], 4)
        end
        for _, name in ipairs { "survival_day_hard_flags", "survival_night_hard_flags", "survival_pool_hard_flags", "survival_fog_hard_flags", "survival_roof_hard_flags" } do
            kaitai.write(f, self[name], 4)
        end
        for _, name in ipairs { "streak_day_endless", "streak_night_endless", "streak_pool_endless", "streak_fog_endless", "streak_roof_endless" } do
            kaitai.write(f, self[name], 4)
        end
        for _, name in ipairs { "trophy_zombotany", "trophy_wallnut_bowling", "trophy_slot_machine", "trophy_raining_seeds", "trophy_beghouled", "trophy_invisighoul", "trophy_seeing_stars", "trophy_zombiquarium", "trophy_beghouled_twist", "trophy_big_trouble_little_zombie", "trophy_portal_combat", "trophy_column_like_you_see_em", "trophy_bobsled_bonanza", "trophy_zombie_nimble_zombie_quick", "trophy_whack_a_zombie", "trophy_last_stand", "trophy_zombotany_2", "trophy_wallnut_bowling_2", "trophy_pogo_party", "trophy_dr_zomboss_revenge" } do
            kaitai.write(f, self[name], 4)
        end
        for _, name in ipairs { "trophy_art_challenge_wallnut", "trophy_sunny_day", "trophy_unsodded", "trophy_big_time", "trophy_art_challenge_sunflower", "trophy_air_raid", "trophy_ice_level", "trophy_zen_garden_limbo", "trophy_high_gravity", "trophy_grave_danger", "trophy_can_you_dig_it", "trophy_dark_stormy_night", "trophy_bungee_blitz", "trophy_squirrel" } do
            kaitai.write(f, self[name], 4)
        end
        local name = "tree_of_wisdom_height"
        kaitai.write(f, self[name], 4)
        for _, name in ipairs { "trophy_vasebreaker", "trophy_to_the_left", "trophy_third_vase", "trophy_chain_reaction", "trophy_m_is_for_metal", "trophy_scary_potter", "trophy_hokey_pokey", "trophy_another_chain_reaction", "trophy_ace_of_vase", "streak_vasebreaker_endless" } do
            kaitai.write(f, self[name], 4)
        end
        for _, name in ipairs { "trophy_i_zombie", "trophy_i_zombie_too", "trophy_can_you_dig_it_puzzle", "trophy_totally_nuts", "trophy_dead_zeppelin", "trophy_me_smash", "trophy_zomboogie", "trophy_three_hit_wonder", "trophy_all_your_brainz_r_belong_to_us", "streak_i_zombie_endless", "trophy_upsell_limbo", "trophy_intro_limbo" } do
            kaitai.write(f, self[name], 4)
        end
        local name = "unknown_130_19f"
        f:write(self[name])
        for _, name in ipairs { "has_gatling_pea", "has_twin_sunflower", "has_gloom_shroom", "has_cattail", "has_winter_melon", "has_gold_magnet", "has_spikerock", "has_cob_cannon", "has_imitater" } do
            kaitai.write(f, self[name], 4)
        end
        local name = "unknown_1c4"
        kaitai.write(f, self[name], 4)
        for _, name in ipairs { "marigold_days_left", "marigold_days_center", "marigold_days_right", "has_golden_watering_can", "fertilizer_amount", "bug_spray_amount", "has_phonograph", "has_gardening_glove", "has_mushroom_garden", "has_wheel_barrow", "stinky_last_awoken", "seed_slots_minus_6", "has_pool_cleaner", "has_roof_cleaner", "garden_rake_uses", "has_aquarium_garden", "chocolate_amount", "tree_of_wisdom_available", "tree_food_amount", "has_wallnut_first_aid" } do
            kaitai.write(f, self[name], 4)
        end
        local name = "unknown_218_2ef"
        f:write(self[name])
        for _, name in ipairs { "almanac_flag", "stinky_last_chocolate", "stinky_x", "stinky_y", "minigames_unlocked", "puzzle_mode_unlocked", "animate_minigame_unlock", "animate_vasebreaker_unlock", "animate_i_zombie_unlock", "animate_survival_unlock", "animate_limbo_unlock", "show_adventure_complete", "has_taco", "stinky_asleep" } do
            kaitai.write(f, self[name], 4)
        end
        local name = "unknown_328"
        kaitai.write(f, self[name], 4)
        local name = "unknown_32c"
        kaitai.write(f, self[name], 4)
        local name = "num_zen_plants"
        kaitai.write(f, self[name], 4)
        for _, zen_plant in ipairs(self.zen_plants) do
            for _, name in ipairs { "plant_type", "garden_location", "column", "row", "direction" } do
                kaitai.write(f, zen_plant[name], 4)
            end
            name = "unknown_14"
            kaitai.write(f, zen_plant[name], 4)
            name = "last_watered"
            kaitai.write(f, zen_plant[name], 4)
            name = "unknown_1c"
            kaitai.write(f, zen_plant[name], 4)
            for _, name in ipairs { "color", "times_fertilized", "times_watered", "water_needed", "happiness_state" } do
                kaitai.write(f, zen_plant[name], 4)
            end
            name = "unknown_34"
            kaitai.write(f, zen_plant[name], 4)
            name = "last_phono_bugspray"
            kaitai.write(f, zen_plant[name], 4)
            name = "unknown_3c"
            kaitai.write(f, zen_plant[name], 4)
            name = "last_fertilized"
            kaitai.write(f, zen_plant[name], 4)
            name = "unknown_44"
            kaitai.write(f, zen_plant[name], 4)
            name = "last_chocolate"
            kaitai.write(f, zen_plant[name], 4)
            name = "unknown_4c"
            kaitai.write(f, zen_plant[name], 4)
            name = "unknown_50"
            kaitai.write(f, zen_plant[name], 4)
            name = "unknown_54"
            kaitai.write(f, zen_plant[name], 4)
        end

        for _, name in ipairs { "home_lawn_security", "nobel_peas_prize", "better_off_dead", "china_shop", "spudow", "explodonator", "morticulturalist", "dont_pea_in_the_pool", "roll_some_heads", "grounded", "zombologist", "penny_pincher", "sunny_days", "popcorn_party", "good_morning", "no_fungus_among_us", "beyond_the_grave", "immortal", "towering_wisdom", "mustache_mode" } do
            kaitai.write(f, self[name], 2)
        end
        local name = "zombatar_license_accepted"
        kaitai.write(f, self[name], 1)
        local name = "num_zombatars"
        kaitai.write(f, self[name], 4)
        for _, zombatar in ipairs(self.zombatars) do
            local name = "unknown_00"
            kaitai.write(f, zombatar[name], 4)
            for _, name in ipairs { "skin_color", "clothes_type", "clothes_color", "tidbits_type", "tidbits_color", "accessories_type", "accessories_color", "facial_hair_type", "facial_hair_color", "hair_type", "hair_color", "eyewear_type", "eyewear_color", "hat_type", "hat_color", "backdrop_type", "backdrop_color" } do
                kaitai.write(f, zombatar[name], 4)
            end
        end
        local name = "unknown_tail"
        f:write(self[name])
        local name = "dont_display_saved_jpeg_to_desktop_message"
        kaitai.write(f, self[name], 1)
        f:close()
    end
end

return M
