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


%token DEF
%token IF
%token ELSE
%token FOR
%token BREAK
%token RETURN
%token NEW
%token READ
%token PRINT
%token INT_KEYWORD
%token FLOAT_KEYWORD
%token STRING_KEYWORD

%token RETURN_NULL

%token LCURLYBRACKETS
%token RCURLYBRACKETS
%token LPAREN
%token RPAREN
%token LSQRBRACKETS
%token RSQRBRACKETS

%token SEMICOLON
%token COMMA

%left PLUS
%left MINUS
%left TIMES
%left DIVIDE
%left MOD

%token ASSIGN

%token EQ
%token NEQ
%token GT
%token LT
%token GE
%token LE

%token IDENT

%token INT_CONSTANT
%token FLOAT_CONSTANT
%token STRING_CONSTANT


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
            
FUNCDEF : DEF IDENT LPAREN PARAMLIST RPAREN LCURLYBRACKETS STATELIST RCURLYBRACKETS;
          
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
