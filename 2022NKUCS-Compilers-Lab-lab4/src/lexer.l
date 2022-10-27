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

    #ifdef ONLY_FOR_LEX
    #include <ostream>
    #include <fstream>
    #include <string>
    #include <stack>
    #include <map>
    #include <functional>
    #include <math.h>
    using namespace std;
    extern FILE *yyin; 
    extern FILE *yyout;

    //作用域控制：
    int scopeNum = 0;
    stack<int> scopes;

    struct item {
        string idname;
        int scope;
    };

    //符号表：
    map<int, item> table;

    void DEBUG_FOR_LAB4(std::string s){
        string l = to_string(yylineno);
        std::string DEBUG_INFO = "[DEBUG LAB4]: \t" + s + " \tlinenum: " + l + "\n";
        fputs(DEBUG_INFO.c_str(), yyout);
    }
    #endif
%}

HEXADECIMAL (0x[1-9|A-F|a-f][0-9|A-F|a-f]*|0x0)
OCTAL (0[1-7][0-7]*|00)
DECIMIAL ([1-9][0-9]*|0)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
LINECOMMENT (\/\/.*)
COMMENTBEGIN "/*"
COMMENTEND "*/"
COMMENTCONTENT [^(*/)]*|\n
%x BLOCKCOMMENT

%%

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
};
"float" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("FLOAT\tfloat");
    #else
        return FLOAT;
    #endif 
};
"void" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("VOID\tvoid");
    #else
        return VOID;
    #endif 
};
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
"while" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("WHILE\twhile");
    #else
        return WHILE;
    #endif
};
"return" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RETURN\treturn");
    #else
        return RETURN;
    #endif
};
"+" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ADD\t+");
    #else
        return ADD;
    #endif
};
"-" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SUB\t-");
    #else
        return SUB;
    #endif
};
"*" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("MUL\t*");
    #else
        return MUL;
    #endif
};
"/" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("DIV\t/");
    #else
        return DIV;
    #endif
};
"%" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("MOD\t/");
    #else
        return MOD;
    #endif
};
"==" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("EQUAL\t==");
    #else
        return EQUAL;
    #endif
};
">=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("GorEQ\t>=");
    #else
        return GorEQ;
    #endif
};
"<=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LorEQ\t<=");
    #else
        return LorEQ;
    #endif
};
">" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("GRATER\t>");
    #else
        return GRATER;
    #endif
};
"<" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LESS\t<");
    #else
        return LESS;
    #endif
};
"!=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("NOEQ\t!=");
    #else
        return NOEQ;
    #endif
};
"=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ASSIGN\t=");
    #else
        return ASSIGN;
    #endif
};
"&&" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("AND\t&&");
    #else
        return AND;
    #endif
};
"||" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("OR\t||");
    #else
        return OR;
    #endif
};
"!" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("AGAINST\t!");
    #else
        return AGAINST;
    #endif
};
";" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SEMICOLON\t;");
    #else
        return SEMICOLON;
    #endif
}
"," {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("COMMA\t,");
    #else
        return COMMA;
    #endif
}
"\'" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SINGLE_QM\t,");
    #else
        return SINGLE_QM;
    #endif
}
"\"" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("DOUBLE_QM\t,");
    #else
        return DOUBLE_QM;
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
        scopeNum++;
        scopes.push(scopeNum);
        DEBUG_FOR_LAB4("LBRACE\t{");
    #else
        return LBRACE;
    #endif
}
"}" {
    #ifdef ONLY_FOR_LEX
        scopes.pop();
        DEBUG_FOR_LAB4("RBRACE\t}");
    #else
        return RBRACE;
    #endif
}
"[" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LSQUARE\t}");
    #else
        return LSQUARE;
    #endif
}
"]" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RSQUARE\t}");
    #else
        return RSQUARE;
    #endif
}

