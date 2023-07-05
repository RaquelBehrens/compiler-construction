%{
#include <stdio.h>
#include "./src/utils/symbol_table.h"
#include "./src/utils/tokens_list.h"
#include "y.tab.h"
#include <string.h>

int valid = 1;
int column = 1;

void print_lexical_error();

%}

%option noyywrap
%option yylineno

%%

def         { insert_token(DEF, yytext);
              column += yyleng;
              return DEF; }
if          { insert_token(IF, yytext);
              column += yyleng;
              return IF; }
else        { insert_token(ELSE, yytext);
              column += yyleng;
              return ELSE; }
for         { insert_token(FOR, yytext);
              column += yyleng;
              return FOR; }
break       { insert_token(BREAK, yytext);
              column += yyleng;
              return BREAK; }
return      { insert_token(RETURN, yytext);
              column += yyleng;
              return RETURN; }
new         { insert_token(NEW, yytext);
              column += yyleng;
              return NEW; }
read        { insert_token(READ, yytext);
              column += yyleng;
              return READ; }
print       { insert_token(PRINT, yytext);
              column += yyleng;
              return PRINT; }
int         { insert_token(INT_KEYWORD, yytext);
              column += yyleng;
              return INT_KEYWORD; }
float       { insert_token(FLOAT_KEYWORD, yytext);
              column += yyleng;
              return FLOAT_KEYWORD; }
string      { insert_token(STRING_KEYWORD, yytext);
              column += yyleng;
              return STRING_KEYWORD; }
null        { insert_token(RETURN_NULL, yytext);
              column += yyleng;
              return RETURN_NULL; }

\{          { insert_token(LCURLYBRACKETS, yytext);
              column += yyleng;
              return LCURLYBRACKETS; }
\}          { insert_token(RCURLYBRACKETS, yytext);
              column += yyleng;
              return RCURLYBRACKETS; }
\(          { insert_token(LPAREN, yytext);
              column += yyleng;
              return LPAREN; }
\)          { insert_token(RPAREN, yytext);
              column += yyleng;
              return RPAREN; }
\[          { insert_token(LSQRBRACKETS, yytext);
              column += yyleng;
              return LSQRBRACKETS; }
\]          { insert_token(RSQRBRACKETS, yytext);
              column += yyleng;
              return RSQRBRACKETS; }

\;          { insert_token(SEMICOLON, yytext);
              column += yyleng;
              return SEMICOLON; }
\,          { insert_token(COMMA, yytext);
              column += yyleng;
              return COMMA; }
 
\+          { insert_token(PLUS, yytext);
              column += yyleng;
              return PLUS; }
\-          { insert_token(MINUS, yytext);
              column += yyleng;
              return MINUS; }
\*          { insert_token(TIMES, yytext);
              column += yyleng;
              return TIMES; }
\/          { insert_token(DIVIDE, yytext);
              column += yyleng;
              return DIVIDE; }
\%          { insert_token(MOD, yytext);
              column += yyleng;
              return MOD; }

\=          { insert_token(ASSIGN, yytext);
              column += yyleng;
              return ASSIGN; }

\==         { insert_token(EQ, yytext);
              column += yyleng;
              return EQ; }
\!=         { insert_token(NEQ, yytext);
              column += yyleng;
              return NEQ; }
\>          { insert_token(GT, yytext);
              column += yyleng;
              return GT; }
\<          { insert_token(LT, yytext);
              column += yyleng;
              return LT; }
\>=         { insert_token(GE, yytext);
              column += yyleng;
              return GE; }
\<=         { insert_token(LE, yytext);
              column += yyleng;
              return LE; }

[a-zA-Z_][a-zA-Z0-9_]*  { 
    symbol_t* symbol = lookup_symbol(yytext);
    if (symbol == NULL) {
        // If the identifier is not in the symbol table, add it
        insert_symbol(number_of_symbols()+1, yytext, 1);
        symbol = &symbol_table[num_symbols - 1];
    } else {
        symbol->usage_count += 1;
    }
    
    insert_token(IDENT, yytext);
    // Set yylval to point to the symbol table entry
    //yyval.symbol = symbol;
    //yylval.address = number_of_symbols()+1;
    strcpy(yylval.symbol, symbol->symbol);
    //yylval.usage_count = 1;
    column += yyleng;     
    return IDENT; }

[0-9]+      { insert_token(INT_CONSTANT, yytext);
              column += yyleng;
              printf("ue\n");
              strcpy(yylval.symbol, symbol->symbol);
              return INT_CONSTANT; }
[0-9]+\.[0-9]+ { insert_token(FLOAT_CONSTANT, yytext);
                 column += yyleng;
                 printf("ue2\n");
                 strcpy(yylval.symbol, symbol->symbol);
                 return FLOAT_CONSTANT; }
\"([^\\\"]|\\.)*\"  { insert_token(STRING_CONSTANT, yytext);
                      column += yyleng;
                      printf("ue3\n");
                      strcpy(yylval.symbol, symbol->symbol);
                      return STRING_CONSTANT; }

[\t\r]+  { /* ignore whitespace */ }

[ ]+    { column += yyleng;}

[\n]+   { column = 1; }

.       { print_lexical_error(); }

%%

void print_lexical_error() {
    char line[1024] = {0};
    int i;

    /* Concatenate current token with characters until end-of-line */
    strcat(line, yytext);
    while ((i = input()) != '\n' && i != EOF) {
        line[strlen(line)] = i;
    }
    
    printf("\nError: unexpected character %c, line %d, column %d\n", yytext[0], yylineno-1, column);
    printf("Line: '''   %s   '''\n", line);
    valid = 0;
}

void yyerror(char *msg){
    char line[1024] = {0};
    int i;

    /* Concatenate current token with characters until end-of-line */
    strcat(line, yytext);
    while ((i = input()) != '\n' && i != EOF) {
        line[strlen(line)] = i;
    }
   
    printf("\nError: %s, line %d, column %d\n", msg, yylineno-1, column);
    printf("Line: '''   %s   '''\n", line);
    valid = 0;
}

int main() {
    char str[20];
    int isExit = 1;

    while (isExit != 0) {
        printf("Please, type the file path or exit to leave: ");
        scanf("%[^\n]%*c", str);

        int isExit = strcmp(str, "exit");
        if (isExit != 0) {
            yyin = fopen(str,"r");
            if (yyin) {
                //yylex();
                yyparse();
                if(valid){
                    printf("\nSatisfies the grammar\n");
                    print_table();
                    print_tokens();
                }
            } else {
                printf("Can not find this file!\n");
            }
        } else {
            break;
        }
    }
    
    return 0;
}
