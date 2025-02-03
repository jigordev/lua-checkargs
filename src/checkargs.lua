local checkargs = {}

-- Helper function to check if a value exists in a table
local function contains(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

-- Helper function to perform checks with conditional error or assertion
local function check(use_error, condition, message)
    if not condition then
        if use_error then
            error(message)
        else
            assert(condition, message)
        end
    end
end

-- Checks if an argument matches the expected type or is optional and nil
function checkargs.check_arg(func, name, expected, value, optional, default, use_error)
    check(use_error, contains(expected, type(value)) or (optional and value == nil),
        string.format("Error in %s: Argument '%s' must be a %s, got: %s", func, name, table.concat(expected, ", "),
            type(value)))
    return value or default
end

-- Checks a list of arguments against an expected type
function checkargs.check_list(func, name, expected, list, optional, default, use_error)
    local args = {}
    for _, arg in ipairs(list) do
        table.insert(args, checkargs.check_arg(func, name, expected, arg, optional, default, use_error))
    end
    return args
end

-- Checks if a number is within a specified range
function checkargs.check_range(func, name, value, min, max, default, use_error)
    check(use_error, type(value) == "number",
        string.format("Error in %s: Argument '%s' must be a number, got: %s", func, name, type(value)))
    check(use_error, value >= min and value <= max,
        string.format("Error in %s: Argument '%s' must be between %d and %d, got: %d", func, name, min, max, value))
    return value or default
end

-- Checks if a table contains specified fields
function checkargs.check_fields(func, name, tbl, fields, default, use_error)
    check(use_error, type(tbl) == "table",
        string.format("Error in %s: Argument '%s' must be a table, got: %s", func, name, type(tbl)))
    for _, field in ipairs(fields) do
        check(use_error, tbl[field] ~= nil,
            string.format("Error in %s: Table '%s' must contain field '%s'", func, name, field))
    end
    return tbl or default
end

-- Checks if a table matches a composite structure with specific field types
function checkargs.check_composite(func, name, value, expected_fields, default, use_error)
    check(use_error, type(value) == "table",
        string.format("Error in %s: Argument '%s' must be a table, got: %s", func, name, type(value)))
    for field, field_type in pairs(expected_fields) do
        check(use_error, type(value[field]) == field_type,
            string.format("Error in %s: Field '%s' in argument '%s' must be a %s, got: %s", func, field, name, field_type,
                type(value[field])))
    end
    return value or default
end

-- Checks if an argument is not nil
function checkargs.check_not_nil(func, name, value, default, use_error)
    check(use_error, value ~= nil, string.format("Error in %s: Argument '%s' must not be nil", func, name))
    return value or default
end

return checkargs