%{

#include <stdlib.h>
#include <stdio.h>
#include "./src/utils/syntactic_symbol_table.h"
#include "./src/utils/types.h"
#include "./src/utils/stack.h"

int yylex();
void yyerror(char* s);

%}

%union{
  int address;
  char *symbol;
  int usage_count;
}


%token <symbol> DEF
%token <symbol> IF
%token <symbol> ELSE
%token <symbol> FOR
%token <symbol> BREAK
%token <symbol> RETURN
%token <symbol> NEW
%token <symbol> READ
%token <symbol> PRINT
%token <symbol> INT_KEYWORD
%token <symbol> FLOAT_KEYWORD
%token <symbol> STRING_KEYWORD

%token <symbol> RETURN_NULL

%token <symbol> LCURLYBRACKETS
%token <symbol> RCURLYBRACKETS
%token <symbol> LPAREN
%token <symbol> RPAREN
%token <symbol> LSQRBRACKETS
%token <symbol> RSQRBRACKETS

%token <symbol> SEMICOLON
%token <symbol> COMMA

%left <symbol> PLUS
%left <symbol> MINUS
%left <symbol> TIMES
%left <symbol> DIVIDE
%left <symbol> MOD

%token <symbol> ASSIGN

%token <symbol> EQ
%token <symbol> NEQ
%token <symbol> GT
%token <symbol> LT
%token <symbol> GE
%token <symbol> LE

%token <symbol> IDENT 

%token <symbol> INT_CONSTANT
%token <symbol> FLOAT_CONSTANT
%token <symbol> STRING_CONSTANT

%type <symbol> PROGRAM
%type <symbol> STATEMENT
%type <symbol> FUNCLIST
%type <symbol> FUNCLISTAUX
%type <symbol> FUNCDEF
%type <symbol> PARAMLIST
%type <symbol> PARAMLISTAUX
%type <symbol> DATATYPE
%type <symbol> VARDECL
%type <symbol> OPT_VECTOR
%type <symbol> ATRIBSTAT
%type <symbol> ATRIBSTAT_RIGHT
%type <symbol> FUNCCALL_OR_EXPRESSION
%type <symbol> FOLLOW_IDENT
%type <symbol> PARAMLISTCALL
%type <symbol> PARAMLISTCALLAUX
%type <symbol> PRINTSTAT
%type <symbol> READSTAT
%type <symbol> RETURNSTAT
%type <symbol> IFSTAT
%type <symbol> OPT_ELSE
%type <symbol> FORSTAT
%type <symbol> STATELIST
%type <symbol> OPT_STATELIST
%type <symbol> ALLOCEXPRESSION
%type <symbol> OPT_ALLOC_NUMEXP
%type <symbol> EXPRESSION
%type <symbol> OPT_REL_OP_NUM_EXPR
%type <symbol> REL_OP
%type <symbol> NUMEXPRESSION
%type <symbol> REC_PLUS_MINUS_TERM
%type <symbol> PLUS_OR_MINUS
%type <symbol> TERM
%type <symbol> REC_UNARYEXPR
%type <symbol> UNARYEXPR_OP
%type <symbol> UNARYEXPR
%type <symbol> FACTOR
%type <symbol> LVALUE
%type <symbol> ID



%start PROGRAM
%%

PROGRAM : STATEMENT
        | FUNCLIST
        | 
        ;
           
FUNCLIST : FUNCDEF FUNCLISTAUX;
        
FUNCLISTAUX : FUNCLIST
            | 
            ;
            
FUNCDEF : DEF IDENT LPAREN PARAMLIST RPAREN LCURLYBRACKETS STATELIST RCURLYBRACKETS{ 
       // Go back to upper scope
       // scopes.pop()
       pop();

       // Add function declaration to this scope symbol table
       //scope scope = scopes.peek();
       scope scope = peek();
       char type[9] = "function";
       int dimension[100];

       char* ident = $2;
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, ident, type, 1, dimension);
}; 
          
          
PARAMLIST : DATATYPE IDENT PARAMLISTAUX
          | 
          ;
       
