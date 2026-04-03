# Luzy — Decisiones de Diseño

> Documento vivo. Registra el *qué* y el *por qué* de cada decisión.
> Última actualización: inicio del proyecto (día 1)

---

## Filosofía general

Luzy es un lenguaje de scripting educativo orientado a game development.
Inspirado en la simplicidad de Lua y las prácticas de Zig.

**Principios:**
- Sin confusión de punteros, todo el manejo de memoria es transparente al usuario
- Legible en voz alta, la sintaxis favorece claridad sobre brevedad
- Simple primero, features se agregan solo cuando hay necesidad real

---

## Manejo de memoria

**Decisión: GC automático (mark and sweep)**

- El usuario nunca toca memoria manualmente
- Sin punteros expuestos
- Similar a Lua internamente
- Implementación final en Zig, la VM maneja el GC por debajo

**Por qué no ARC/ORC:** suficiente complejidad para la fase actual.
Se puede revisar cuando el lenguaje esté maduro.

---

## Arrays

**Decisión: copia por valor, no por referencia**

```luzy
var a = {1, 2, 3}
var b = a        -- b es una copia física de a

a.add(4)
-- a es {1, 2, 3, 4}
-- b sigue siendo {1, 2, 3}
```

**Por qué:** elimina la fuente de confusión más común para principiantes.
En Python, Java y casi todo lenguaje moderno este comportamiento
silencioso quema a la gente que está aprendiendo.

**Precedente:** Swift hace esto con value types.

---

## Sistema de parámetros

**Decisión: `var`/`const` es un sistema uniforme que aplica a cualquier tipo**

| Modificador | Semántica | El original cambia? |
|-------------|-----------|-------------------|
| sin modificador | copia | no |
| `const` | referencia solo lectura | no |
| `var` | referencia mutable | sí |

Aplica igual para `int`, `string`, arrays, structs, cualquier tipo.
Una sola regla para todo, sin casos especiales por tipo.

```luzy
-- copia, no afecta el original
fun simular(p: Jugador)
    p.vida = 0
end

-- referencia solo lectura
fun mostrar(const p: Jugador)
    print(p.nombre)
end

-- referencia mutable en struct
fun curar(var p: Jugador, cantidad: int)
    p.vida = p.vida + cantidad
end

-- referencia mutable en array, aplica igual
fun agregar_item(var inventario: []string, item: string)
    inventario.add(item)
end
```

**El call site es limpio, sin modificadores:**

```luzy
curar(jugador, 50)
agregar_item(items, "pocion")
```

**Por qué:** el `var`/`const` solo vive en la definición de la función.
El LSP muestra la firma mientras escribes, así el usuario sabe
qué espera la función sin tener que escribirlo explícitamente.

Obligar `var` en el call site frustra al novato haciéndolo memorizar
cosas que el contexto ya comunica. Si la función se llama `agregar`,
es obvio que modifica. El lenguaje confía en el usuario y en las
herramientas en vez de forzar verbosidad innecesaria.

**Diferencia con Zig:** Zig requiere `&` en el call site porque es
un lenguaje de sistemas donde cada detalle de memoria importa.
Luzy es scripting educativo, el contexto es diferente.

---

## Punto de entrada

**Decisión: sin `fun main()` obligatorio**

El archivo se ejecuta de arriba a abajo como scripting.

```luzy
-- esto ya es un programa válido
var x = 10
print(x)
```

**Por qué:** menos ceremonia para el que aprende. El primer programa
no requiere entender qué es un punto de entrada.

**Nota futura:** cuando se compile a ejecutable, `fun main()` podría
ser el entry point opcional. El mismo lenguaje, dos modos de uso.

---

## `defer`

**Decisión: no existe en Luzy**

Con GC automático y sin manejo manual de recursos, `defer` no tiene
caso de uso real para el usuario. Agregarlo añade complejidad sin
beneficio visible.

**Si en el futuro aparece una necesidad real, se reconsidera.**

---

## Imports

**Decisión: un solo mecanismo `import`, el compilador resuelve dónde buscar**

```luzy
import raylib
import std.math
import jugador
```

