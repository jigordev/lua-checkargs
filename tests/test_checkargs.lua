local checkargs = require("checkargs")

local function test_check_arg()
    local status, err = pcall(function()
        checkargs.check_arg("test_func", "test_arg", { "string" }, "value", false, true)
    end)
    assert(status, err)

    status, err = pcall(function()
        checkargs.check_arg("test_func", "test_arg", { "string" }, 123, false, true)
    end)
    assert(not status, "Expected an error but got none")
end

local function test_check_list()
    local status, err = pcall(function()
        checkargs.check_list("test_func", "test_list", { "number" }, { 1, 2, 3 }, false, true)
    end)
    assert(status, err)

    status, err = pcall(function()
        checkargs.check_list("test_func", "test_list", { "number" }, { 1, "two", 3 }, false, true)
    end)
    assert(not status, "Expected an error but got none")
end

local function test_check_range()
    local status, err = pcall(function()
        checkargs.check_range("test_func", "test_value", 5, 1, 10, true)
    end)
    assert(status, err)

    status, err = pcall(function()
        checkargs.check_range("test_func", "test_value", 15, 1, 10, true)
    end)
    assert(not status, "Expected an error but got none")
end

local function test_check_fields()
    local status, err = pcall(function()
        checkargs.check_fields("test_func", "test_table", { a = 1, b = 2 }, { "a", "b" }, true)
    end)
    assert(status, err)

    status, err = pcall(function()
        checkargs.check_fields("test_func", "test_table", { a = 1 }, { "a", "b" }, true)
    end)
    assert(not status, "Expected an error but got none")
end

local function test_check_composite()
    local status, err = pcall(function()
        checkargs.check_composite("test_func", "test_composite", { a = 1, b = "test" }, { a = "number", b = "string" },
            true)
    end)
    assert(status, err)

    status, err = pcall(function()
        checkargs.check_composite("test_func", "test_composite", { a = 1, b = 2 }, { a = "number", b = "string" }, true)
    end)
    assert(not status, "Expected an error but got none")
end

local function test_check_not_nil()
    local status, err = pcall(function()
        checkargs.check_not_nil("test_func", "test_value", "value", true)
    end)
    assert(status, err)

    status, err = pcall(function()
        checkargs.check_not_nil("test_func", "test_value", nil, true)
    end)
    assert(not status, "Expected an error but got none")
end

local function runtests()
    test_check_arg()
    test_check_list()
    test_check_range()
    test_check_fields()
    test_check_composite()
    test_check_not_nil()
    print("All tests passed successfully!")
end

runtests()
