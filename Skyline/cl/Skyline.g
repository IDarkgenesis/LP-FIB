grammar Skyline;

root : (let | alone) EOF ;

let: VAR ':=' opskyline;

alone: opskyline;

opskyline: '(' opskyline ')' 
    | reflexion opskyline
    | opskyline intersec opskyline
    | opskyline replicate NUM
    | opskyline union opskyline
    | opskyline (transp | transn) NUM
    | '['comp']'
    | '{'rng'}'
    | '('simp')'
    | skln
    ;

intersec: '*';
replicate: '*';
union: '+';
transp: '+';
transn: '-';
reflexion: '-';

skln : VAR;
simp: NUM','NUM','NUM;
rng: NUM','NUM','NUM','NUM','NUM;
comp: '('simp')' (',''('simp')')*;

NUM: [0-9]+ ;
VAR: [a-z]+ ;

WS : [ \n]+ -> skip ;
