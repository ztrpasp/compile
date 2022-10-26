%option noyywrap
%{
    /*
    * You will need to comment this line in lab5.
    */
    #define ONLY_FOR_LEX
    
    #ifdef ONLY_FOR_LEX
    #else
    #define YYSTYPE void *
    #include "parser.h"
    #endif

    #define YY_NO_UNPUT
    #define YY_NO_INPUT
    #include <string>

    #ifdef ONLY_FOR_LEX
    #include <ostream>
    #include <fstream>
    #include <iostream>
    #include <stack>
    #include <vector>
    using namespace std;
    extern FILE *yyin; 
    extern FILE *yyout;

    void DEBUG_FOR_LAB4(std::string s){
        std::string DEBUG_INFO = "[DEBUG LAB4]: \t" + s + "\n";
        fputs(DEBUG_INFO.c_str(), yyout);
    }
    #endif
%}
%{
    
    class idSymbol{
    public:
        string idName;//标识符
        int scopeNum;//作用域
        int idNum;//标识符的编号，后续可改为指针
        idSymbol();
        idSymbol(string s);
    };
    idSymbol::idSymbol(){
        this->scopeNum=0;
        this->idNum=0;
    }
    idSymbol::idSymbol(string s){
        this->scopeNum=0;
        this->idNum=0;
        this->idName=s;
    }
    int idSum = 0;//全局的标识符编号
    int scopeSum = 0;//词法分析出现的作用域的个数
    stack<int> scopeStru;
    
    vector<idSymbol> table;
    
%}

DECIMIAL ([1-9][0-9]*|0) 
ID [[:alpha:]_][[:alpha:][:digit:]_]*
CHAR ('[:alpha:]')
EOL (\r\n|\n|\r)
WHITE [\t ]

LINECOMMENT (\/\/[^\n]*)  
BLOCKCOMMENTBEGIN "/*"
BLOCKCOMMENTPRO (.|\n)
BLOCKCOMMENTEND "*/"

%x BLOCKCOMMENT

%%
{LINECOMMENT} {
    #ifdef ONLY_FOR_LEX
        string a = yytext;
        string tmp = "linecomment\t" +  a +  "\tlinenum:" + to_string(yylineno);//注释的打印，可忽略
        DEBUG_FOR_LAB4(tmp);
    #else 
        return LINECOMMENT;
    #endif
}
{BLOCKCOMMENTBEGIN} {
    #ifdef ONLY_FOR_LEX
        BEGIN BLOCKCOMMENT;
        string a = yytext;

        string temp = "commentbegin\t" + a +"\tlinenum:" + to_string(yylineno);
        DEBUG_FOR_LAB4(temp);
    #else 
        return BLOCKCOMMENTBEGIN;
    #endif
}

<BLOCKCOMMENT>{BLOCKCOMMENTEND} {
    #ifdef ONLY_FOR_LEX
        string a = yytext;
        string temp = "commentend\t" + a +"\tlinenum:" + to_string(yylineno);
        DEBUG_FOR_LAB4(temp);
        BEGIN INITIAL;
    #else 
        return BLOCKCOMMENTEND;
    #endif
}

<BLOCKCOMMENT>{BLOCKCOMMENTPRO} {
    #ifdef ONLY_FOR_LEX
        string a = yytext;
        if(a=="\n"){
            yylineno++;
            a="EOL";
        }
        string temp = "comment\t" + a +"\tlinenum:" + to_string(yylineno);
        DEBUG_FOR_LAB4(temp);
    #else 
        return BLOCKCOMMENTPRO;
    #endif
}
"int" {
    /*
    * Questions: 
    *   Q1: Why we need to return INT in further labs?
    *   Q2: What is "INT" actually?
    */
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("INT\tint");
    #else
        return INT;
    #endif
}
"void" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("VOID\tvoid");
    #else
        return VOID;
    #endif 
}
"if" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("IF\tif");
    #else
        return IF;
    #endif
};
"else" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ELSE\telse");
    #else
        return ELSE;
    #endif
};
"return" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RETURN\treturn");
    #else
        return RETURN;
    #endif
}

"=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ASSIGN\t=");
    #else
        return ASSIGN;
    #endif
}
"<" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LESS\t<");
    #else
        return LESS;
    #endif
}
"+" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ADD\t+");
    #else
        return ADD;
    #endif
}
";" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SEMICOLON\t;");
    #else
        return SEMICOLON;
    #endif
}
"(" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LPAREN\t(");
    #else
        return LPAREN;
    #endif
}
")" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RPAREN\t)");
    #else
    return RPAREN;
    #endif
}
"{" {
    #ifdef ONLY_FOR_LEX
        scopeSum++;//作用域改变
        scopeStru.push(scopeSum);
        DEBUG_FOR_LAB4("LBRACE\t{");
    #else
        return LBRACE;
    #endif
}
"}" {
    #ifdef ONLY_FOR_LEX
        scopeStru.pop();
        DEBUG_FOR_LAB4("RBRACE\t}");
    #else
        return RBRACE;
    #endif
}
{ID} {
    #ifdef ONLY_FOR_LEX
        string m = yytext;
        vector<idSymbol>::iterator iter;
        string temp;
        for (iter = table.begin(); iter != table.end(); iter++)
	    {
		    if(iter->idName==m && iter->scopeNum==scopeStru.top())
            {
                temp= "ID\t" + m + "\tlinenum:" + to_string(yylineno) + "\tIDcount:" + to_string(iter->idNum);
                break;
            }
	    }
        if(iter==table.end())
        {
            idSymbol tmp(m);
            tmp.idNum=idSum;
            if(scopeStru.size() != 0){
                tmp.scopeNum=scopeStru.top();
             }
            table.insert(table.begin()+idSum,tmp);
            idSum++;
            temp= "ID\t" + m + "\tlinenum:" + to_string(yylineno) + "\tIDcount:" + to_string(tmp.idNum);
      }
        DEBUG_FOR_LAB4(temp);
    #else
        return RBRACE;
    #endif
}

{EOL} yylineno++;
{WHITE}
%%

#ifdef ONLY_FOR_LEX
int main(int argc, char **argv){
    if(argc != 5){
        fprintf(stderr, "Argument Not Enough");
        exit(EXIT_FAILURE);
    }

    if(!(yyin = fopen(argv[1], "r"))){
        fprintf(stderr, "No such file or directory: %s", argv[1]);
        exit(EXIT_FAILURE);
    }

    if(!(yyout = fopen(argv[3], "w"))){
        fprintf(stderr, "No such file or directory: %s", argv[3]);
        exit(EXIT_FAILURE);
    }

    yylex();
    return 0;
}
#endif
