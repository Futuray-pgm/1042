testing_1042 = false

tests_1042 = {
    registered_tests = {},

    print = function(text)
        if testing_1042 then
            core.log("warning", "1042_tests: " .. tostring(text))

            return true
        end

        return false
    end,

    register_test = function(namein, func)
        local name = tostring(namein)

        if namein and func and testing_1042 and not tests_1042.registered_tests[name] then
            tests_1042.registered_tests[name] = func

            tests_1042.print("Registered: '" .. name .. "' to run on mods loaded...")
            
            return true
        end

        return false
    end
}



if not core.settings:get_bool("1042_enable_intigrated_tests", false) then 
    return

else
    testing_1042 = true
    local version = core.get_version()
    core.log("action", "Loading 1042_tests (" .. version.project .. " " .. version.string .. ")...")

end




core.register_on_mods_loaded(function()
    for name, func in pairs(tests_1042.registered_tests) do
        local ret = func() or "NO RETURN"
        tests_1042.print("Result of test '" .. name .. "': " .. tostring(ret))
    end
end)


core.log("action", "1042_tests loaded.")