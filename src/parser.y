%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "./src/utils/recursive_list.h"
#include "./src/utils/syntactic_symbol_table.h"
#include "./src/utils/types.h"
#include "./src/utils/stack.h"

int yylex();
void yyerror(char* s);

char * get_var_type();
void new_scope(bool is_loop);
void show_tables();

typedef struct scope_and_expressions {
       char * operation;
       char * vector;
       node node;
} scope_and_expressions;

int top_num_expressions = -1;
node num_expressions[10000];

%}

%union{
  int address;
  char symbol[50];
  int usage_count;
  int integer_return;
  float float_return;
  struct recursive_list *recursive_list;
  struct node *node;
  struct scope_and_expressions *scope_and_expressions;
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

%token <integer_return> INT_CONSTANT
%token <float_return> FLOAT_CONSTANT
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
%type <integer_return> OPT_VECTOR
%type <symbol> ATRIBSTAT
%type ATRIBSTAT_RIGHT
%type <scope_and_expressions> FUNCCALL_OR_EXPRESSION
%type <scope_and_expressions> FOLLOW_IDENT
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
%type <node> ALLOCEXPRESSION
%type <symbol> OPT_ALLOC_NUMEXP
%type <node> EXPRESSION
%type <node> OPT_REL_OP_NUM_EXPR
%type <symbol> REL_OP
%type <scope_and_expressions> NUMEXPRESSION
%type <scope_and_expressions> REC_PLUS_MINUS_TERM
%type <scope_and_expressions> PLUS_OR_MINUS
%type <scope_and_expressions> TERM
%type <scope_and_expressions> REC_UNARYEXPR
%type <scope_and_expressions> UNARYEXPR_OP
%type <scope_and_expressions> UNARYEXPR
%type <scope_and_expressions> FACTOR
%type <scope_and_expressions> LVALUE


%start PROGRAM
%%

PROGRAM : new_scope STATEMENT {
              pop();
              show_tables();
        }
        | new_scope FUNCLIST {
              pop();
              show_tables();
        }
        | { show_tables(); }
        ;
           
FUNCLIST : FUNCDEF FUNCLISTAUX {printf("aaaaaaaaaaaaaaaa\n");};
        
FUNCLISTAUX : FUNCLIST {printf("bbbbbbbbbbbb\n");}
            | { printf("bbbbbbbbbbbb\n"); }
            ;
            
FUNCDEF : new_scope DEF IDENT LPAREN PARAMLIST RPAREN LCURLYBRACKETS STATELIST RCURLYBRACKETS { 
       // Go back to upper scope
       // scopes.pop()

       printf("cccccccccccccc\n");
       pop();
       // Add function declaration to this scope symbol table
       //scope scope = scopes.peek();
       
       scope scope = peek();
       char type[9] = "function";
       int dimension = 0;
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, $2, type, 1, dimension);
}; 
          
          
PARAMLIST : DATATYPE IDENT PARAMLISTAUX {
       printf("ddddddddddddd\n");
       // Add function declaration to this scope symbol table
       scope scope = peek();
       printf("ddddddddddddd\n");
       int dimension = 0;
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, $2, $1, 1, dimension);
       printf("ddddddddddddd\n");
}
          | { printf("ddddddddddddd\n"); }
          ;
       
PARAMLISTAUX : COMMA PARAMLIST {printf("eeeeeeeeeeeeee\n");}
             | { printf("eeeeeeeeeeeeee\n"); }
             ;
           
DATATYPE : INT_KEYWORD { 
       printf("ffffffffffffffff\n");
       strcpy($$, "int"); }
         | FLOAT_KEYWORD { printf("ffffffffffffffff\n");
         strcpy($$, "float"); }
         | STRING_KEYWORD { printf("ffffffffffffffff\n");
         strcpy($$, "string"); };
          
STATEMENT : VARDECL SEMICOLON {printf("ggggggggggggggg\n");}
          | ATRIBSTAT SEMICOLON  {printf("ggggggggggggggg\n");}
          | PRINTSTAT SEMICOLON {printf("ggggggggggggggg\n");}
          | READSTAT SEMICOLON {printf("ggggggggggggggg\n");}
          | RETURNSTAT SEMICOLON {printf("ggggggggggggggg\n");}
          | IFSTAT {printf("ggggggggggggggg\n");}
          | FORSTAT {printf("ggggggggggggggg\n");}
          | new_scope LCURLYBRACKETS STATELIST RCURLYBRACKETS {
              //scopes.pop()
              printf("ggggggggggggggg\n");
              pop();
          }
          | BREAK SEMICOLON {
              printf("ggggggggggggggg\n");
              int t = top;
              while (true) {
                  if (scopes[t].is_loop == true) {
                     break;
                  }
                  t -= 1;
                  if (t < 0) {
                     printf("Error: Break found outside any loop\n");
                  }             
              }
          }
          | SEMICOLON {printf("ggggggggggggggg\n");};
            