Sin distinción sintáctica entre stdlib, paquetes externos y archivos locales.

**Orden de búsqueda:**
1. stdlib (`std.*`)
2. paquetes instalados
3. archivos locales del proyecto

**Conflictos son error de compilación**, no comportamiento silencioso.
Si un archivo local tiene el mismo nombre que un paquete instalado,
el compilador avisa en vez de elegir uno silenciosamente.

---

## Módulos y carpetas

**Decisión: el archivo índice tiene el mismo nombre que su carpeta**

```
enemigos/
├── enemigos.luzy   -- índice, re-exporta lo público
├── orco.luzy
├── esqueleto.luzy
└── jefe.luzy
```

```luzy
-- enemigos/enemigos.luzy
import orco
import esqueleto
import jefe
```

```luzy
-- main.luzy
import enemigos    -- importa todo lo expuesto en enemigos/enemigos.luzy
```

**Por qué:** una sola regla que se explica en una oración.
No hay que recordar si el índice se llama `mod`, `index` o `init`.
Siempre es el nombre de la carpeta.

Desde afuera el import se ve igual sea archivo o carpeta.
El compilador resuelve la diferencia transparentemente.

**Precedente:** Zig moderno usa esta misma convención.

---

## Roadmap de implementación

```
Fase 1  →  Python + ANTLR (ahora)
           Diseñar y validar el lenguaje rápido, iterar sin costo

Fase 2  →  Intérprete tree-walk
           Validar que el lenguaje funciona en la práctica

Fase 3  →  VM stack-based en Zig
           Lexer + Parser + VM propia, independencia total

Fase 4  →  Bindings Raylib
           Primer programa real en Luzy

Fase 5  →  Bindings Sokol + engine propio
           Largo plazo
```

---

## Operadores aritméticos

**Decisión: `/` siempre da float, división entera y módulo tienen alternativas**

```luzy
5 / 2        -- 2.5, siempre float
10 // 3      -- 3,   división entera
10 div 3     -- 3,   división entera
10 % 3       -- 1,   módulo
10 mod 3     -- 1,   módulo
```

**Por qué:** dividir siempre debería dar decimal, es la intuición natural.
La pérdida silenciosa de decimales de C es una fuente clásica de bugs
para principiantes. El usuario elige el estilo que prefiera.

---

## Punto y coma

**Decisión: `;` es opcional**

```luzy
-- ambos válidos
var x = 10
var x = 10;

-- útil para múltiples declaraciones en una línea
var x = 10; var y = 20;
```

El parser lo ignora si está presente. El usuario decide su estilo.

---

## Filosofía de estilo

**Decisión: Luzy ofrece alternativas, no obliga a una sola forma**

El usuario o equipo elige su estilo. Ya presente en el lenguaje:

| Alternativa A | Alternativa B | Significado |
|---------------|---------------|-------------|
| `and` | `&&` | AND lógico |
| `or` | `\|\|` | OR lógico |
| `not` | `!` | NOT lógico |
| `is` | `==` | igualdad |
| `is not` | `!=` | desigualdad |
| `div` | `//` | división entera |
| `mod` | `%` | módulo |
| con `;` | sin `;` | fin de línea |

**Decisión: `+=` y familia sí, `++` no**

```luzy
x += 1
x -= 1
x *= 2
x /= 2
```

`++` no existe en Luzy. `x += 1` ya lo cubre sin ambigüedad.

**Por qué no `++`:** en C existe `++x` y `x++` que hacen cosas
sutilmente distintas. Es una pregunta inevitable para el novato
que no agrega valor real. Zig, Rust y Python tomaron la misma decisión.

**Diferencia con otros lenguajes:**
- Python es muy opinionated, hay una sola forma correcta
- Zig tiene `zig fmt` que fuerza un solo estilo
- Luzy se parece más a Lua o C en este sentido, confía en el usuario

---

## Pendiente de definir

- Manejo de errores (¿excepciones? ¿valores de error? ¿option type?)
- Sistema de tipos completo (¿inferencia total o parcial?)
- REPL (¿existe desde el inicio?)
- LSP (planear que el parser sea tolerante a errores desde antes)
