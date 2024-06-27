# lua-checkargs

`checkargs` is a Lua library designed for argument validation in Lua functions. It provides functions to validate function arguments based on various criteria such as type, range, presence of fields in tables, and more.

## Installation

You can install `checkargs` using LuaRocks:

```bash
luarocks install lua-checkargs
```

## Usage

### Functions

#### check_arg(func, name, expected, value, optional, use_error)
Validates a single argument `value` against expected types `expected`. Throws an error if validation fails when `use_error` is `true`.

#### check_list(func, name, expected, list, optional, use_error)
Validates each element in `list` against expected types `expected`. Throws an error if any element fails validation when `use_error` is `true`.

#### check_range(func, name, value, min, max, use_error)
Validates a numeric `value` to ensure it falls within the specified range `[min, max]`. Throws an error if validation fails when `use_error` is `true`.

#### check_fields(func, name, tbl, fields, use_error)
Validates that table `tbl` contains all specified `fields`. Throws an error if any field is missing when `use_error` is `true`.

#### check_composite(func, name, value, expected_fields, use_error)
Validates a table `value` against expected field types specified in `expected_fields`. Throws an error if any field type mismatch is found when `use_error` is `true`.

#### check_not_nil(func, name, value, use_error)
Validates that `value` is not `nil`. Throws an error if `value` is `nil` when `use_error` is `true`.

### Example

```lua
local checkargs = require('checkargs')

function greet(name)
    checkargs.check_arg("greet", "name", {"string"}, name, false, true)
    print("Hello, " .. name .. "!")
end

greet("Alice")  -- Outputs: Hello, Alice!
greet(123)      -- Throws an error: Argument 'name' must be a string, got: number

```

## License

This library is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for more details.