%{
/*
expr1.y
YACC file
Date: 2022/10/08
张文迪 <2013605@mail.nankai.edu.cn>
*/
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#ifndef YYSTYPE
#define YYSTYPE double
#endif

FILE* yyin;

extern int yyparse();
int yylex();
void yyerror(const char* s );
void mysetVal(int index, double val);
%}

%token ADD SUB MUL DIV LPar RPar
%token NUMBER
%token ID
%token ASSIGN

%right ASSIGN//右结合，优先级最低；
%left ADD SUB
%left MUL DIV
%right UMINUS

%%

lines : lines stat ';' { printf("%f\n", $2); }
      | lines ';'
      |
      ;

stat  : ID ASSIGN expr { $$ = $3; mysetVal($1, $3); } 
      | expr {$$ = $1; }
      ;

expr  : expr ADD expr { $$ = $1 + $3; }
      | expr SUB expr { $$ = $1 - $3; }
      | expr MUL expr { $$ = $1 * $3; }
      | expr DIV expr { $$ = $1 / $3; }
      | LPar expr RPar  { $$ = $2; }
      | SUB expr %prec UMINUS { $$ = -$2; }
      | NUMBER  {$$ = $1;}
      | ID { $$ = mygetVal((int)$1); }
      ;
      
%%

char idStr[50];

struct Item{
    char ID[50];
    double val;
}; //表项

struct Item table[100];//符号表数组;
int numIDs = 0;//总的符号的数目;

//对比两个字符串;
int equal(char* c, char* s) {
    for(int i = 0; i < 50; i++) {
        if(c[i] != s[i]) {
            return 0;
        }
    }
    return 1;
}

//拷贝两个字符串;
void copy(char* c, char* s) {
    for(int i = 0; i < 50; i++) {
        c[i] = s[i];
    }
}

//判断是否已经在表里;
int hasID(char* id) {
    for(int i = 0; i < numIDs; i++) {
        if(equal(table[i].ID, id)) {
            return 1;
        }
    }
    return 0;
}

//找到编号;
int getIndex(char * id) {
    for(int i = 0; i < numIDs; i++) {
        if(equal(table[i].ID, id)) {
            return i;
        }
    }
}

//加入符号表;
int add_to_table(char* id) {
    struct Item newItem;

    copy(newItem.ID, id); 
    newItem.val = 0;

    table[numIDs] = newItem;

    numIDs ++;
    return numIDs - 1;
}

//获取某个符号的值;
int mygetVal(int index) {
    return table[index].val;
}

//设置某个符号的值;
void mysetVal(int index, double val) {
    table[index].val = val;
}


//主函数：
int main(void) {
    yyin = stdin ;
    do {
        yyparse();
    } while (! feof(yyin));
    return 0;
}

int isdigit(char t) {
    if(t >= '0' && t <= '9') {
        return 1;
    } else {
        return 0;
    } 
}

int isPrefix(char t) {
    if(t >= 'A' && t <= 'Z') {
        return 1;
    } else if(t >= 'a' && t <= 'z') {
        return 1;
    } else if(t == '_') {
        return 1;
    } else {
        return 0;
    }
}

int yylex() {
    int t;
    while(1) {
        t = getchar();
        if(t == ' ' || t == '\t' || t == '\n') {
            continue;
        } else if(isdigit(t)) {
            yylval = 0;    //隐式赋给NUMBER的属性值。
            while(isdigit(t)) {
                yylval = yylval * 10 + t - '0';
                t = getchar();
            }
            ungetc(t, stdin);
            return NUMBER;
        } else if(isPrefix(t)) {
            int i = 0;
            while(isPrefix(t) || isdigit(t)) {
                idStr[i] = t;
                t = getchar();
                i++;
            }
            idStr[i] = '\0';
            ungetc(t, stdin);
            //此时此刻，读到了一个完整的标识符，接下来判断是否已经加入了符号表。
            if(hasID(idStr)) {
                yylval = getIndex(idStr);//返回它的索引;
                return ID;
            } else {
                yylval = add_to_table(idStr);//加入符号表，并返回它的索引;
                return ID;
            }
        } else {
            switch(t) {
                case '+':
                    return ADD;
                    break;
                case '-':
                    return SUB;
                    break;
                case '*':
                    return MUL;
                    break;
                case '/':
                    return DIV;
                    break;
                case '(':
                    return LPar;
                    break;
                case ')':
                    return RPar;
                    break;
                case '=':
                    return ASSIGN;
                    break;
                default:
                    return t;
            }
        }
    }   
}

void yyerror(const char* s) {
    fprintf (stderr , "Parse error : %s\n", s );
    exit (1);
}
