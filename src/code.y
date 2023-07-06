%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "./src/utils/code_utils.h"

#define MAX_VAR 50

int yylex();
void yyerror(char* s);

%}

%union{
  int address;
  char symbol[32];
  int usage_count;
  char code[500];
  char big_code[10000];
  struct {
      int is_funcall;
      char op[3];
      char code[200];
      char last_temp[3];
      char var[32];
      char alloc[32];
   } sem;
   struct {
      char label[10];
      char code[100];
   } opt_;
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
%type <sem> ATRIBSTAT_RIGHT
%type <sem> FUNCCALL_OR_EXPRESSION
%type <sem> FOLLOW_IDENT
%type <code> PARAMLISTCALL
%type <code> PARAMLISTCALLAUX
%type <code> PRINTSTAT
%type <code> READSTAT
%type <code> RETURNSTAT
%type <code> IFSTAT
%type <opt_> OPT_ELSE
%type <code> FORSTAT
%type <code> STATELIST
%type <code> OPT_STATELIST
%type <sem> ALLOCEXPRESSION
%type <sem> OPT_ALLOC_NUMEXP
%type <sem> EXPRESSION
%type <sem> OPT_REL_OP_NUM_EXPR
%type <code> REL_OP
%type <sem> NUMEXPRESSION
%type <sem> REC_PLUS_MINUS_TERM
%type <code> PLUS_OR_MINUS
%type <sem> TERM
%type <sem> REC_UNARYEXPR
%type <code> UNARYEXPR_OP
%type <sem> UNARYEXPR
%type <sem> FACTOR
%type <sem> LVALUE
%type <code> ID





%start PROGRAM
%%

PROGRAM : STATEMENT {
                     strcpy($$, $1);
                     puts($$);
                     }
        | FUNCLIST   {
                      strcpy($$, $1);
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
       strcat($$, " :\n");
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
           
DATATYPE : INT_KEYWORD { strcpy($$, "int "); }
         | FLOAT_KEYWORD { strcpy($$, "float "); }
         | STRING_KEYWORD { strcpy($$, "string "); }
         ;
          
STATEMENT : VARDECL SEMICOLON { strcpy($$, $1); }
          | ATRIBSTAT SEMICOLON { strcpy($$, $1); }
          | PRINTSTAT SEMICOLON { strcpy($$, $1); }
          | READSTAT SEMICOLON { strcpy($$, $1); }
          | RETURNSTAT SEMICOLON { strcpy($$, $1); }
          | IFSTAT { strcpy($$, $1); }
          | FORSTAT { strcpy($$, $1); }
          | LCURLYBRACKETS STATELIST RCURLYBRACKETS { strcpy($$, $1); }
          | BREAK SEMICOLON {
            strcpy($$, "goto ");
            strcat($$, last_for_end_lable_);
            strcat($$, "\n"); 
         } //terminar
          | SEMICOLON {
             char code[1] = " ";
             strcpy($$, code);
            }
          ;
            
VARDECL : DATATYPE IDENT OPT_VECTOR {
       strcpy($$, $1);
       strcat($$, $2);
       strcat($$, $3);
       strcat($$, "\n");
};
         
OPT_VECTOR : LSQRBRACKETS INT_CONSTANT RSQRBRACKETS OPT_VECTOR {
       strcpy($$, "[");
       strcat($$, $2);
       strcat($$, "]");
       strcat($$, $4);
}
           | { strcpy($$, " "); }
           ;
          
ATRIBSTAT : LVALUE ASSIGN ATRIBSTAT_RIGHT {
       strcpy($$, $<sem.code>3);
       strcat($$, $<sem.code>1);
       strcat($$, $<sem.var>1);
       strcat($$, " = ");
       strcat($$, $<sem.last_temp>3);
       strcat($$, "\n");
};
        
ATRIBSTAT_RIGHT : FUNCCALL_OR_EXPRESSION {
       strcpy($<sem.code>$, $<sem.code>1);
       strcpy($<sem.last_temp>$, $<sem.last_temp>1);
}
            | ALLOCEXPRESSION {
       strcpy($<sem.code>$, $<sem.code>1);
       strcpy($<sem.last_temp>$, $<sem.last_temp>1);
}
            ;                  

FUNCCALL_OR_EXPRESSION: PLUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[5];
    strcpy(curr_left_value, $1);
    strcat(curr_left_value, $<sem.last_temp>2);
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($<sem.code>3, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>3);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>3);
       strcat(previous_code, $<sem.last_temp>3);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>3);
    }

    if(strcmp($<sem.code>4, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>4);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>4);
       strcat(previous_code, $<sem.last_temp>4);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>4);
    }

    if(strcmp($<sem.code>5, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>5);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>5);
       strcat(previous_code, $<sem.last_temp>5);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>5);
    }
    strcpy($<sem.code>$, previous_code);
    strcpy($<sem.last_temp>$, curr_left_value);
}
                      | MINUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[5];
    strcpy(curr_left_value, $1);
    strcat(curr_left_value, $<sem.last_temp>2);
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($<sem.code>3, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>3);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>3);
       strcat(previous_code, $<sem.last_temp>3);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>3);
    }

    if(strcmp($<sem.code>4, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>4);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>4);
       strcat(previous_code, $<sem.last_temp>4);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>4);
    }

    if(strcmp($<sem.code>5, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>5);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>5);
       strcat(previous_code, $<sem.last_temp>5);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>5);
    }
    strcpy($<sem.code>$, previous_code);
    strcpy($<sem.last_temp>$, curr_left_value);
}
                      | INT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[5];
    get_temp_var(curr_left_value);
    strcpy(previous_code, curr_left_value);
    strcat(previous_code, " = ");
    strcat(previous_code, $1);
    strcat(previous_code, " \n");
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($<sem.code>2, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>2);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>2);
       strcat(previous_code, $<sem.last_temp>2);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>2);
    }

    if(strcmp($<sem.code>3, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>3);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>3);
       strcat(previous_code, $<sem.last_temp>3);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>3);
    }

    if(strcmp($<sem.code>4, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>4);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>4);
       strcat(previous_code, $<sem.last_temp>4);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>4);
    }
    strcpy($<sem.code>$, previous_code);
    strcpy($<sem.last_temp>$, curr_left_value);
}
                      | FLOAT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[5];
    get_temp_var(curr_left_value);
    strcpy(previous_code, curr_left_value);
    strcat(previous_code, " = ");
    strcat(previous_code, $1);
    strcat(previous_code, " \n");
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($<sem.code>2, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>2);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>2);
       strcat(previous_code, $<sem.last_temp>2);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>2);
    }

    if(strcmp($<sem.code>3, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>3);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>3);
       strcat(previous_code, $<sem.last_temp>3);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>3);
    }

    if(strcmp($<sem.code>4, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>4);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>4);
       strcat(previous_code, $<sem.last_temp>4);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>4);
    }
    strcpy($<sem.code>$, previous_code);
    strcpy($<sem.last_temp>$, curr_left_value);
}
                      | STRING_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[5];
    get_temp_var(curr_left_value);
    strcpy(previous_code, curr_left_value);
    strcat(previous_code, " = ");
    strcat(previous_code, $1);
    strcat(previous_code, " \n");
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($<sem.code>2, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>2);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>2);
       strcat(previous_code, $<sem.last_temp>2);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>2);
    }

    if(strcmp($<sem.code>3, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>3);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>3);
       strcat(previous_code, $<sem.last_temp>3);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>3);
    }

    if(strcmp($<sem.code>4, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>4);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>4);
       strcat(previous_code, $<sem.last_temp>4);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>4);
    }
    strcpy($<sem.code>$, previous_code);
    strcpy($<sem.last_temp>$, curr_left_value);
}
                      | RETURN_NULL REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[5];
    strcpy(curr_left_value, $1);
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($<sem.code>2, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>2);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>2);
       strcat(previous_code, $<sem.last_temp>2);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>2);
    }

    if(strcmp($<sem.code>3, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>3);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>3);
       strcat(previous_code, $<sem.last_temp>3);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>3);
    }

    if(strcmp($<sem.code>4, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>4);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>4);
       strcat(previous_code, $<sem.last_temp>4);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>4);
    }
    strcpy($<sem.code>$, previous_code);
    strcpy($<sem.last_temp>$, curr_left_value);
}
                      | LPAREN NUMEXPRESSION RPAREN REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR{
    char previous_code[100] = "";
    char curr_left_value[50];
    char temp_var[5];
    strcpy(previous_code, $<sem.code>2);
    strcpy(curr_left_value, $<sem.last_temp>2);
     //= f'{p[1]} {p[2]["temp_var"]}'
    if(strcmp($<sem.code>4, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>4);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>4);
       strcat(previous_code, $<sem.last_temp>4);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>4);
    }

    if(strcmp($<sem.code>5, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>5);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>5);
       strcat(previous_code, $<sem.last_temp>5);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>5);
    }

    if(strcmp($<sem.code>6, " ") != 0) {
       get_temp_var(temp_var);
       strcat(previous_code, $<sem.code>6);
       strcat(previous_code, temp_var);
       strcat(previous_code, " = ");
       strcat(previous_code, curr_left_value);
       strcat(previous_code, $<sem.op>6);
       strcat(previous_code, $<sem.last_temp>6);
       strcat(previous_code, " \n");
       strcpy(curr_left_value, $<sem.last_temp>6);
    }
    strcpy($<sem.code>$, previous_code);
    strcpy($<sem.last_temp>$, curr_left_value);
}
                      | IDENT FOLLOW_IDENT {
    char temp_var[5];
    if ($<sem.is_funcall>2) {
       strcpy($<sem.code>$, $<sem.last_temp>2);
       get_temp_var(temp_var);
       strcat($<sem.code>$, temp_var);
       strcat($<sem.code>$, " = call ");
       strcat($<sem.code>$, $1);
       strcat($<sem.code>$, " \n");
       strcat($<sem.last_temp>$, temp_var);
    } else if (strcmp($<sem.op>2, "0") != 0) {
       get_temp_var(temp_var);
       strcpy($<sem.code>$, $<sem.last_temp>2);
       strcat($<sem.code>$, temp_var);
       strcat($<sem.code>$, " = ");
       strcat($<sem.code>$, $<sem.op>2);
       strcat($<sem.code>$, $<sem.last_temp>2);
       strcat($<sem.code>$, " \n");
    } else {
       strcpy($<sem.code>$, " ");
       strcpy($<sem.last_temp>$, $1);
    }
}
                      ;