{DECIMIAL} {
    string s = yytext;
    int len = s.length();
    int val = 0;
    for(int i = 0; i < len - 1; i++) {
        val += (s[i] - '0') * pow(10, (len - i - 1));
    }
    #ifdef ONLY_FOR_LEX
        string val_s = to_string(val);
        DEBUG_FOR_LAB4("DECIMIAL\t" + val_s);
    #else
        yylval = val;
        return DECIMIAL; 
    #endif
}
{OCTAL} {
    string s = yytext;
    int len = s.length();
    int val = 0;
    for(int i = 0; i < len - 1; i++) {
        val += (s[i + 1] - '0') * pow(8, (len - i - 2));
    }
    #ifdef ONLY_FOR_LEX
        string val_s = to_string(val);
        DEBUG_FOR_LAB4("OCTAL\t" + val_s);
    #else
        yylval = val;
        return OCTAL;
    #endif
}
{HEXADECIMAL} {
    string s = yytext;
    int len = s.length();
    int val = 0;
    int temp = 0;
    for(int i = 0; i < len - 2; i++) {
        temp = s[i + 2] - '0';
        if(s[i + 2] == 'A' || s[i + 2] == 'a') temp = 10;
        if(s[i + 2] == 'B' || s[i + 2] == 'b') temp = 11;
        if(s[i + 2] == 'C' || s[i + 2] == 'c') temp = 12;
        if(s[i + 2] == 'D' || s[i + 2] == 'd') temp = 13;
        if(s[i + 2] == 'E' || s[i + 2] == 'e') temp = 14;
        if(s[i + 2] == 'F' || s[i + 2] == 'f') temp = 15;
        val += temp * pow(16, (len - i - 3));
    }
    #ifdef ONLY_FOR_LEX
        string val_s = to_string(val);
        DEBUG_FOR_LAB4("HEXADECIMAL\t" + val_s);
    #else
        yylval = val;
        return HEXADECIMAL;
    #endif
}
{ID} {
    string s = yytext;
    string scopeNum_s = to_string(scopeNum);
    hash<string> hash_str;
    string value = s + scopeNum_s;
    int index = hash_str(value);
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID\t" + s + " \tscope: " + scopeNum_s);
        //加入符号表：
        if(!table.count(index)) {
            struct item it;
            it.idname = s;
            it.scope = scopeNum;
            table.insert(pair<int, struct item>(index, it));
        }
    #else
        yylval = index;//返回变量在符号表中的索引；
        return ID;
    #endif
}
{LINECOMMENT} {
    #ifdef ONLY_FOR_LEX
        string s = yytext;
        DEBUG_FOR_LAB4("LINECOMMENT\t" + s);
    #else 
        return LINECOMMENT;
    #endif
}

{COMMENTBEGIN} {
    #ifdef ONLY_FOR_LEX
        BEGIN BLOCKCOMMENT;
        string s = yytext;
        DEBUG_FOR_LAB4("COMMENTBEGIN\t" + s);
    #else 
        return COMMENTBEGIN;
    #endif
}

<BLOCKCOMMENT>{COMMENTEND} {
    #ifdef ONLY_FOR_LEX
        string s = yytext;
        DEBUG_FOR_LAB4("COMMENTEND\t" + s);
        BEGIN INITIAL;
    #else 
        return COMMENTEND;
    #endif
}
<BLOCKCOMMENT>{COMMENTCONTENT} {
    #ifdef ONLY_FOR_LEX
        string s = yytext;
        while(s.find('\n') != s.npos) {
            s.replace(s.find('\n'),1,"");
            yylineno++;
        }
        DEBUG_FOR_LAB4("COMMENTCONTENT\t" + s);       
    #else 
        return COMMENTCONTENT;
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

    //压入0作用域（全局变量）：
    scopes.push(scopeNum);
    yylex();

    //打印符号表:
    int debug = 0;
    if(debug) {
        map<int, struct item>::iterator it;
		for (it = table.begin(); it != table.end(); it++) {
            printf("%d \t %s \t %d\n", it -> first, it -> second.idname.c_str(), it -> second.scope);
		}
    }

    return 0;
}
#endif