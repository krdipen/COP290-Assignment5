%{
#include "y.tab.h"
extern int yylval;
%}

%%
[-+]?[0-9]+ {yylval=atoi(yytext); return ID;}
[+\-*/] {return OP;}
"\n" {return ENDL;}
. {fprintf(yyout,"");}
%%

int yywrap(){
    return 1;
}