FOLLOW_IDENT: OPT_ALLOC_NUMEXP REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
       if(strcmp($<sem.code>1, " ") != 0) {
              strcpy($<sem.code>$, $<sem.code>1);
              strcpy($<sem.last_temp>$, $<sem.last_temp>1);
              strcpy($<sem.op>$, "0");
              $<sem.is_funcall>$ = 0;
       } else if(strcmp($<sem.last_temp>2, " ") != 0) {
              strcpy($<sem.code>$, $<sem.last_temp>2);
              strcpy($<sem.last_temp>$, $<sem.last_temp>2);
              strcpy($<sem.op>$, $<sem.op>2);
              $<sem.is_funcall>$ = 0;
       } else if(strcmp($<sem.code>3, " ") != 0) {
              strcpy($<sem.code>$, $<sem.code>3);
              strcpy($<sem.last_temp>$, $<sem.last_temp>3);
              strcpy($<sem.op>$, $<sem.op>3);
              $<sem.is_funcall>$ = 0;
       } else if(strcmp($<sem.code>4, " ") != 0) {
              strcpy($<sem.code>$, $<sem.code>4);
              strcpy($<sem.last_temp>$, $<sem.last_temp>4);
              strcpy($<sem.op>$, $<sem.op>4);
              $<sem.is_funcall>$ = 0;
       } else {
              strcpy($<sem.code>$, " ");
              $<sem.is_funcall>$ = 0;
       }
}
            | LPAREN PARAMLISTCALL RPAREN {
       strcpy($<sem.code>$, $2);
       $<sem.is_funcall>$ = 1;
}
            ;
      
