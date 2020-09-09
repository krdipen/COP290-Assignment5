%{
void CountEndLine();
void PrintEndLine();
int line=1;
%}

%%
"\n" {ECHO; line++;}
"\'"([^'\\]|\\.)*"\'" {ECHO; CountEndLine();}
"\""([^"\\]|\\.)*"\"" {ECHO; CountEndLine();}
"/*"([^*]|\*[^/])*"*/" {printf("%s"," "); PrintEndLine();}
"/*"([^*]|\*[^/])* {fprintf(stderr,"Error: line %d: unterminated comment\n",line); printf("%s"," "); PrintEndLine();}
%%

void CountEndLine(){
    int i=0;
    while(i<strlen(yytext)){
        if(yytext[i]=='\n'){
            line++;
        }
        i++;
    }
}

void PrintEndLine(){
    int i=0;
    while(i<strlen(yytext)){
        if(yytext[i]=='\n'){
            printf("\n");
            line++;
        }
        i++;
    }
}

int main(){
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}
