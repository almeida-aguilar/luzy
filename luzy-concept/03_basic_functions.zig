-- basic_functions.lazy

-- la keyword *fun* declara una funcion
-- [FUN FACT]: el keyword fun se selecciono dado que significa divertido en
--             ingles

fun add(a: int, b: int): int =
    return a + b
end

-- [DESITION]: se decidio que el header de la funcion termine en = dado que
--             se ve igual a la declaracion de una variable

-- tipos de argumentos

-- -- variable
-- -- si la funcion declara un argumento con var quiere decir que el argumento
-- -- pasado es una referencia mutable

fun heal(var health: int) =
    health += 50
end

-- -- constante
-- -- si la funcion declara un argumento como const quiere decir que el argumento
-- -- pasado es una referencia de solo lectura

fun display_name(const name: string) =
    println("hola ", name, "!")
end

-- -- copia (por defecto)
-- -- si la funcion no declara nada se infiere que se use una copia del argumento

fun heal_previsalization(health: int): int =
    return health += 50
end