PARAMLISTCALL : IDENT PARAMLISTCALLAUX {
       strcpy($$, "param ");
       strcat($$, $1);
       strcat($$, $2);
}
              | {strcpy($$, " ");}
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
       strcpy($$, $<sem.last_temp>2);
       strcat($$, "print ");
       strcat($$, $<sem.last_temp>2);
       strcat($$, "\n");
};
           
READSTAT : READ LVALUE {
       strcpy($$, "read ");
       strcat($$, $<sem.var>2);
       strcat($$, "\n");
};
         
RETURNSTAT : RETURN {
       strcpy($$, "return");
       strcat($$, "\n");
};
             
IFSTAT : IF LPAREN EXPRESSION RPAREN STATEMENT OPT_ELSE {
   char condition[5];
   strcpy(condition, $<sem.last_temp>3);
   char next_label[10];
   new_label(next_label);
   char lable_false[10];
   char jump_else[17];
   new_label(next_label);
   if(strcmp($<opt_.code>6, "\n") != 0) {
      strcpy(lable_false, $<opt_.label>6);
      strcpy(jump_else, "goto ");
      strcat(jump_else, next_label);
      strcat(jump_else, "\n");
   } else {
      strcpy(lable_false, next_label);
      strcpy(jump_else, "");
   }
   strcpy($$, $<sem.code>3);
   strcat($$, "if False ");
   strcat($$, condition);
   strcat($$, "goto ");
   strcat($$, lable_false);
   strcat($$, "\n");
   strcat($$, $5);
   strcat($$, jump_else);
   strcat($$, $<opt_.code>6);
   strcat($$, next_label);
   strcat($$, " :\n");

};
           
