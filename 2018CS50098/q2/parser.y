%{
#include<stdbool.h>
#include"lex.yy.c"
void yyerror();
void push(void);
void pop(void);
char array[100][100];
int pointer=0;
bool noerror=true;
%}

%token ID
%token OP
%token ENDL

%%
F : T ENDL F
  | T ENDL ;
T : E {fprintf(yyout,"%s",array[0]); pointer=0; fprintf(yyout,"%d\n",$$); noerror=true;};
E : E E OP {pop();
			if(yytext[0]=='+'){
				$$=$1+$2;
			}
			else if(yytext[0]=='-'){
				$$=$1-$2;
			}
			else if(yytext[0]=='*'){
				$$=$1*$2;
			}
			else if(yytext[0]=='/'){
				$$=$1/$2;
			}}
  | ID {push(); $$=$1;};
%%

void yyerror(char *s)
{
    if(noerror){
        fprintf(yyout,"invalid_input\n");
        noerror=false;
    }
    pointer=0;
    yyparse();
}

int main(int argc,char *argv[])
{
	yyin=fopen(argv[1],"r");
	yyout=fopen(argv[2],"w");
    yyparse();
    return 0;
}

void push(void)
{
    int i=0;
	while(i<strlen(yytext)){
		array[pointer][i]=yytext[i];
		i++;
	}
	array[pointer][i]=' ';
	i++;
	array[pointer][i]='\0';
	pointer++;
}

void pop(void)
{
	pointer=pointer-1;
	char s2[100];
	int i=0;
	while(i<strlen(array[pointer])){
		s2[i]=array[pointer][i];
		i++;
	}
	s2[i]='\0';
	pointer=pointer-1;
	char s1[100];
	i=0;
	while(i<strlen(array[pointer])){
		s1[i]=array[pointer][i];
		i++;
	}
	s1[i]='\0';
	char s0[100];
	s0[0]=yytext[0];
	s0[1]=' ';
	s0[2]='\0';
	strcat(s0,s1);
	strcat(s0,s2);
	i=0;
	while(i<strlen(s0)){
		array[pointer][i]=s0[i];
		i++;
	}
	array[pointer][i]='\0';
	pointer=pointer+1;
}
