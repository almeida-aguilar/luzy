// Gramática léxica simple — reconoce tokens básicos
lexer grammar SimpleLexer;

// ── Palabras reservadas ─────────────────────────────
TYPE     : 'type' ;
STRUCT   : 'struct' ;
ENUM     : 'enum' ;
FUN      : 'fun' ;
VAR      : 'var' ;
CONST    : 'const' ;
IF       : 'if' ;
THEN     : 'then' ;
ELSE     : 'else' ;
WHILE    : 'while' ;
FOR      : 'for' ;
UNTIL    : 'until' ;
NEXT     : 'next' ;
IN       : 'in';
DO       : 'do' ;
END      : 'end' ;
RETURN   : 'return' ;
BREAK    : 'break' ;
CONTINUE : 'continue' ;
PRINT    : 'print' ;

// ── Operadores y símbolos ────────────────────────────
ASSIGN   : '=' ;

EQ       : 'is' | '==';
NEQ      : '!=' ; // IS NOT tambien es valido
NOT      : 'not' | '!' ;
AND      : 'and' | '&&' ;
OR       : 'or'  | '||' ; 

PLUS     : '+' ;
MINUS    : '-' ;
MULT     : '*' ;
DIV      : '/' ;

COLON    : ':' ;
DOT      : '.' ;
COMMA    : ',' ;
LPAREN   : '(' ;
RPAREN   : ')' ;
LBRACKET : '[' ;
RBRACKET : ']' ;
LBRACE   : '{' ;
RBRACE   : '}' ;

// ──  Tipos nombres ──────────────────────────────────────
INT_TYPE    : 'int' ;
FLOAT_TYPE  : 'float' ;
BOOL_TYPE   : 'bool' ;
STRING_TYPE : 'string' ;
ARRAY_TYPE : '[]' [a-zA-Z_] [a-zA-Z_0-9]* ;

// ── Tipos valores ────────────────────────────────────────
STRING     : '"' ~["\r\n]* '"' ;
INT        : [0-9]+ ;
FLOAT      : [0-9]+ '.' [0-9]+ ;
TRUE    : 'true'  ;
FALSE   : 'false' ;
ID         : [a-zA-Z_] [a-zA-Z_0-9]* ;

// ── Ignorar espacios y saltos de línea ───────────────
COMMENT : '--' ~[\r\n]* -> skip ;
WS      : [ \t\r\n]+ -> skip ;