OPT_ELSE : ELSE LCURLYBRACKETS STATEMENT RCURLYBRACKETS {
   char start_label[10];
   new_label(start_label);
   strcpy($$.label, start_label);
   strcpy($<opt_.code>$, start_label);
   strcat($<opt_.code>$, " :\n");
   strcat($<opt_.code>$, $3);
}
         | { strcpy($<opt_.code>$, "\n");}
         ;
            
FORSTAT : FOR LPAREN ATRIBSTAT SEMICOLON EXPRESSION SEMICOLON ATRIBSTAT RPAREN STATEMENT {
   char start_label[10];
   char end_lable[10];
   new_label(start_label);
   new_label(end_lable);
   strcpy(last_for_end_lable_, end_lable);
   strcpy($$, $3);
   strcat($$, "\n");
   strcat($$, start_label);
   strcat($$, " :\n");
   strcat($$, "if False ");
   strcat($$, $<sem.last_temp>5);
   strcat($$, "goto ");
   strcat($$, end_lable);
   strcat($$, "\n");
   strcat($$, $9);
   strcat($$, $7);
   strcat($$, "goto ");
   strcat($$, start_label);
   strcat($$, "\n");
   strcat($$, end_lable);
   strcat($$, " :\n");
};

STATELIST : STATEMENT OPT_STATELIST {
       strcpy($$, $1);
       strcat($$, $2);
};
      
OPT_STATELIST : STATELIST { strcpy($$, $1); }
              | { strcpy($$, " "); }
              ;
    
