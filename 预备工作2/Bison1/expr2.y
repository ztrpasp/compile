%{
/*
expr1.y
YACC f i l e
Date: xxxx/xx/xx
张文迪 <2013605@mail.nankai.edu.cn>
*/
#include <stdio.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif
int yylex();
// int isdigit();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s );
%}

%token NUMBER
%token ADD SUB MUL DIV LPar RPar
%left ADD SUB
%left MUL DIV
%right UMINUS

%%

lines : lines expr ';' { printf("%f\n", $2); }
      | lines ';'
      |
      ;

expr  : expr ADD expr { $$ = $1 + $3; }
      | expr SUB expr { $$ = $1 - $3; }
      | expr MUL expr { $$ = $1 * $3; }
      | expr DIV expr { $$ = $1 / $3; }
      | LPar expr RPar  { $$ = $2; }
      | SUB expr %prec UMINUS { $$ = -$2; }
      | NUMBER  {$$ = $1;}
      ;
      


%%
// int isdigit(t)
// {
//     if(t=='0'||t=='1'||t=='2'||t=='3'||t=='4'||t=='5'||t=='6'||t=='7'||t=='8'||t=='9')
//         return 1;
//     else return 0;
// }
// programs section
int yylex()
{
    // place your token retrieving code here
    int t;
    while(1)
    {
        t = getchar();
        if(t==' ' || t=='\t' || t== '\n')
        {
            //什么都不做
        }
        else if(isdigit(t))
        {
            yylval = 0;
            while(isdigit(t))
            {
                yylval=yylval * 10 + t - '0';
                t = getchar();
            }
            ungetc(t , stdin );//将读出的多余字符再次放回到缓冲区去
            return NUMBER;
        }
        else
        {
            switch(t)
            {
                case '+':
                    return ADD;break;
                case '-':
                    return SUB;break;
                case '*':
                    return MUL;break;
                case '/':
                    return DIV;break;
                case '(':
                    return LPar;break;
                case ')':
                    return RPar;break;
                default:
                    return t;
            }
        }
    }
    
}

int main(void)
{
    yyin = stdin ;
    do{
        yyparse();
    } while (! feof (yyin));
    return 0;
}
void yyerror(const char* s) {

    fprintf (stderr , "Parse error : %s\n", s );
    exit (1);
}