local function isseason(date, month)
    -- The month number after 3 months from the beginning of the season
    local in3 = ((month + 2) % 12) + 1
    return (date.month == month and date.day >= 21)
        or (date.month == in3 and date.day < 21)
        or date.month > month and date.month < in3
end

local function istwilight(date, sunrise, sunset)
    return date.hour >= sunset[1] and date.min >= sunset[2]
        or (date.hour == sunrise[1] and date.min < sunrise[2])
        or date.hour < sunrise[1]
end

-- Approximation of sunrise and sunset times in my local time and where I live
-- Pasted and formatted from https://in-the-sky.org
-- The data was originally calculated for the year 2023, but doesn't deviate
-- much in the next 10 years, so should be good enough for the next ~50?
local suntable = {
    [1] = { sunrise = { 8, 45 }, sunset = { 16, 26 } },
    [2] = { sunrise = { 8, 16 }, sunset = { 17, 16 } },
    [3] = { sunrise = { 7, 20 }, sunset = { 18, 10 } },
    [4] = { sunrise = { 7, 6 }, sunset = { 20, 7 } },
    [5] = { sunrise = { 5, 59 }, sunset = { 21, 0 } },
    [6] = { sunrise = { 5, 12 }, sunset = { 21, 48 } },
    [7] = { sunrise = { 5, 09 }, sunset = { 22, 2 } },
    [8] = { sunrise = { 5, 47 }, sunset = { 21, 28 } },
    [9] = { sunrise = { 6, 40 }, sunset = { 20, 23 } },
    [10] = { sunrise = { 7, 31 }, sunset = { 19, 11 } },
    [11] = { sunrise = { 7, 27 }, sunset = { 17, 3 } },
    [12] = { sunrise = { 8, 21 }, sunset = { 16, 20 } },
}

return {
    'folke/drop.nvim',
    enabled = false,
    event = 'VimEnter',
    config = function()
        local date = os.date '*t'
        local theme
        for m, t in pairs {
            -- starting month, theme
            -- all 'seasons' run for 3 months from the 21st of that month
            [3] = 'spring',
            [6] = 'summer',
            [9] = 'leaves',
            [12] = 'snow',
        } do
            if isseason(date, m) then
                theme = t
            end
        end
        local sun = suntable[date.month]
        if istwilight(date, sun.sunrise, sun.sunset) then
            theme = 'stars'
        end
        if date.month == 12 and (date.day == 25 or date.day == 26) then
            theme = 'xmas'
        end
        if date.month == 20 and date.day == 12 then
            theme = {
                symbols = {
                    '.',
                    '*',
                    '🎂',
                    '🍰',
                    '🎈',
                    '🎈',
                    '🎉',
                    '🎁',
                    '🕯️',
                },
                colors = {
                    '#CC82DE',
                    '#3BCE31',
                    '#BF315E',
                    '#2891A9',
                    '#FF773D',
                },
            }
        end
        -- If no theme for any reason, just bail and don't display the default
        -- leaves
        if theme then
            require('drop').setup {
                theme = theme,
                screensaver = false,
                max = vim.o.columns / 6,
            }
        end
    end,
}
