%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int yylex();
void yyerror(char* s);

%}

%union{
  int address;
  char symbol[32];
  int usage_count;
  char code[50];
  char big_code[600];
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

%type <big_code> PROGRAM
%type <big_code> STATEMENT
%type <big_code> FUNCLIST
%type <code> FUNCLISTAUX
%type <code> FUNCDEF
%type <code> PARAMLIST
%type <code> PARAMLISTAUX
%type <code> DATATYPE
%type <code> VARDECL
%type <code> OPT_VECTOR
%type <code> ATRIBSTAT
%type <code> ATRIBSTAT_RIGHT
%type <code> FUNCCALL_OR_EXPRESSION
%type <code> FOLLOW_IDENT
%type <code> PARAMLISTCALL
%type <code> PARAMLISTCALLAUX
%type <code> PRINTSTAT
%type <code> READSTAT
%type <code> RETURNSTAT
%type <code> IFSTAT
%type <code> OPT_ELSE
%type <code> FORSTAT
%type <code> STATELIST
%type <code> OPT_STATELIST
%type <code> ALLOCEXPRESSION
%type <code> OPT_ALLOC_NUMEXP
%type <code> EXPRESSION
%type <code> OPT_REL_OP_NUM_EXPR
%type <code> REL_OP
%type <code> NUMEXPRESSION
%type <code> REC_PLUS_MINUS_TERM
%type <code> PLUS_OR_MINUS
%type <code> TERM
%type <code> REC_UNARYEXPR
%type <code> UNARYEXPR_OP
%type <code> UNARYEXPR
%type <code> FACTOR
%type <code> LVALUE
%type <code> ID





%start PROGRAM
%%

PROGRAM : STATEMENT {strcpy($$, $1);
                     printf("OI3\n");
                     puts($$);
                     }
        | FUNCLIST   {strcpy($$, $1);
                      puts($$);
                     }      
        | 
        ;
           
FUNCLIST : FUNCDEF FUNCLISTAUX {
                                char code[500];
                                strcat(code, $1);
                                strcat(code, $2);
                                strcpy($$, code);
                               };
        
FUNCLISTAUX : FUNCLIST { strcpy($$, $1); }
            | {
               char vazio[1] = " ";
               strcpy($$, vazio);
              };
            
FUNCDEF : DEF IDENT LPAREN PARAMLIST RPAREN LCURLYBRACKETS STATELIST RCURLYBRACKETS {
       //char* next_label = new_label();
       char code[500];
       strcat(code, "goto ");
       //strcat(code, new_label);
       strcat(code, "\n");
       strcat(code, $2);
       strcat(code, " :\n");
       strcat(code, $4);
       strcat(code, $7);
       strcat(code, "\n");
       //strcat(code, next_label);
       strcat(code, "\n");
       strcpy($$, code);
       puts(code);
};
          
PARAMLIST : DATATYPE IDENT PARAMLISTAUX {
                                         char code[50];
                                         strcat(code, "param ");
                                         strcat(code, $2);
                                         strcat(code, ", ");
                                         strcat(code, $3);
                                         strcpy($$, code);   
                                        }
          | {
             char code[1] = " ";
             strcpy($$, code);
            }
          ;
       
PARAMLISTAUX : COMMA PARAMLIST {
                                strcpy($$, $2);
                               }
             | {
                char code[] = "\n";
                strcpy($$, code);
               }
             ;
           
DATATYPE : INT_KEYWORD { strcpy($$, $1); }
         | FLOAT_KEYWORD
         | STRING_KEYWORD;
          
STATEMENT : VARDECL SEMICOLON { strcpy($$, $1); }
          | ATRIBSTAT SEMICOLON { strcpy($$, $1); }
          | PRINTSTAT SEMICOLON { strcpy($$, $1); }
          | READSTAT SEMICOLON { strcpy($$, $1); }
          | RETURNSTAT SEMICOLON { strcpy($$, $1); }
          | IFSTAT { strcpy($$, $1); }
          | FORSTAT { strcpy($$, $1); }
          | LCURLYBRACKETS STATELIST RCURLYBRACKETS { strcpy($$, $1); }
          | BREAK SEMICOLON { strcpy($$, $1); } //terminar
          | SEMICOLON {
             char code[] = " ";
             strcpy($$, code);
            }
          ;
            
VARDECL : DATATYPE IDENT OPT_VECTOR {

};
         
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
