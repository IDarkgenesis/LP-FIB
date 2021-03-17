grammar Skyline;

root : (let | alone) EOF ;

let: VAR ':=' opskyline;

alone: opskyline;

opskyline: '(' parent ')'
    | reflexion opskyline
    | opskyline intersec opskyline
    | opskyline replicate NUM
    | opskyline union opskyline
    | opskyline (transp | transn) NUM
    | opskyline subs opskyline 
    | opskyline dpexp
    | '['comp']'
    | '{'rng'}'
    | '('simp')'
    | skln
    ;

parent: opskyline;

intersec: '*';
replicate: '*';
union: '+';
transp: '+';
transn: '-';
reflexion: '-';

subs: '-';

dpexp: '['NUM':'NUM']'
    | '['':'NUM']'
    | '['NUM':'']'
    ;
    
skln : VAR;
simp: NUM','NUM','NUM;
rng: NUM','NUM','NUM','NUM','NUM;
comp: '('simp')' (',''('simp')')*;

NUM: [0-9]+ ;
VAR: [a-z]+ ;

WS : [ \n]+ -> skip ;
