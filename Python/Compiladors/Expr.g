grammar Expr;

root : expr EOF ;

expr : <assoc=right> expr POW expr 
    | expr (DIV | MUL) expr 
    | expr (MENYS | MES) expr
    | NUM
    ;

NUM : [0-9]+ ;
POW: '^';
DIV: '/' ;
MUL: '*' ;
MENYS: '-' ;
MES : '+' ;
WS : [ \n]+ -> skip ;
