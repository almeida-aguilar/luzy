# The Luzy Programming Language

## Index
1. [Filosofy](#Filosofy)
2. 

## Filosofy

Luzy is a scripting programing language that try to take the best parts form [Zig](https://ziglang.org/) and [Lua](https://www.lua.org/)

## Tipos

```luzy
-- constantes
const pi: float = 3.14159
const nombre = "Luan" -- Tipo inferido

-- mutables
var constador: int = 0
constador = 10 -- mutable por defecto
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
