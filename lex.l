%{
#include <stdio.h>
#include "symbol_table.h"
#include "y.tab.h"

#define MAX_SYMBOLS 1000

int column = 1;
char* tokens[MAX_SYMBOLS];
int num_tokens = 0;

void insert_token();
char* lookup_token(char* symbol);
void print_tokens();

%}

%option noyywrap
%option yylineno

%%

def         { column += yyleng; return DEF; }
if          { column += yyleng; return IF; }
else        { column += yyleng; return ELSE; }
for         { column += yyleng; return FOR; }
break       { column += yyleng; return BREAK; }
return      { column += yyleng; return RETURN; }
new         { column += yyleng; return NEW; }
read        { column += yyleng; return READ; }
print       { column += yyleng; return PRINT; }
int         { column += yyleng; return INT_KEYWORD; }
float       { column += yyleng; return FLOAT_KEYWORD; }
string      { column += yyleng; return STRING_KEYWORD; }
null        { column += yyleng; return RETURN_NULL; }

\{          { column += yyleng; return LBRACKETS; }
\}          { column += yyleng; return RBRACKETS; }
\(          { column += yyleng; return LPAREN; }
\)          { column += yyleng; return RPAREN; }
\[          { column += yyleng; return LSQRBRACKETS; }
\]          { column += yyleng; return RSQRBRACKETS; }

\;          { column += yyleng; return SEMICOLON; }
\,          { column += yyleng; return COMMA; }
 
\+          { column += yyleng; return PLUS; }
\-          { column += yyleng; return MINUS; }
\*          { column += yyleng; return TIMES; }
\/          { column += yyleng; return DIVIDE; }
\%          { column += yyleng; return MOD; }

\=          { column += yyleng; return ASSIGN; }

\==         { column += yyleng; return EQ; }
\!=         { column += yyleng; return NEQ; }
\>          { column += yyleng; return GT; }
\<          { column += yyleng; return LT; }
\>=         { column += yyleng; return GE; }
\<=         { column += yyleng; return LE; }

[a-zA-Z_][a-zA-Z0-9_]*  { 
    symbol_t* symbol = lookup_symbol(yytext);
    if (symbol == NULL) {
        // If the identifier is not in the symbol table, add it
        insert_symbol(number_of_symbols()+1, yytext, 1);
        symbol = &symbol_table[num_symbols - 1];
    } else {
        symbol->usage_count += 1;
    }
    // Set yylval to point to the symbol table entry
    //yyval.symbol = symbol;
    yylval.address = number_of_symbols()+1;
    yylval.symbol = yytext;
    yylval.usage_count = 1;
    column += yyleng;     
    return IDENT; }

[0-9]+      { column += yyleng; return INT_CONSTANT; }
[0-9]+\.[0-9]+      { column += yyleng; return FLOAT_CONSTANT; }
\"([^\\\"]|\\.)*\"  { column += yyleng; return STRING_CONSTANT; }

[\t\r]+  { /* ignore whitespace */ }

[ ]+    { column += yyleng;}

[\n]+   { column = 1; }

.           { printf("Error: unexpected character %c\n", yytext[0]); }

%%

int valid = 1;

void yyerror(char *msg){
    char line[1024] = {0};
    int i;

    /* Concatenate current token with characters until end-of-line */
    strcat(line, yytext);
    while ((i = input()) != '\n' && i != EOF) {
        line[strlen(line)] = i;
    }
   
    printf("\nError: %s, line %d, column %d\n", msg, yylineno, column);
    printf("Line: '''   %s   '''\n", line);
    valid = 0;
}

void insert_token() {
    char* new_token = yytext;
    char* symbol = lookup_token(new_token);

    if (symbol == NULL) {
        if (num_tokens >= MAX_SYMBOLS) {
            printf("Error: symbol table overflow\n");
            return;
        }
        tokens[num_tokens] = new_token;
        num_tokens++;
    }    
}

char* lookup_token(char* symbol) {
    int i;
    for (i = 0; i < num_tokens; i++) {
        if (strcmp(tokens[i], symbol) == 0) {
            return tokens[i];
        }
    }
    return NULL;
}

void print_tokens() {
    int i;
    printf("Tokens\n");
    for (i = 0; i < num_tokens; i++) {
        printf("%s\n", tokens[i]);
    }
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
                printf("\nSatisfies the grammar \n");
                print_table();
                print_tokens();
            }
        } else {
            printf("Can not find this file!\n");
        }
    }
    
    return 0;
}
