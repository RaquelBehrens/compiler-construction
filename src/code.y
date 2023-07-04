%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

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

PROGRAM : STATEMENT {$$ = $1;
                     printf("OI3\n");
                     puts($$);
                     }
        | FUNCLIST   {$$ = $1;
                      printf("OI1\n");
                      puts($$);
                     }      
        | 
        ;
           
FUNCLIST : FUNCDEF FUNCLISTAUX {
                                char* def = $1;
                                printf("1\n");
                                char* func_list = $2;
                                int size = sizeof(def) + sizeof(func_list);
                                char code[size];
                                strcat(code, def);
                                strcat(code, func_list);
                                $$ = code;
                               };
        
FUNCLISTAUX : FUNCLIST { $$ = $1;
printf("7\n"); }
            | {
               printf("2\n");
               char vazio[] = " ";
               $$ = vazio;
              };
            
FUNCDEF : DEF IDENT LPAREN PARAMLIST RPAREN LCURLYBRACKETS STATELIST RCURLYBRACKETS {
       //char* next_label = new_label();
       char* name = $2;
       printf("3\n");
       char* param_list = $4;
       char* func = $7;
       int size = sizeof(name) + sizeof(param_list) + sizeof(func) + 30;
       char code[size];
       strcat(code, "goto ");
       //strcat(code, new_label);
       strcat(code, "\n");
       strcat(code, name);
       strcat(code, " :\n");
       strcat(code, param_list);
       strcat(code, func);
       strcat(code, "\n");
       //strcat(code, next_label);
       strcat(code, "\n");
       $$ = code;
};

ID : IDENT { printf("veio?\n");
$$ = yylval.symbol; }
          
PARAMLIST : DATATYPE IDENT PARAMLISTAUX {
                                         char* param = $2;
                                         printf("4\n");
                                         
                                         char* list = $3;
                                         puts(list);
                                         int size = sizeof(param) + sizeof(list) + 10;
                                         char code[size];
                                         printf("5\n");
                                         strcat(code, "param ");
                                         printf("9\n");
                                         strcat(code, param);
                                         printf("7\n");
                                         strcat(code, list);
                                         printf("6\n");
                                         $$ = code;     
                                        }
          | {
             char code[] = " ";
             $$ = code;
            }
          ;
       
PARAMLISTAUX : COMMA PARAMLIST {
                                $$ = $2;
                                printf("5\n");
                               }
             | {
                printf("6\n");
                char code[] = "\n";
                $$ = code;
               }
             ;
           
DATATYPE : INT_KEYWORD { $$ = $1; }
         | FLOAT_KEYWORD
         | STRING_KEYWORD;
          
STATEMENT : VARDECL SEMICOLON {$$ = $1;}
          | ATRIBSTAT SEMICOLON {$$ = $1;}
          | PRINTSTAT SEMICOLON {$$ = $1;}
          | READSTAT SEMICOLON {$$ = $1;}
          | RETURNSTAT SEMICOLON {$$ = $1;}
          | IFSTAT {$$ = $1;}
          | FORSTAT {$$ = $1;}
          | LCURLYBRACKETS STATELIST RCURLYBRACKETS {$$ = $2;}
          | BREAK SEMICOLON {$$ = $2;} //terminar
          | SEMICOLON {
             char code[] = " ";
             $$ = code;
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
