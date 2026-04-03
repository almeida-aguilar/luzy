from antlr4 import CommonTokenStream, InputStream
from antlr4 import Token
from SimpleLexer import SimpleLexer

# Input de ejemplo
codigo = """
-- 1. Estructuras y Tipos
type Jugador struct
    nombre: string
    vida:   int
    items:  []string
end

-- 2. Constantes y Objetos con inicialización de asignación
const inicial = Jugador{ nombre = "Luzi", vida = 100, items = {"Pocion", "Llave"} }

-- 3. Variables y Arrays de tipos personalizados
var horda: []Jugador = {
    { nombre = "Orco", vida = 45 },
    { nombre = "Esqueleto", vida = 20 }
}

-- 4. El nuevo bucle For-Until-Next (Explícito y Libre)
-- "Cuenta atrás de energía mientras haya enemigos"
for var energia = 10; energia is 0; energia = energia - 1 do
    print("Explorando mazmorra...")
    
    if energia < 5 and not inicial.vida is 0 then
        print("Cuidado: Energía baja")
    end
end

-- 5. Bucle While con lógica compleja
var index = 0
while index < 2 do
    var enemigo = horda[index]
    
    if enemigo.vida != 0 or enemigo.nombre == "Jefe" then
        print("Enemigo detectado")
    else
        print("Camino despejado")
    end
    
    index = index + 1
end

-- 6. Operaciones finales y tipos básicos
const victoria: bool = true
var puntaje: float = 95.5
"""


def mostrar_tokens(stream):
    print(f"{'TOKEN':<12} {'TIPO':<10} {'VALOR'}")
    print("-" * 45)

    for token in stream.tokens:
        # ignorar el token EOF al final
        if token.type == Token.EOF:
            continue

        # obtener el nombre simbólico del tipo
        nombre_tipo = SimpleLexer.symbolicNames[token.type]
        valor = repr(token.text)

        print(f"{nombre_tipo:<12} tipo={token.type:<6} {valor}")


def analizar(texto):
    entrada = InputStream(texto)  # crear flujo de entrada
    lexer = SimpleLexer(entrada)  # crear lexer (identifica tokens)

    # crear buffer configurado para ignorar espacios y comentarios
    stream = CommonTokenStream(lexer)
    stream.fill()  # lexer procesa todo el texto hasta el final

    mostrar_tokens(stream)


# ejecutar el análisis
analizar(codigo)