ALLOCEXPRESSION : NEW DATATYPE LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP {
   char temp_var[5];
   get_temp_var(temp_var);
   strcpy($<sem.last_temp>$, temp_var);
   strcpy($<sem.code>$, $<sem.code>4);
   strcat($<sem.code>$, $<sem.code>6);
   strcat($<sem.code>$, temp_var);
   strcat($<sem.code>$, " = new ");
   strcat($<sem.code>$, $2);
   strcat($<sem.code>$,  " [");
   strcat($<sem.code>$, $<sem.last_temp>4);
   strcat($<sem.code>$, "]");
   strcat($<sem.code>$, $<sem.alloc>6);
   strcat($<sem.code>$, "\n");
};
   
OPT_ALLOC_NUMEXP : LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP {
   strcpy($<sem.code>$, $<sem.code>2);
   strcat($<sem.code>$, $<sem.code>4);
   strcpy($<sem.alloc>$, " [");
   strcat($<sem.alloc>$, $<sem.last_temp>2);
   strcat($<sem.alloc>$, "]");
   strcat($<sem.alloc>$, $<sem.alloc>4);
}
                 | {
                 char code[200] = " ";
                 strcpy($<sem.code>$, code);
                 strcpy($<sem.alloc>$, " ");
                 }
                 ;
         
EXPRESSION : NUMEXPRESSION OPT_REL_OP_NUM_EXPR {
   char result[5];
   get_temp_var(result);
   strcpy($<sem.last_temp>$, result);
   strcpy($<sem.code>$, $<sem.last_temp>2);
   strcat($<sem.code>$, $<sem.code>1);
   strcat($<sem.code>$, result);
   strcat($<sem.code>$, " = ");
   strcat($<sem.code>$, $<sem.last_temp>1);
   strcat($<sem.code>$, $<sem.op>2);
   strcat($<sem.code>$, $<sem.last_temp>2);
   strcat($<sem.code>$, "\n");

};

OPT_REL_OP_NUM_EXPR : REL_OP NUMEXPRESSION {
   strcpy($<sem.code>$, $<sem.last_temp>2);
   strcpy($<sem.op>$, $1);
   strcpy($<sem.last_temp>$, $<sem.last_temp>2);
}
                    | {
                     strcpy($<sem.code>$, " ");
                     strcpy($<sem.op>$, " ");
                     strcpy($<sem.last_temp>$, " ");
                  }
                    ;
             
REL_OP : LT { strcpy($$, " < "); }
       | GT { strcpy($$, " > "); }
       | LE { strcpy($$, " <= "); }
       | GE { strcpy($$, " >= "); }
       | EQ { strcpy($$, " == "); }
       | NEQ { strcpy($$, " != "); }
       ;
      
NUMEXPRESSION : TERM REC_PLUS_MINUS_TERM {
   char result[5];
   get_temp_var(result);
   strcpy($<sem.last_temp>$, result);
   strcpy($<sem.code>$, $<sem.last_temp>2);
   strcat($<sem.code>$, $<sem.code>1);
   strcat($<sem.code>$, result);
   strcat($<sem.code>$, " = ");
   strcat($<sem.code>$, $<sem.last_temp>1);
   strcat($<sem.code>$, $<sem.op>2);
   strcat($<sem.code>$, $<sem.last_temp>2);
   strcat($<sem.code>$, "\n");
};

REC_PLUS_MINUS_TERM : PLUS_OR_MINUS TERM REC_PLUS_MINUS_TERM {
   char result[5];
   get_temp_var(result);
   strcpy($<sem.op>$, $1);
   strcpy($<sem.last_temp>$, result);
   strcpy($<sem.code>$, $<sem.code>3);
   strcat($<sem.code>$, $<sem.code>2);
   strcat($<sem.code>$, result);
   strcat($<sem.code>$, " = ");
   strcat($<sem.code>$, $<sem.last_temp>2);
   strcat($<sem.code>$, $<sem.op>3);
   strcat($<sem.code>$, $<sem.last_temp>3);
   strcat($<sem.code>$, "\n");
}
                    | {
                     strcpy($<sem.code>$, " ");
                     strcpy($<sem.op>$, " ");
                     strcpy($<sem.last_temp>$, " ");
                  }
                    ;
      