VARDECL : DATATYPE IDENT OPT_VECTOR {
       printf("hhhhhhhhhhhhhhhhhhhh\n");
       scope scope = peek();
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, $2, $1, 1, $3);
};

//use recursive list here, in the opt vector return     
OPT_VECTOR : LSQRBRACKETS INT_CONSTANT RSQRBRACKETS OPT_VECTOR {
       printf("iiiiiiiiiiiiiiiiiiii\n");
              $$ = $4 + 1;
           }
           | {
              printf("iiiiiiiiiiiiiiiii\n");
              $$ = 0;
           }
           ;
          
ATRIBSTAT : LVALUE ASSIGN ATRIBSTAT_RIGHT {printf("jjjjjjjjjjjjjjjj\n");};
        
ATRIBSTAT_RIGHT : FUNCCALL_OR_EXPRESSION {printf("kkkkkkkkkkkkkkkkkkkk\n");}
            | ALLOCEXPRESSION {printf("kkkkkkkkkkkkkkkkkkkk\n");};                  

FUNCCALL_OR_EXPRESSION: PLUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
       printf("llllllllllllllll\n");
                            node right_node = $2->node;

                            if ($3 != NULL) {
                                   char * result_type = check_operation($3->node.result, right_node.result, $3->node.operation);
                                   if (strcmp(result.type, "0") == 0) {
                                          char error[100] = "Error: Invalid Type Operation between ";
                                          strcat(error,$3->node.result);
                                          strcat(error,right_node.result);
                                          strcat(error,$3->node.operation);
                                          strcat(error, "!\n");
                                          yyerror(error);
                                   }
                                   node new_right_node_result = {$3->node.result, right_node.result, $3->node.operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            if ($4 != NULL) {
                                   char * result_type = check_operation($4->node.result, right_node.result, $4->node.operation);
                                   node new_right_node_result = {$4->node.result, right_node.result, $4->node.operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            num_expressions[top_num_expressions] = right_node;
                            top_num_expressions += 1;
                      }
                      | MINUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            printf("llllllllllllllll\n");
                            node right_node = $2->node;
                            right_node.value.i *= -1;
                            right_node.value.f *= -1;

                            if ($3 != NULL) {
                                   char * result_type = check_operation($3->node.result, right_node.result, $3->node.operation);
                                   node new_right_node_result = {$3->node.result, right_node.result, $3->node.operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            if ($4 != NULL) {
                                   char * result_type = check_operation($4->node.result, right_node.result, $4->node.operation);
                                   node new_right_node_result = {$4->node.result, right_node.result, $4->node.operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            num_expressions[top_num_expressions] = right_node;
                            top_num_expressions += 1;
                      }
                      | INT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            printf("llllllllllllllll\n");
                            node new_node;
                            new_node.value.i = $1;
                            new_node.result = "int";

                            if ($2 != NULL) {
                                   char * result_type = check_operation(new_node.result, $2->node.result, $2->node.operation);
                                   node new_right_node_result = {new_node.result, $2->node.result, $2->node.operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ($3 != NULL) {
                                   char * result_type = check_operation(new_node.result, $3->node.result, $3->node.operation);
                                   node new_right_node_result = {new_node.result, $3->node.result, $3->node.operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                            this_scope->node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | FLOAT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            printf("llllllllllllllll\n");
                            node new_node;
                            new_node.value.f = $1;
                            new_node.result = "float";

                            if ($2 != NULL) {
                                   char * result_type = check_operation(new_node.result, $2->node.result, $2->node.operation);
                                   node new_right_node_result = {new_node.result, $2->node.result, $2->node.operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ($3 != NULL) {
                                   char * result_type = check_operation(new_node.result, $3->node.result, $3->node.operation);
                                   node new_right_node_result = {new_node.result, $3->node.result, $3->node.operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                            this_scope->node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | STRING_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            printf("llllllllllllllll\n");
                            node new_node;
                            strcpy(new_node.value.str, $1);
                            new_node.result = "string";

                            if ($2 != NULL) {
                                   char * result_type = check_operation(new_node.result, $2->node.result, $2->node.operation);
                                   node new_right_node_result = {new_node.result, $2->node.result, $2->node.operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ($3 != NULL) {
                                   char * result_type = check_operation(new_node.result, $3->node.result, $3->node.operation);
                                   node new_right_node_result = {new_node.result, $3->node.result, $3->node.operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                            this_scope->node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | RETURN_NULL REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {printf("llllllllllllllll\n");}
                      | LPAREN NUMEXPRESSION RPAREN REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            printf("llllllllllllllll\n");
                            node new_node;
                            new_node = $2->node;

                            if ($4 != NULL) {
                                   char * result_type = check_operation(new_node.result, $4->node.result, $4->node.operation);
                                   node new_right_node_result = {new_node.result, $4->node.result, $4->node.operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ($5 != NULL) {
                                   char * result_type = check_operation(new_node.result, $5->node.result, $5->node.operation);
                                   node new_right_node_result = {new_node.result, $5->node.result, $5->node.operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                            this_scope->node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | IDENT FOLLOW_IDENT {
                            printf("llllllllllllllll\n");
                            node new_node;
                            strcpy(new_node.node_before, $1);
                            new_node.result = get_var_type($1);

                            if ($2 != NULL && $2->node.operation != NULL) {
                                   strcpy(new_node.operation, $2->vector);

                                   char * result_type = check_operation(new_node.result, $2->node.result, $2->node.operation);
                                   node new_right_node_result = {new_node.result, $2->node.result, $2->node.operation, result_type};
                                   new_node = new_right_node_result;

                                   num_expressions[top_num_expressions] = new_node;
                                   top_num_expressions += 1;
                            }
                      };

FOLLOW_IDENT: OPT_ALLOC_NUMEXP REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
       printf("mmmmmmmmmmmmmmm\n");
              node new_node;
              char * operation = "";

              if ($3 != NULL) {
                     if ($2 != NULL) {
                            new_node = $2->node;
                            operation = $2->node.operation;
                     } else {
                            new_node = $3->node;
                            operation = $3->node.operation;
                     }

                     char * result_type = check_operation(new_node.result, $3->node.result, $3->node.operation);
                     node new_right_node_result = {new_node.result, $3->node.result, $3->node.operation, result_type};
                     new_node = new_right_node_result;
              }

              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node = new_node;
              this_scope->operation = operation;
              this_scope->vector = $1;
              $$ = this_scope;
            }
            | LPAREN PARAMLISTCALL RPAREN { printf("mmmmmmmmmmmmmmm\n"); };
      
PARAMLISTCALL : IDENT PARAMLISTCALLAUX {printf("nnnnnnnnnnnnnnnn\n");}
              | { printf("nnnnnnnnnnnnnn\n"); }
              ;
   
PARAMLISTCALLAUX : COMMA PARAMLISTCALL {printf("ooooooooooooo\n"); }
                 | {printf("ooooooooooooo\n"); }
                 ;
          
PRINTSTAT : PRINT EXPRESSION {printf("pppppppppppp\n"); };
           
READSTAT : READ teste LVALUE {printf("qqqqqqqqqqqqqqq\n"); };
         
RETURNSTAT : RETURN {printf("rrrrrrrrrrrrrrrrr\n"); };
             
IFSTAT : new_scope IF LPAREN EXPRESSION RPAREN STATELIST OPT_ELSE { printf("ssssssssssssssssssss\n");
       pop(); };
           
OPT_ELSE : new_scope ELSE STATEMENT { printf("tttttttttttt\n");
       pop(); }
         | { printf("tttttttttttt\n"); }
         ;
            
FORSTAT : FOR LPAREN ATRIBSTAT SEMICOLON EXPRESSION SEMICOLON ATRIBSTAT RPAREN STATEMENT new_loop_scope { printf("uuuuuuuuuuuuuu\n");
       pop(); };

STATELIST : STATEMENT OPT_STATELIST { printf("vvvvvvvvvvvvvv\n");};
      
OPT_STATELIST : STATELIST {printf("wwwwwwwwwwwww\n");}
              | { printf("wwwwwwwwwwww\n"); }
              ;
    
ALLOCEXPRESSION : NEW DATATYPE LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP {
       printf("xxxxxxxxxxxx\n");
       num_expressions[top_num_expressions] = $4->node;
       top_num_expressions += 1;
};

OPT_ALLOC_NUMEXP : LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP {
       printf("yyyyyyyyyyyyyy\n");
       char node_str[100];  // Assuming a maximum size of 100 characters for the string representation of a node
       sprintf(node_str, "%d", $2->node.value.i);  // Convert the node to a string using the appropriate format specifier

       char* temp = (char*) malloc(strlen("[") + strlen(node_str) + strlen("]") + strlen($4) + 1);
       strcpy(temp, "[");
       strcat(temp, node_str);
       strcat(temp, "]");
       strcat(temp, $4);

       num_expressions[top_num_expressions] = $2->node;
       top_num_expressions += 1;

       strcpy($$, temp);
} 
| { printf("yyyyyyyyyyyyyy\n");
       strcpy($$, "");; } ;


EXPRESSION : NUMEXPRESSION OPT_REL_OP_NUM_EXPR {
       printf("zzzzzzzzzzzzz\n");
       num_expressions[top_num_expressions] = $1->node;
       top_num_expressions += 1;
};

OPT_REL_OP_NUM_EXPR : REL_OP NUMEXPRESSION {
       printf("11111111111111111111\n");
       num_expressions[top_num_expressions] = $2->node;
       top_num_expressions += 1;
}
                    | { printf("11111111111111111111\n"); }
                    ;


REL_OP : LT {printf("2222222222222\n");}
       | GT {printf("2222222222222\n");}
       | LE {printf("2222222222222\n");}
       | GE {printf("2222222222222\n");}
       | EQ {printf("2222222222222\n");}
       | NEQ {printf("2222222222222\n");};

NUMEXPRESSION : TERM REC_PLUS_MINUS_TERM {
       printf("333333333333333\n");
       if ($2 != NULL) {
              char* result_type = check_operation($1->node.result, $2->node.result, $2->node.operation);

              node new_node;
              strcpy(new_node.node_before, $1->node.result);
              strcpy(new_node.node_after, $2->node.result);
              strcpy(new_node.operation, $2->node.operation);
              strcpy(new_node.result, result_type);

              scope_and_expressions* this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node = new_node;
              $$ = this_scope;
       } else {
              printf("3333333333333333\n");
              $$ = $1;
       }
};

REC_PLUS_MINUS_TERM : PLUS_OR_MINUS TERM REC_PLUS_MINUS_TERM {
       printf("44444444444444444\n");
       printf("00000\n");
       if ($3) {
              printf("7\n");
              node dsa = $3->node;
              printf("6\n");
              char * assa = dsa.result;
              printf("8\n");
              printf("%s\n", assa);
              puts($3->node.result);
              printf("1111\n");
              char* result_type = check_operation($2->node.result, $3->node.result, $3->operation);
              printf("1111\n");
              node new_node;

              strcpy(new_node.node_before, $2->node.result);
              strcpy(new_node.node_after, $3->node.result);
              strcpy(new_node.operation, $3->node.operation);
              strcpy(new_node.result, result_type);
              printf("1111\n");
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node = new_node;
              strcpy(this_scope->node.operation, $1->node.operation);
              $$ = this_scope;
       } else {
              printf("2222\n");
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node = $2->node;
              strcpy(this_scope->node.operation, $1->node.operation);
              $$ = this_scope;
       }
}
                    | { printf("ueuueueueueue\n");
                     $$ = NULL; }
                    ;
      
PLUS_OR_MINUS : PLUS {
       printf("5555555555555555\n");
                     scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                     strcpy(this_scope->node.operation, "+");
                     $$ = this_scope;
              }
              | MINUS {
                     printf("55555555555555\n");
                     scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                     strcpy(this_scope->node.operation, "-");
                     $$ = this_scope;
              };
      

TERM : UNARYEXPR REC_UNARYEXPR {
       char operation[3] = " ";
       if ($2) {
              puts($2->operation);
              char* result_type = check_operation($1->node.result, $2->node.result, $2->operation);

              node new_node;
              strcpy(new_node.node_before, $1->node.result);
              strcpy(new_node.node_after, $2->node.result);
              strcpy(new_node.operation, $2->node.operation);
              new_node.result = result_type;

              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node = new_node;
              strcpy(this_scope->operation, $2->node.operation);
              $$ = this_scope;
       } else {
              $$ = $1;
       }
};

REC_UNARYEXPR : UNARYEXPR_OP TERM {
       printf("777777777777777\n");
                     scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                     this_scope->node = $2->node;
                     strcpy(this_scope->operation, $1->node.operation);
                     $$ = this_scope;
              }
              | { printf("77777777777777777\n");
                     $$ = NULL; }
              ;


UNARYEXPR_OP : TIMES {
       printf("8888888888888\n");
                     scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                     strcpy(this_scope->node.operation, "*");
                     $$ = this_scope;
              }
             | DIVIDE {
              printf("8888888888888\n");
                     scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                     strcpy(this_scope->node.operation, "/");
                     $$ = this_scope;
              }
             | MOD {
              printf("8888888888888\n");
                     scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
                     strcpy(this_scope->node.operation, "%");
                     $$ = this_scope;
              };
          
UNARYEXPR : PLUS_OR_MINUS FACTOR {
       printf("999999999999\n");
              if (strcmp($1->node.operation, "-")) {
                     if (strcmp($2->node.result, "int") == 0) {
                            $2->node.value.i = -1 * $2->node.value.i;
                     } else if (strcmp($2->node.result, "float") == 0) {
                            $2->node.value.f = -1 * $2->node.value.f;
                     }
              }    
              //strcpy($$, $2->operation);
              //scope_and_expressions * teste = malloc(sizeof(scope_and_expressions));
              //teste = $2;
              $$ = $2;
          }
          | FACTOR {
              printf("999999999999\n");
              printf("999999999999\n");

              $$ = $1;
          };

    
FACTOR : INT_CONSTANT {
       printf("10100101010100101\n");
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node.value.i = $1;
              strcpy(this_scope->node.result,"int");
              $$ = this_scope;    
       }
       | FLOAT_CONSTANT {
              printf("10100101010100101\n");
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node.value.f = $1;
              strcpy(this_scope->node.result,"float");
              $$ = this_scope;    
       }
       | STRING_CONSTANT {
              printf("10100101010100101\n");
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              strcpy(this_scope->node.value.str, $1);
              strcpy(this_scope->node.result,"string");
              $$ = this_scope;    
       }
       | RETURN_NULL {
              printf("10100101010100101\n");
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              strcpy(this_scope->node.value.str, $1);
              strcpy(this_scope->node.result,"null");
              $$ = this_scope;    
       }
       | LVALUE {
              printf("10100101010100101\n");
              $$ = $1;
       }
       | LPAREN NUMEXPRESSION RPAREN {
              printf("10100101010100101\n");
              $$ = $2;
              
              num_expressions[top_num_expressions] = $2->node;
              top_num_expressions += 1;
       };

LVALUE : IDENT OPT_ALLOC_NUMEXP {
       printf("121212121212121212\n");
       scope_and_expressions* this_scope = malloc(sizeof(scope_and_expressions));
       printf(".......................\n");
       this_scope->node.operation = malloc(strlen($1) + strlen($2) + 1); // Allocate memory for concatenated string
       printf(".......................\n");
       strcpy(this_scope->node.operation, $1); // Copy $1 into the operation string
       printf(".......................\n");
       strcat(this_scope->node.operation, $2); // Concatenate $2 to the operation string
       printf("!!!!!!!!!!!!!!!!");
       this_scope->node.result = get_var_type($1);
       printf(".......................\n");
       $$ = this_scope;
       printf(".......................\n");
};

new_scope : {

       printf("113131313131313131\n");
       new_scope(false);
}

new_loop_scope : {
       printf("1414141414141414\n");
       new_scope(true);
}

teste : {
       printf("dasjiodjsaiojdoisae");
}

%%

char * get_var_type(char *ident) {
       printf("!!!!!!!!!!!!!!!!");
    scope scope = peek();
printf("!!!!!!!!!!!!!!!!");
    for (int i = 0; i < top; i++) {
       sst* symbol = lookup_sst_symbol(scope.symbol_table, scope.num_symbols, ident);
       if (symbol != NULL) {
              return symbol->type;
       }
    }
    printf("!!!!!!!!!!!!!!!!");
    
    char * type = "function";
    char type1[] = "function";
    int dimension = 0;
    insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, ident, type1, 1, dimension);
    return type;

   // printf("Error: Variable %s was not declared!\n", ident);
    //return NULL;

}

void new_scope(bool is_loop) {
       scope scope;
       scope.is_loop = true;
       push(scope);
       push_all_scopes(scope);
}

void show_tables() {
    int i;
    printf("Symbol Table\n");
    for (i = 0; i < top; i++) {
        print_sst_table(all_scopes[i].symbol_table, all_scopes[i].num_symbols);
    }
}
