%{
#include <stdio.h>
#include "./src/utils/symbol_table.h"
#include "./src/utils/tokens_list.h"
#include "y.tab.h"

int valid = 1;
int column = 1;


void print_lexical_error();

%}

%option noyywrap
%option yylineno

%%

def         { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return DEF; }

if          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return IF; }
else        { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return ELSE; }
for         { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return FOR; }
break       { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return BREAK; }
return      { 
             char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return RETURN; }
new         { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return NEW; }
read        { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return READ; }
print       { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return PRINT; }
int         { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return INT_KEYWORD; }
float       { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return FLOAT_KEYWORD; }
string      { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return STRING_KEYWORD; }
null        { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return RETURN_NULL; }

\{          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return LBRACKETS; }
\}          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return RBRACKETS; }
\(          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return LPAREN; }
\)          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return RPAREN; }
\[          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return LSQRBRACKETS; }
\]          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return RSQRBRACKETS; }

\;          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return SEMICOLON; }
\,          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return COMMA; }
 
\+          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return PLUS; }
\-          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return MINUS; }
\*          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return TIMES; }
\/          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return DIVIDE; }
\%          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return MOD; }

\=          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return ASSIGN; }

\==         { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return EQ; }
\!=         { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return NEQ; }
\>          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return GT; }
\<          { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return LT; }
\>=         { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return GE; }
\<=         { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
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
    char* symbol = yytext;
    struct token_t token;
    token.type = DEF;
    token.word = symbol;
    insert_token(tok);
    // Set yylval to point to the symbol table entry
    //yyval.symbol = symbol;
    yylval.address = number_of_symbols()+1;
    yylval.symbol = yytext;
    yylval.usage_count = 1;
    column += yyleng;     
    return IDENT; }

[0-9]+      { 
              char* symbol = yytext;
              struct token_t token;
              token.type = DEF;
              token.word = symbol;
              insert_token(tok);
              column += yyleng;
              return INT_CONSTANT; }
[0-9]+\.[0-9]+ { char* symbol = yytext;
                 struct token_t token;
                 token.type = DEF;
                 token.word = symbol;
                 insert_token(tok);
                 column += yyleng;
                 return FLOAT_CONSTANT; }
\"([^\\\"]|\\.)*\"  { char* symbol = yytext;
                      struct token_t token;
                      token.type = DEF;
                      token.word = symbol;
                      insert_token(tok);
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