PLUS_OR_MINUS : PLUS { strcpy($$, " + "); }
              | MINUS { strcpy($$, " - "); };
               
TERM : UNARYEXPR REC_UNARYEXPR {
   char result[5];
   get_temp_var(result);
   strcpy($<sem.last_temp>$, result);
   strcpy($<sem.code>$, $<sem.code>1);
   strcat($<sem.code>$, result);
   strcat($<sem.code>$, " = ");
   strcat($<sem.code>$, $<sem.last_temp>1);
   strcat($<sem.code>$, $<sem.op>2);
   strcat($<sem.code>$, $<sem.last_temp>2);
   strcat($<sem.code>$, "\n");
};
      
REC_UNARYEXPR : UNARYEXPR_OP TERM {
   strcpy($<sem.code>$, $<sem.code>2);
   strcpy($<sem.last_temp>$, $<sem.last_temp>2);
   strcpy($<sem.op>$, $1);
}
              | {
               strcpy($<sem.code>$, " ");
               strcpy($<sem.op>$, " ");
               strcpy($<sem.last_temp>$, " ");
            }
              ;
       
UNARYEXPR_OP : TIMES { strcpy($$, " * "); }
             | DIVIDE { strcpy($$, " / "); }
             | MOD { strcpy($$, " % "); }
             ;

UNARYEXPR : PLUS_OR_MINUS FACTOR {
   char result[5];
   get_temp_var(result);
   strcpy($<sem.last_temp>$, result);
   strcpy($<sem.code>$, $<sem.code>2);
   strcat($<sem.code>$, result);
   strcat($<sem.code>$, " = ");
   strcat($<sem.code>$, $1);
   strcat($<sem.code>$, $<sem.last_temp>2);
   strcat($<sem.code>$, "\n");
}
          | FACTOR {
            strcpy($<sem.last_temp>$, $<sem.last_temp>1);
            strcpy($<sem.code>$, $<sem.code>1);
          };
             
FACTOR : INT_CONSTANT {
    char result[5];
    get_temp_var(result);
    strcpy($<sem.last_temp>$, result);
    strcpy($<sem.code>$, result);
    strcat($<sem.code>$, " = ");
    strcat($<sem.code>$, $1);
    strcat($<sem.code>$, "\n");
}
       | FLOAT_CONSTANT {
    char result[5];
    get_temp_var(result);
    strcpy($<sem.last_temp>$, result);
    strcpy($<sem.code>$, result);
    strcat($<sem.code>$, " = ");
    strcat($<sem.code>$, $1);
    strcat($<sem.code>$, "\n");
}
       | STRING_CONSTANT {
    char result[5];
    get_temp_var(result);
    strcpy($<sem.last_temp>$, result);
    strcpy($<sem.code>$, result);
    strcat($<sem.code>$, " = ");
    strcat($<sem.code>$, $1);
    strcat($<sem.code>$, "\n");
}
       | RETURN_NULL {
    char result[5];
    get_temp_var(result);
    strcpy($<sem.last_temp>$, result);
    strcpy($<sem.code>$, result);
    strcat($<sem.code>$, " = ");
    strcat($<sem.code>$, $1);
    strcat($<sem.code>$, "\n");
}
       | LVALUE {
    strcpy($<sem.last_temp>$, $<sem.last_temp>1);
    strcpy($<sem.code>$, $<sem.last_temp>1);
    strcat($<sem.code>$, " = ");
    strcat($<sem.code>$, $<sem.var>1);
    strcat($<sem.code>$, "\n");
}  
       | LPAREN NUMEXPRESSION RPAREN {
         strcpy($<sem.last_temp>$, $<sem.last_temp>1);
         strcpy($<sem.code>$, $<sem.code>1);
       };
             
LVALUE : IDENT OPT_ALLOC_NUMEXP {
   char result[5];
   get_temp_var(result);
   strcpy($<sem.last_temp>$, result);
   strcpy($<sem.var>$, $1);
   strcpy($<sem.code>$, $<sem.code>2);
};

%%
