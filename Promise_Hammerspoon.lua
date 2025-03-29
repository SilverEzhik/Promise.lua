--- Promise.lua extensions for Hammerspoon
-- @author [Ezhik](https://ezhik.jp)
-- @module Promise
-- @license MPL-2.0

-- Cache timers to avoid GC clearing them up before the promise resolves
local timers = {}
local function doAfter(s, fn)
    local timer
    timer = hs.timer.doAfter(s, function()
        timers[timer] = nil
        fn()
    end)
    timers[timer] = true
end

Promise.schedule = function(fn) doAfter(0, fn) end
