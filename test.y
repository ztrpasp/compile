%{
/*
expr1.y
YACC f i l e
Date: xxxx/xx/xx
张文迪 <2013605@mail.nankai.edu.cn>
*/
#include <stdio.h>
#include<iostream>
#include<map>
#include<string.h>
using namespace std;
char idStr [50];//存储ID字符串
map<string ,double> Item;
int yylex();
// int isdigit();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s );
%}

%union{ 
    double dbl;
    char* str;
};
%type <dbl> expr stat
%token <str>ID
%token <dbl>NUMBER
%token ADD SUB MUL DIV LPar RPar ASSIGN

%right ASSIGN//右结合，优先级最低；
%left ADD SUB
%left MUL DIV
%right UMINUS

%%

lines : lines stat ';' { printf("%f\n", $2); }
      | lines ';'
      |
      ;

stat  : ID ASSIGN expr { $$ = $3;Item[(string)$1]=$3; } 
      | expr {$$ = $1; }
      ;

expr  : expr ADD expr { $$ = $1 + $3; }
      | expr SUB expr { $$ = $1 - $3; }
      | expr MUL expr { $$ = $1 * $3; }
      | expr DIV expr { $$ = $1 / $3; }
      | LPar expr RPar  { $$ = $2; }
      | SUB expr %prec UMINUS { $$ = -$2; }
      | NUMBER  {$$ = $1;}
      | ID {$$=Item.find((string)$1)->second;}
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
            yylval.dbl = 0;
            while(isdigit(t))
            {
                yylval.dbl=yylval.dbl * 10 + t - '0';
                t = getchar();
            }
            ungetc(t , stdin );//将读出的多余字符再次放回到缓冲区去
            return NUMBER;
        }
        else if(( t>= 'a'&&t<='z')||(t>='A'&&t<='Z')||(t=='_'))
        {
            int ti=0;
            while (( t >= 'a' && t <= 'z' ) || ( t >= 'A' && t<= 'Z' ) || ( t == '_') || 
                   ( t >= '0' && t <= '9' ) ) 
            {
                idStr[ti]=t;
                ti++;
                t = getchar();
            }
                idStr[ ti ]='\0';
                yylval.str=idStr;
                ungetc(t , stdin);
                string s(&idStr[0],&idStr[strlen(idStr)]);
                map<string,double>::iterator iter = Item.find(s);
                if(iter != Item.end())
                {
                    return ID;
                }
                else
                {
                    Item.insert(pair<string,double>(s, iter->second));
                    return ID;
                }
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
                case '=':
                    return ASSIGN;break;
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