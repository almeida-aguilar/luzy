# The Luzy Programming Language

## Index

- [Comments](#comments)
- [Mutability](#mutability)
- [Basic Types](#basic-types)

## Comments

Comments starts with `--` just as Lua

```
-- This is a comment
var hello = "world" --> this is a comment too
-- the part a I like the most of this type of
-- comments is that you can create cute arrows
--> like this
```

## Mutabilty

The `var` keyword indicates that the value can change

```
var health_points = 100
health_points = 90
```

Instead, the `const` keyword indicates that the value can not change

```
const PI = 3.14159
PI = 3 --> this will pop an error
```

# Basic Types

```
var answer: int = 42
const PI: float = 3.14159
var is_cool: bool = true
var favorite_streamer: string = "Tsoding"
var status: rune = '🫩' --> this is utf-8
```


## Funciones

```luzy
fun suma(a: int, b: int): int
    return a + b
end
```

## Array

```luzy
var lista_a: []int = {1, 2, 3}
var lista_b = lista_a -- lista_b es una COPIA física de lista_a

lista_a.add(4)
-- lista_a es {1, 2, 3, 4}
-- lista_b sigue siendo {1, 2, 3}

const lista_c []string  = {"manzana", "banana", "coco"}
lista_c.add("piña") -- ERROR: los arrays constantes no pueden ser modificados
```

## Definicion de tipos

### Alias

```luzy
type ID: int
type Kilometros: float
type Segundos: int
```

### Struct

```luzy
type Player struct
    nombre: string
    salud:  int
    equipamiento: []string
end

var player: Player = { nombre = "hero", salud = 100,
                       equipamiento = {"espada", "escudo"}
                     }
```

### Enums

```luzy
type EstadoMotor enum
    Apagado
    Encendido
    Falla
end
```

### Funcion (callback)

```luzy
type LoggerFunc: fun(msg: string)

fun ejecutar_con_log(log: LoggerFunc)
    log("Ejecutando tarea...")
end
```

## Paso de parametros

```luzy
-- 'p' es una copia. Los cambios aquí no afectan al original.
fun simular(p: Player)
    p.Salud = 0 
end
-- 'const p' indica que recibimos el objeto original solo lectura (Referencia).
fun simular(const p: Player)
    p.Salud = 0 
end
-- 'var p' indica que recibimos el objeto original (Referencia).
fun curar(var p: Player, cantidad: int)
    p.Salud = p.Salud + cantidad
end
```

## Bucles

```luzy
while (true) do
    print("infinito")
end

for var i = 0 until i is 10 next i = i + 1 do 
    print(i) -- 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
end

for var i = 0 while i < 10 next i = i + 1 do 
    print(i) -- 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
end
```
