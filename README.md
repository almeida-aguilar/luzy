# The Luzy Programming Language

## Index
- [Comments](#comments)
- [Mutability](#mutability)
- [Basic Types](#basic-types)
- [Basic Functions](#basic-functions)
- [Basic Operators](#basic-operators)

## Comments

Comments start with `--` just as Lua.

```
-- This is a comment
var hello = "world" --> this is a comment too
-- the part I like the most of this type of
-- comments is that you can create cute arrows
--> like this
```

## Mutability

The `var` keyword indicates that the value can change.

```
var health_points = 100
health_points = 90
```

Instead, the `const` keyword indicates that the value cannot change.

```
const PI = 3.14159
PI = 3 --> this will throw an error
```

## Basic Types

```
var answer: int = 42
const PI: float = 3.14159
var is_cool: bool = true
var favorite_streamer: string = "Tsoding"
```

### Naming conventions

By convention, `var` variables use `lower_snake_case` and `const` constants use `UPPER_SNAKE_CASE`.

```
var health_points = 100
const MAX_HEALTH = 100
```

These are conventions, not rules enforced by the language. However, following them makes code easier to read and search.

### Case and underscore sensitivity

Luzy is case and underscore sensitive. This means that `player_health`, `Player_health`, and `playerhealth` are three completely different identifiers.

```
var player_health: bool = true
var Player_health: bool = false  --> different variable
```

This forces consistency across the entire codebase, making identifiers easier to search and reducing accidental name collisions.

### Type inference

```
var answer = 42
const PI = 3.14159
var is_cool = true
var favorite_streamer = "Tsoding"
```

> [!NOTE]
> Type inference only works for primitive types (`int`, `float`, `bool`, `string`). For any custom type, alias, or struct, the type annotation is required — otherwise the compiler cannot distinguish between two types that share the same structure or underlying value.
> ```
> var id: ID = 42          -- required, int and ID are ambiguous
> var pos: vector2 = {.x = 0, .y = 0}  -- required, any struct with x and y would match
> ```

### Type compatibility

Between `float` and `int` there are some important behaviors. `float` accepts `int` values (automatically promoted), but `int` does not accept `float`.

**Float compatibility with Int:**

```
var x_chord: float = 10.5
x_chord = 3
print(x_chord)
```

```
> 3.0
```

**Int compatibility with Float:**

```
var level: int = 10
level = 1.5
```

```
> ERROR: You cannot assign a float value to an int
```

To make it work you have to convert the `float` value to `int`.

```
var level: int = 10
level = floor(1.5)
print(level)
```

```
> 1
```

> [!DECISION]
> There is no `float()` or `int()` casting. I have decided to keep `float` and `int` as types, and let the `floor()`, `ceil()` and `round()` functions handle the conversion.

### No implicit type coercion

Outside of the `float`/`int` relationship described above, there is no compatibility between types. Any operation or assignment that mixes unrelated types will throw an error.

```
var name: string = "Luzy"
var age: int = 3
var result = name + age --> ERROR: Cannot use operator '+' between string and int
```

```
var flag: bool = true
var score: int = 10
score = flag --> ERROR: Cannot assign a bool value to an int
```

This applies to all type combinations: `string` with `int`, `string` with `float`, `string` with `bool`, `bool` with `int`, and so on.

## Basic Functions

Functions are declared with the `fun` keyword. The header ends with `=` to keep it visually consistent with variable declarations.

```
fun add(a: int, b: int): int =
    return a + b
end
```

> [!FUN FACT]
> The `fun` keyword was chosen because it means "fun" in English.

> [!DECISION]
> The function header ends with `=` because it looks similar to a variable declaration, keeping the language visually consistent.

### Return type

If a function declares a return type, it must use `return` explicitly. `return` does not have to be at the end — it can appear anywhere in the body, for example to return early on an error.

```
fun add(a: int, b: int): int =
    return a + b
end
```

If a function has no return type, it returns nothing and `return` is not allowed inside it. There is no `void` type.

```
fun display_name(const name: string) =
    println("hola ", name, "!")
end
```

### Parameter passing

Luzy has three ways to pass arguments, declared explicitly on each parameter.

**Copy (default)** — if no keyword is used, the function receives a copy of the value. Mutations inside the function do not affect the original variable.

```
fun heal_previsualization(health: int): int =
    health += 50
    return health
end
```

**`var`** — the function receives a mutable reference. Mutations inside the function affect the original variable.

```
fun heal(var health: int) =
    health += 50
end
```

**`const`** — the function receives a read-only reference. The value cannot be mutated inside the function.

```
fun display_name(const name: string) =
    println("hola ", name, "!")
end
```

> [!NOTE]
> Always prefer `const` for arguments you don't need to mutate — it makes the intent clear and prevents accidental modifications. Use `var` only when mutating the original is the explicit goal.

## Basic Operators

### Arithmetic

Luzy supports two styles for some operators — a symbolic one and a word-based one. Both are equivalent; use whichever feels more readable to you.

#### Addition

`int + int` returns `int`. `float + float` returns `float`. If one operand is `int` and the other is `float`, the `int` is promoted to `float` to avoid losing information.

```
1 + 1        --> 2   (int)
1.0 + 1.0    --> 2.0 (float)
1 + 2.5      --> 3.5 (float, int promoted)
floor(1 + 2.5) --> 3 (int)
ceil(1 + 2.5)  --> 4 (int)
round(1 + 2.5) --> 4 (int)
```

#### Subtraction

Same promotion rules as addition.

```
3 - 1        --> 2   (int)
3.0 - 1.0    --> 2.0 (float)
6 - 2.5      --> 3.5 (float, int promoted)
floor(6 - 2.5) --> 3 (int)
ceil(6 - 2.5)  --> 4 (int)
round(6 - 2.5) --> 4 (int)
```

#### Multiplication

Same promotion rules as addition.

```
3 * 2        --> 6   (int)
3.0 * 2.0    --> 6.0 (float)
3 * 2.5      --> 7.5 (float, int promoted)
floor(3 * 2.5) --> 7 (int)
ceil(3 * 2.5)  --> 8 (int)
round(3 * 2.5) --> 8 (int)
```

#### Division (`/`)

Division always returns `float` to avoid losing information.

```
3 / 2        --> 1.5 (float)
3.0 / 2.0    --> 1.5 (float)
3 / 2.0      --> 1.5 (float)
floor(3 / 2) --> 1   (int)
ceil(3 / 2)  --> 2   (int)
round(3 / 2) --> 2   (int)
1 / 0        --> ERROR: Division by zero
```

#### Integer division (`//` or `div`)

Integer division only works between `int` operands and always returns `int`. Using a `float` operand throws an error.

```
3 // 2       --> 1   (int)
3 div 2      --> 1   (int)
3.0 // 2.0   --> ERROR: Integer division is not valid for float
3 div 2.5    --> ERROR: Integer division is not valid for float
1 // 0       --> ERROR: Division by zero
```

#### Modulo (`%` or `mod`)

Same rules as integer division — only works between `int` operands.

```
3 % 2        --> 1   (int)
3 mod 2      --> 1   (int)
3.0 % 2.0    --> ERROR: Modulo is not valid for float
3 mod 2.5    --> ERROR: Modulo is not valid for float
1 % 0        --> ERROR: Division by zero
```

> [!DECISION]
> `//`, `div`, `%`, and `mod` are strict about types because guaranteeing an integer result with float operands is not always possible. Use `floor()`, `ceil()`, or `round()` on the result of `/` instead.

### Compound assignment

Compound assignment operators follow the same type rules as their base operators.

```
var health = 100       -- int
health += 10           -- OK: 110 (int)
health *= 1.5          -- ERROR: Cannot assign float to int

var scale = 1.0     -- float
scale += 5          -- OK: 6.0 (int promoted to float)
scale *= 2.5        -- OK: 2.5 (float)

var pos_x = 10.0
pos_x /= 2           -- OK: 5.0 (float)

var points = 10
points /= 2          -- ERROR: Cannot assign float to int, use '//=' for integer division

var bullets = 50
bullets //= 2       -- OK: 25 (int)
bullets div= 3      -- OK: 8  (int)

var remainder = 10
remainder %= 3           -- OK: 1 (int)
remainder mod= 3         -- OK: 1 (int)

var f = 10.0
f //= 2              -- ERROR: Integer division is not valid for float
```

### Logic

All logical operators return `bool`.

> [!DECISION]
> Luzy supports both symbolic and word-based logical operators for the same reason as `//`/`div` and `%`/`mod` — different people read code differently.

#### And

```
a && b
a and b
```

#### Or

```
a || b
a or b
```

#### Not

```
~a
not a
```

> [!DECISION]
> `!` is not used as the `not` operator because it is reserved for error handling.

#### Equality

```
a == b
a is b
```

> [!DECISION]
> `is` is equivalent to `==` because Luzy avoids explicit pointer usage. There is no pointer address comparison, so `is` can safely mean value equality.

#### Inequality

```
a ~= b
a isnt b
```

#### Comparison

```
a < b
a > b
a >= b
a <= b
```
