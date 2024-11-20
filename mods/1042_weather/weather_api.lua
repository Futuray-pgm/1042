-- weather_api.lua
--[[
    Core API meant to be shared in both mapgen enviorment and main.
]]
weather = {}

weather.rand = PcgRandom(math.random(1, 2048))


local weather_def = {
    offset = 0,
    scale = 1,
    spread = {x = 600, y = 600, z = 600},
    seed = core.get_mapgen_setting("seed") + 253643,
    octaves = 3,
    persist = 0.3,
    lacunarity = 2,
    flags = {
        eased = true,
        absvalue = false,
        defaults = false
    }
}

local temp_m = PerlinNoiseMap(weather_def, {x=80, y=80})
local temp_s = PerlinNoise(weather_def)

-- Single vector to be used once so as to not make a whole bunch
local v = vector.new(0, 0, 0)


function weather.get_temp_map(x, z)
    v.x = z
    v.y = x
    return temp_m:get_2d_map(v)
end

function weather.get_temp(pos, temp_map)
    return temp_map[pos.x][pos.z] * 30
end


function weather.get_temp_single(pos)
    v.x = pos.z
    v.y = pos.x
    local tempv = temp_s:get_2d(v) * 30
    return tempv
end
