%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define MAX_VAR 50

int yylex();
void yyerror(char* s);

#include "./src/utils/code_utils.h"

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
                     puts($$);
                     }
        | FUNCLIST   {strcpy($$, $1);
                      puts($$);
                     }      
        | 
        ;
           
FUNCLIST : FUNCDEF FUNCLISTAUX {
                                strcpy($$, $1);
                                strcat($$, $2);
                               };
        
FUNCLISTAUX : FUNCLIST { strcpy($$, $1); }
            | {
               char vazio[1] = " ";
               strcpy($$, vazio);
              };
            
FUNCDEF : DEF IDENT LPAREN PARAMLIST RPAREN LCURLYBRACKETS STATELIST RCURLYBRACKETS {
       char next_label[10];
       new_label(next_label);
       strcpy($$, "goto ");
       strcat($$, next_label);
       strcat($$, "\n");
       strcat($$, $2);
       strcat($$, " :\n");
       strcat($$, $4);
       strcat($$, $7);
       strcat($$, "\n");
       strcat($$, next_label);
       strcat($$, "\n");
       puts($$);
};
          
PARAMLIST : DATATYPE IDENT PARAMLISTAUX {
                                         strcpy($$, "param ");
                                         strcat($$, $2);
                                         strcat($$, $3); 
                                        }
          | {
             char code[1] = " ";
             strcpy($$, code);
            }
          ;
       
PARAMLISTAUX : COMMA PARAMLIST {
                                char virgula[] = ", ";
                                strcpy($$, virgula);
                                strcat($$, $2);
                               }
             | {
                char code[] = "\n";
                strcpy($$, code);
               }
             ;
           
DATATYPE : INT_KEYWORD { strcpy($$, $1); }
         | FLOAT_KEYWORD { strcpy($$, $1); }
         | STRING_KEYWORD { strcpy($$, $1); }
         ;
          
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
             char code[1] = " ";
             strcpy($$, code);
            }
          ;
            
VARDECL : DATATYPE IDENT OPT_VECTOR {
       strcpy($$, $1);
       strcat($$, $2);
       strcat($$, $3);
};
         
OPT_VECTOR : LSQRBRACKETS INT_CONSTANT RSQRBRACKETS OPT_VECTOR {
       strcpy($$, "[");
       strcat($$, $2);
       strcat($$, "]");
       strcat($$, "$4");
}
           | { strcpy($$, " "); }
           ;
          
ATRIBSTAT : LVALUE ASSIGN ATRIBSTAT_RIGHT {
       strcpy($$, $3.code);
       strcat($$, $1.code);
       strcat($$, $1.var);
       strcat($$, $3.last_temp);

};
        
ATRIBSTAT_RIGHT : FUNCCALL_OR_EXPRESSION {
       strcpy($$.code, $1.code);
       strcpy($$.last_temp, $1.last_temp);
}
            | ALLOCEXPRESSION{
       strcpy($$.code, $1.code);
       strcpy($$.last_temp, $1.last_temp);
}
            ;                  

