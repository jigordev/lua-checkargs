local checkargs = {}

local function contains(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

local function check(use_error, condition, message)
    if not condition then
        if use_error then
            error(message)
        else
            assert(condition, message)
        end
    end
end

function checkargs.check_arg(func, name, expected, value, optional, use_error)
    check(use_error, contains(expected, type(value)) or (optional and value == nil),
        string.format("Error in %s: Argument '%s' must be a %s, got: %s", func, name, table.concat(expected, ", "),
            type(value)))
end

function checkargs.check_list(func, name, expected, list, optional, use_error)
    for _, arg in ipairs(list) do
        checkargs.check_arg(func, name, expected, arg, optional, use_error)
    end
end

function checkargs.check_range(func, name, value, min, max, use_error)
    check(use_error, type(value) == "number",
        string.format("Error in %s: Argument '%s' must be a number, got: %s", func, name, type(value)))
    check(use_error, value >= min and value <= max,
        string.format("Error in %s: Argument '%s' must be between %d and %d, got: %d", func, name, min, max, value))
end

function checkargs.check_fields(func, name, tbl, fields, use_error)
    check(use_error, type(tbl) == "table",
        string.format("Error in %s: Argument '%s' must be a table, got: %s", func, name, type(tbl)))
    for _, field in ipairs(fields) do
        check(use_error, tbl[field] ~= nil,
            string.format("Error in %s: Table '%s' must contain field '%s'", func, name, field))
    end
end

function checkargs.check_composite(func, name, value, expected_fields, use_error)
    check(use_error, type(value) == "table",
        string.format("Error in %s: Argument '%s' must be a table, got: %s", func, name, type(value)))
    for field, field_type in pairs(expected_fields) do
        check(use_error, type(value[field]) == field_type,
            string.format("Error in %s: Field '%s' in argument '%s' must be a %s, got: %s", func, field, name, field_type,
                type(value[field])))
    end
end

function checkargs.check_not_nil(func, name, value, use_error)
    check(use_error, value ~= nil, string.format("Error in %s: Argument '%s' must not be nil", func, name))
end

return checkargs