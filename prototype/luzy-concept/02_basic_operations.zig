-- 02_basic_operations.luzy

-- [DESITION]: Se desidio usar tanto operadores explicitos como concisos
--             ajustandose al gusto del usuario

-- matematica basica

-- suma

suma_entera     = 1 + 1          --> (2)   da un *int* como resultado
suma_flotante   = 1.0 + 1.0      --> (2.0) da un *float*
suma_sospechosa = 1 + 2.5        --> (3.5) da un *float* como resultado
                                 -- [DESITION]: se decidio que no se pierda
                                 -- informacion el *int* se promosiona a *float*
suma_floor      = floor(1 + 2.5) --> (3)   da un *int* redondeado hacia abajo
suma_ceil       = ceil(1 + 2.5)  --> (4)   da un *int* redondeado hacia arriba
suma_round      = round(1 + 2.5) --> (4)   da un *int* redondeado

-- resta

resta_entera     = 3 - 1          --> (2)   da un *int* como resultado
resta_flotante   = 3.0 - 1.0      --> (2.0) da un *float*
resta_sospechosa = 6 - 2.5        --> (3.5) da un *float* como resultado
                                 -- [DESITION]: se decidio que no se pierda
                                 -- informacion el *int* se promosiona a *float*
resta_floor      = floor(6 - 2.5) --> (3)   da un *int* redondeado hacia abajo
resta_ceil       = ceil(6 - 2.5)  --> (4)   da un *int* redondeado hacia arriba
resta_round      = round(6 - 2.5) --> (4)   da un *int* redondeado

-- multiplicacion

multi_entera     = 3 * 2          --> (6)   da un *int* como resultado
multi_flotante   = 3.0 * 2.0      --> (6.0) da un *float*
multi_sospechosa = 3 * 2.5        --> (7.5) da un *float* como resultado
                                  -- [DESITION]: se decidio que no se pierda
                                  -- informacion el *int* se promosiona a *float*
multi_floor      = floor(3 * 2.5) --> (7)   da un *int* redondeado hacia abajo
multi_ceil       = ceil(3 * 2.5)  --> (8)   da un *int* redondeado hacia arriba
multi_round      = round(3 * 2.5) --> (8)   da un *int* redondeado

-- division decimal

divi_entre_int   = 3 / 2         --> (1.5) la division siempre da *float*
divi_entre_float = 3.0 / 2.0     --> (1.5) da el mismo resultado
divi_sospechosa  = 3 / 2.0       --> (1.5) da el mismo resultado
                                 -- [DESITION]: se decidio que no se perdiera
                                 -- informacion, y por definicion la division
                                 -- es decimal

divi_floor      = floor(3 / 2.0) --> (1)   da un *int* redondeado hacia abajo
divi_ceil       = ceil(3 / 2.0)  --> (2)   da un *int* redondeado hacia arriba
divi_round      = round(3 / 2.0) --> (2)   da un *int* redondeado

div_inf         = 1 / 0          --> (error) inf es el mayor error en la historia
                                 --  de la programacion

-- division entera

divi_entre_int   = 3 // 2      --> (1) la division entera siempre da *int*
divi_entre_float = 3.0 // 2.0  --> (error) al no poder garantizar siempre
                               --  decimales no significativos
divi_sospechosa  = 3 // 2.5    --> (error) esto simplemente es impostible

divi_entre_int   = 3 div 2     --> (1) la division entera siempre da *int*
divi_entre_float = 3.0 div 2.0 --> (error) al no poder garantizar siempre
                               --   decimales no significativos
divi_sospechosa  = 3 div 2.5   --> (error) esto simplemente es impostible
                               -- [DESITION]: se esta usando 2 keywords para 
                               --             el mismo token, (// y div) esto
                               --             es paraque distintas personas 
                               --             puedan entender el lenguaje

div_inf         = 1 div 0      --> (error) inf es el mayor error de la historia
                               --  de la programacion

-- modulo

modu_entre_int   = 3 % 2       --> (1) el modulo siempre da *int*
modu_entre_float = 3.0 % 2.0   --> (error) al no poder garantizar siempre
                               --  decimales no significativos
modu_sospechosa  = 3 % 2.5     --> (error) esto simplemente es impostible

modu_entre_int   = 3 mod 2     --> (1) el modulo siempre da *int*
modu_entre_float = 3.0 mod 2.0 --> (error) al no poder garantizar siempre
                               --  decimales no significativos
modu_sospechosa  = 3 mod 2.5   --> (error) esto simplemente es impostible
                               -- [DESITION]: se esta usando 2 keywords para 
                               --             el mismo token, (% y mod) esto
                               --             es paraque distintas personas 
                               --             puedan entender el lenguaje

modu_inf         = 1 mod 0     --> (error) inf es el mayor error de la historia
                               --  de la programacion

-- asignacion compuesta

-- -- suma, resta y multiplicacion

var vida = 100          -- Tipo: int
vida += 10              -- OK: 110 (int)
vida *= 1.5             -- ERROR: El resultado es float, 'vida' es int.

var escala = 1.0        -- Tipo: float
escala += 5             -- OK: 6.0 (El int se promociona a float)
escala *= 2.5           -- OK: 2.5 (float)

-- --division decimal

var pos_x = 10.0
pos_x /= 2              -- OK: 5.0 (float)

var puntos = 10
puntos /= 2             -- ERROR: "Intento de asignar float a variable int"
                        -- SUGERENCIA: Usa '//=' para división entera.

-- division entera y modulo

var municion = 50
municion //= 2          -- OK: 25 (int)
municion div= 3         -- OK: 16 (int)

var resto = 10
resto %= 3              -- OK: 1 (int)
resto mod= 3            -- OK: 1 (int)

var f = 10.0
f //= 2                 -- ERROR: Operación entera no válida para tipo 'float'.

-- logica

-- todos los operadores retornan un *bool*
-- [DESITION]: muchos de los operadores logicos usan 2 keywords para el mismo
               token, eso es para apoyar a la legilibidad
-- -- Y

a && b
a and b

-- -- O

a || b
a or b

-- -- NO
-- -- [DESITION]: se decidio no usar ! como perador not dado que se esta reservando
-- --             para el catch de errores

~a
not a

-- -- igual
-- -- [DESITION]: se dicidio que is sea igual a == dado que este lenguaje evita
-- --             el uso explicito de punteros, no hay comparacion de direcciones
-- --             de direcciones de memoria 

a is b 
a == b

-- -- no igual

a ~= b
a isnt b

-- -- orden
-- -- [DESITION]: los operadores de orden al igual a los matematicos basicos 
-- --             no son remplazados por palabras dado que son iconicos

a < b 
a > b 
a >= b 
a <= b
