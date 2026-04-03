-- 01_basic_types.luzy

-- variables

-- el keyword *var* declara que la variable puede ser mutada
-- [NOTA]: es buena practica que las variables mutables sean declaradas en
--         lower_snake_case

var booleano: bool   = true
var entero:   int    = 10
var flotante: float  = 3.14159
var carater:  char   = 'a'
var cadena:   string = "hola mundo"

booleano = false --> no da error

-- constantes

-- el keyword *const* declara que la varaible no puede ser mutada
-- [NOTA]: es buena practica que las variables contantes sean declaradas en
--         UPPER_SNAKE_CASE


const BOOLEANO: bool   = true
const ENTERO:   int    = 10
const FLOTANTE: float  = 3.14159
const CARATER:  char   = 'a'
const CADENA:   string = "hola mundo"

BOOLEANO = flase --> da error

-- inferencia

-- en el caso de no usar ninguna de los anteriores keywords el lenguaje infire
-- lo que el usuario desea

-- -- inferencia de tipos

-- -- se inferencia el tipo que el usuario desea

var   booleano = true --> se infire que el tipo es *bool*
const CARACTER = 'a'  --> se infire que el tipo es *char*

-- -- ingerencia de reasignacion

var entero: int = 10
entero = 11.0         --> esto da *error* para la correcta
                      --  asignacion se requiere convertirlo a *int*
entero = floor(11.0)
print(entero)         --> (11)

var flotante: float = 1.25
flotante = 3          --> el *int* se promociona a *float*
print(flotante)       --> (3.0)

-- en resumen, un float puede aceptar un int, pero int no puede aceptar un float

-- -- inferencia de mutabilidad

-- -- se infiere el tipo de mutabilidad que el usuario desea para su variable

flotante = 3.14159    --> se infiere que es un *var* dado que esta en lower case
CADENA = "hola mundo" --> se infiere que es un *const* dado que esta en UPPER CASE

var ESTO_ES_VARIABLE =   "si lo es" --> si el keyword es primero la anterior regla
const est_es_constante = "si lo es" --  no se aplica

-- sensibilidad

var Esto_ES_raro: bool = true --> este es una variable
esto_es_raro: boo = true      --> diferente a esta
                              --  [DESITION]: el case y under score sensitive
                              --              obliga a tener el mismo nombre en
                              --              todo el codigo, haciendolo mas
                              --              facil de buscar
