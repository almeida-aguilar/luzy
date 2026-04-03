# The Luzy Programming Language

## Index
- [Comments](#comments)
- [Mutability](#mutability)
- [Basic Types](#basic-types)

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

### Type inference

```
var answer = 42
const PI = 3.14159
var is_cool = true
var favorite_streamer = "Tsoding"
```

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
