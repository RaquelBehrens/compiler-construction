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
if          { insert_token(DEF, yytext);
              column += yyleng;
              return IF; }
else        { insert_token(DEF, yytext);
              column += yyleng;
              return ELSE; }
for         { insert_token(DEF, yytext);
              column += yyleng;
              return FOR; }
break       { insert_token(DEF, yytext);
              column += yyleng;
              return BREAK; }
return      { insert_token(DEF, yytext);
              column += yyleng;
              return RETURN; }
new         { insert_token(DEF, yytext);
              column += yyleng;
              return NEW; }
read        { insert_token(DEF, yytext);
              column += yyleng;
              return READ; }
print       { insert_token(DEF, yytext);
              column += yyleng;
              return PRINT; }
int         { insert_token(DEF, yytext);
              column += yyleng;
              return INT_KEYWORD; }
float       { insert_token(DEF, yytext);
              column += yyleng;
              return FLOAT_KEYWORD; }
string      { insert_token(DEF, yytext);
              column += yyleng;
              return STRING_KEYWORD; }
null        { insert_token(DEF, yytext);
              column += yyleng;
              return RETURN_NULL; }

\{          { insert_token(DEF, yytext);
              column += yyleng;
              return LBRACKETS; }
\}          { insert_token(DEF, yytext);
              column += yyleng;
              return RBRACKETS; }
\(          { insert_token(DEF, yytext);
              column += yyleng;
              return LPAREN; }
\)          { insert_token(DEF, yytext);
              column += yyleng;
              return RPAREN; }
\[          { insert_token(DEF, yytext);
              column += yyleng;
              return LSQRBRACKETS; }
\]          { insert_token(DEF, yytext);
              column += yyleng;
              return RSQRBRACKETS; }

\;          { insert_token(DEF, yytext);
              column += yyleng;
              return SEMICOLON; }
\,          { insert_token(DEF, yytext);
              column += yyleng;
              return COMMA; }
 
\+          { insert_token(DEF, yytext);
              column += yyleng;
              return PLUS; }
\-          { insert_token(DEF, yytext);
              column += yyleng;
              return MINUS; }
\*          { insert_token(DEF, yytext);
              column += yyleng;
              return TIMES; }
\/          { insert_token(DEF, yytext);
              column += yyleng;
              return DIVIDE; }
\%          { insert_token(DEF, yytext);
              column += yyleng;
              return MOD; }

\=          { insert_token(DEF, yytext);
              column += yyleng;
              return ASSIGN; }

\==         { insert_token(DEF, yytext);
              column += yyleng;
              return EQ; }
\!=         { insert_token(DEF, yytext);
              column += yyleng;
              return NEQ; }
\>          { insert_token(DEF, yytext);
              column += yyleng;
              return GT; }
\<          { insert_token(DEF, yytext);
              column += yyleng;
              return LT; }
\>=         { insert_token(DEF, yytext);
              column += yyleng;
              return GE; }
\<=         { insert_token(DEF, yytext);
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
    
    insert_token(DEF, yytext);
    // Set yylval to point to the symbol table entry
    //yyval.symbol = symbol;
    yylval.address = number_of_symbols()+1;
    yylval.symbol = yytext;
    yylval.usage_count = 1;
    column += yyleng;     
    return IDENT; }

[0-9]+      { insert_token(DEF, yytext);
              column += yyleng;
              return INT_CONSTANT; }
[0-9]+\.[0-9]+ { insert_token(DEF, yytext);
                 column += yyleng;
                 return FLOAT_CONSTANT; }
\"([^\\\"]|\\.)*\"  { insert_token(DEF, yytext);
                      column += yyleng;
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
    int found_file = 0;

    while (!found_file) {
        printf("Please, type the file path: ");
        scanf("%[^\n]%*c", str);
        yyin = fopen(str,"r");
        if (yyin) {
            found_file = 1;
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
    }
    
    return 0;
}