PARAMLISTAUX : COMMA PARAMLIST
             | 
             ;
           
DATATYPE : INT_KEYWORD
         | FLOAT_KEYWORD
         | STRING_KEYWORD;
          
STATEMENT : VARDECL SEMICOLON
          | ATRIBSTAT SEMICOLON
          | PRINTSTAT SEMICOLON
          | READSTAT SEMICOLON
          | RETURNSTAT SEMICOLON
          | IFSTAT
          | FORSTAT
          | LCURLYBRACKETS STATELIST RCURLYBRACKETS
          | BREAK SEMICOLON
          | SEMICOLON;
            
VARDECL : DATATYPE IDENT OPT_VECTOR;
         
OPT_VECTOR : LSQRBRACKETS INT_CONSTANT RSQRBRACKETS OPT_VECTOR
           | 
           ;
          
ATRIBSTAT : LVALUE ASSIGN ATRIBSTAT_RIGHT;
        
ATRIBSTAT_RIGHT : FUNCCALL_OR_EXPRESSION
            | ALLOCEXPRESSION;                  

FUNCCALL_OR_EXPRESSION: PLUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
                      | MINUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
                      | INT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
                      | FLOAT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
                      | STRING_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
                      | RETURN_NULL REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
                      | LPAREN NUMEXPRESSION RPAREN REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
                      | IDENT FOLLOW_IDENT;

FOLLOW_IDENT: OPT_ALLOC_NUMEXP REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
            | LPAREN PARAMLISTCALL RPAREN;
      
PARAMLISTCALL : IDENT PARAMLISTCALLAUX
              | 
              ;
   
PARAMLISTCALLAUX : COMMA PARAMLISTCALL
                 | 
                 ;
          
PRINTSTAT : PRINT EXPRESSION;
           
READSTAT : READ LVALUE;
         
RETURNSTAT : RETURN;
             
IFSTAT : IF LPAREN EXPRESSION RPAREN STATEMENT OPT_ELSE;
           
OPT_ELSE : ELSE STATEMENT
         | 
         ;
            
FORSTAT : FOR LPAREN ATRIBSTAT SEMICOLON EXPRESSION SEMICOLON ATRIBSTAT RPAREN STATEMENT;

STATELIST : STATEMENT OPT_STATELIST;
      
OPT_STATELIST : STATELIST
              | 
              ;
    
ALLOCEXPRESSION : NEW DATATYPE LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP;
   
OPT_ALLOC_NUMEXP : LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP
                 | 
                 ;
         
EXPRESSION : NUMEXPRESSION OPT_REL_OP_NUM_EXPR;

OPT_REL_OP_NUM_EXPR : REL_OP NUMEXPRESSION
                    | 
                    ;
             
REL_OP : LT
       | GT
       | LE
       | GE
       | EQ
       | NEQ;
      
NUMEXPRESSION : TERM REC_PLUS_MINUS_TERM;

REC_PLUS_MINUS_TERM : PLUS_OR_MINUS TERM REC_PLUS_MINUS_TERM
                    | 
                    ;
      
PLUS_OR_MINUS : PLUS
              | MINUS;
               
TERM : UNARYEXPR REC_UNARYEXPR;
      
REC_UNARYEXPR : UNARYEXPR_OP TERM
              | 
              ;
       
UNARYEXPR_OP : TIMES
             | DIVIDE
             | MOD;
          
UNARYEXPR : PLUS_OR_MINUS FACTOR
          | FACTOR;
             
FACTOR : INT_CONSTANT
       | FLOAT_CONSTANT
       | STRING_CONSTANT
       | RETURN_NULL
       | LVALUE
       | LPAREN NUMEXPRESSION RPAREN;
             
LVALUE : IDENT OPT_ALLOC_NUMEXP;

%%
