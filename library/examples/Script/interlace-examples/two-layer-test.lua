--[[
    two-layer-test
    This example runs code that checks if three mods are active: mod-a, mod-b, and mod-c.
    If mod-a or mod-b aren't active, or mod-b is under version 1.1, then testing stops.
    If they are active and mod-b is at or after version 1.1, then mod-c is checked.
    Note that you could remove the first :if_valid and the other checks should still work.
]]
local interlace = require 'interlace-examples.interlace'
interlace.dependency_test()
    :requires( interlace.get_mod_by_namespace 'mod-a' )
    :at_or_after( interlace.get_mod_by_namespace 'mod-b', "1.1" )
    :if_valid(function(info)
        print 'mod a and b are active and mod b is at or after version 1.1'
    end)
    :if_invalid(function(info)
        print 'mod a or b are not active; stopping test'
        info:stop_test()
    end)
    :requires( interlace.get_mod_by_namespace 'mod-c' )
    :if_valid(function(info)
        print 'mod c is active as well'
    end)
    :test()