FUNCCALL_OR_EXPRESSION: PLUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[4];
    strcpy(curr_left_value, $1);
    strcat(curr_left_value, $2.last_temp);
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($3.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $3.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $3.op);
       strcat(previous_code, $3.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($4.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $4.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $4.op);
       strcat(previous_code, $4.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($5.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $5.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $5.op);
       strcat(previous_code, $5.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($6.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $6.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $6.op);
       strcat(previous_code, $6.last_temp);
       strcat(previous_code, " \n");
    }
    strcpy($$.code, previous_code);
    strcpy($$.last_temp, curr_left_value);
}
                      | MINUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[4];
    strcpy(curr_left_value, $1);
    strcat(curr_left_value, $2.last_temp);
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($3.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $3.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $3.op);
       strcat(previous_code, $3.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($4.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $4.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $4.op);
       strcat(previous_code, $4.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($5.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $5.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $5.op);
       strcat(previous_code, $5.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($6.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $6.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $6.op);
       strcat(previous_code, $6.last_temp);
       strcat(previous_code, " \n");
    }
    strcpy($$.code, previous_code);
    strcpy($$.last_temp, curr_left_value);
}
                      | INT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[4];
    get_temp_var(curr_left_value);
    strcpy(previous_code, curr_left_value);
    strcat(previous_code, " = ");
    strcat(previous_code, $1);
    strcat(previous_code, " \n");
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($2.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $2.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $2.op);
       strcat(previous_code, $2.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($3.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $3.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $3.op);
       strcat(previous_code, $3.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($4.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $4.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $4.op);
       strcat(previous_code, $4.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($5.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $5.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $5.op);
       strcat(previous_code, $5.last_temp);
       strcat(previous_code, " \n");
    }
    strcpy($$.code, previous_code);
    strcpy($$.last_temp, curr_left_value);
}
                      | FLOAT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[4];
    get_temp_var(curr_left_value);
    strcpy(previous_code, curr_left_value);
    strcat(previous_code, " = ");
    strcat(previous_code, $1);
    strcat(previous_code, " \n");
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($2.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $2.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $2.op);
       strcat(previous_code, $2.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($3.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $3.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $3.op);
       strcat(previous_code, $3.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($4.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $4.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $4.op);
       strcat(previous_code, $4.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($5.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $5.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $5.op);
       strcat(previous_code, $5.last_temp);
       strcat(previous_code, " \n");
    }
    strcpy($$.code, previous_code);
    strcpy($$.last_temp, curr_left_value);
}
                      | STRING_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[4];
    get_temp_var(curr_left_value);
    strcpy(previous_code, curr_left_value);
    strcat(previous_code, " = ");
    strcat(previous_code, $1);
    strcat(previous_code, " \n");
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($2.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $2.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $2.op);
       strcat(previous_code, $2.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($3.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $3.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $3.op);
       strcat(previous_code, $3.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($4.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $4.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $4.op);
       strcat(previous_code, $4.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($5.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $5.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $5.op);
       strcat(previous_code, $5.last_temp);
       strcat(previous_code, " \n");
    }
    strcpy($$.code, previous_code);
    strcpy($$.last_temp, curr_left_value);
}
                      | RETURN_NULL REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[4];
    strcpy(curr_left_value, $1);
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($2.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $2.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $2.op);
       strcat(previous_code, $2.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($3.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $3.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $3.op);
       strcat(previous_code, $3.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($4.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $4.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $4.op);
       strcat(previous_code, $4.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($5.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $5.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $5.op);
       strcat(previous_code, $5.last_temp);
       strcat(previous_code, " \n");
    }
    strcpy($$.code, previous_code);
    strcpy($$.last_temp, curr_left_value);
}
                      | LPAREN NUMEXPRESSION RPAREN REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[4];
    strcpy(previous_code, $2.code);
    strcpy(curr_left_value, $2.last_temp);
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($4.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $4.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $4.op);
       strcat(previous_code, $4.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($5.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $5.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $5.op);
       strcat(previous_code, $5.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($6.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $6.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $6.op);
       strcat(previous_code, $6.last_temp);
       strcat(previous_code, " \n");
    }

    if(strcmp($7.code, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $7.code);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $7.op);
       strcat(previous_code, $7.last_temp);
       strcat(previous_code, " \n");
    }
    strcpy($$.code, previous_code);
    strcpy($$.last_temp, curr_left_value);
}
                      | IDENT FOLLOW_IDENT {
    char temp_var[4];
    if ($2.is_funcall) {
       strcpy($$.code, $2.code);
       get_temp_var(temp_var);
       strcat($$.code, temp_var);
       strcat($$.code, " = call ");
       strcat($$.code, $1);
       strcat($$.code, " \n");
       strcat($$.last_temp, $temp_var);
    } else if (strcmp($2.op, "0") != 0) {
       get_temp_var(temp_var);
       strcpy(&&.code, $2,code);
       strcat(&&.code, temp_var);
       strcat($$.code, " = ");
       strcat($$.code, $2.op);
       strcat($$.code, $2.last_temp);
       strcat($$.code, " \n");
    } else {
       strcpy($$.code, " ");
       strcpy($$.last_temp, $1);
    }
}
                      ;

FOLLOW_IDENT: OPT_ALLOC_NUMEXP REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
       if(strcmp($1.code, " ") != 0) {
              strcpy($$.code, $1.code);
              strcpy($$.last_temp, $1.last_temp);
              strcpy($$.op, "0")
              $$.is_funcall = 0;
       } else if(strcmp($2.code, " ") != 0) {
              strcpy($$.code, $2.code);
              strcpy($$.last_temp, $2.last_temp);
              strcpy($$.op, $2.op);
              $$.is_funcall = 0;
       } else if(strcmp($3.code, " ") != 0) {
              strcpy($$.code, $3.code);
              strcpy($$.last_temp, $3.last_temp);
              strcpy($$.op, $3.op);
              $$.is_funcall = 0;
       } else if(strcmp($4.code, " ") != 0) {
              strcpy($$.code, $4.code);
              strcpy($$.last_temp, $4.last_temp);
              strcpy($$.op, $4.op);
              $$.is_funcall = 0;
       } else if(strcmp($5.code, " ") != 0) {
              strcpy($$.code, $5.code);
              strcpy($$.last_temp, $5.last_temp);
              strcpy($$.op, $5.op);
              $$.is_funcall = 0;
       } else {
              strcpy($$.code, " ");
              $$.is_funcall = 0;
       }
}
            | LPAREN PARAMLISTCALL RPAREN {
       strcpy($$.code, $2);
       $$.is_funcall = 1;
}
            ;
      
PARAMLISTCALL : IDENT PARAMLISTCALLAUX {
       strcpy($$, "param ");
       strcat($$, $2);
       strcat($$, $2);
}
              | {strcpy($$, " ")}
              ;
   
PARAMLISTCALLAUX : COMMA PARAMLISTCALL {
                                char virgula[] = ", ";
                                strcpy($$, virgula);
                                strcat($$, $2);
                               }
                   | {
                       char code[] = "\n";
                       strcpy($$, code);
                     }
                   ;
          
PRINTSTAT : PRINT EXPRESSION {
       strcpy($$, $2.code);
       strcat($$, "print ");
       strcat($$, $2.last_temp);
       strcat($$, "\n");
};
           
READSTAT : READ LVALUE {
       strcpy($$, "read ");
       strcat($$, $2.var);
       strcat($$, "\n");
};
         
RETURNSTAT : RETURN {
       strcpy($$, "return");
       strcat($$, "\n");
};
             
IFSTAT : IF LPAREN EXPRESSION RPAREN STATEMENT OPT_ELSE;
           
OPT_ELSE : ELSE STATEMENT
         | 
         ;
            
FORSTAT : FOR LPAREN ATRIBSTAT SEMICOLON EXPRESSION SEMICOLON ATRIBSTAT RPAREN STATEMENT;

STATELIST : STATEMENT OPT_STATELIST {
       strcpy($$, $1);
       strcat($$, $2);
};
      
OPT_STATELIST : STATELIST { strcpy($$, $1); }
              | { strcpy($$, " "); }
              ;
    
ALLOCEXPRESSION : NEW DATATYPE LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP;
   
OPT_ALLOC_NUMEXP : LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP
                 | 
                 ;
         
EXPRESSION : NUMEXPRESSION OPT_REL_OP_NUM_EXPR;

OPT_REL_OP_NUM_EXPR : REL_OP NUMEXPRESSION
                    | 
                    ;
             
REL_OP : LT { strcpy($$, " < "); }
       | GT { strcpy($$, " > "); }
       | LE { strcpy($$, " <= "); }
       | GE { strcpy($$, " >= "); }
       | EQ { strcpy($$, " == "); }
       | NEQ { strcpy($$, " != "); }
       ;
      
NUMEXPRESSION : TERM REC_PLUS_MINUS_TERM;

REC_PLUS_MINUS_TERM : PLUS_OR_MINUS TERM REC_PLUS_MINUS_TERM
                    | 
                    ;
      
PLUS_OR_MINUS : PLUS { strcpy($$, " + "); }
              | MINUS { strcpy($$, " - "); };
               
TERM : UNARYEXPR REC_UNARYEXPR;
      
REC_UNARYEXPR : UNARYEXPR_OP TERM
              | 
              ;
       
UNARYEXPR_OP : TIMES { strcpy($$, " * "); }
             | DIVIDE { strcpy($$, " / "); }
             | MOD { strcpy($$, " % "); }
             ;

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
