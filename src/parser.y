%{

#include <stdlib.h>
#include <stdio.h>
#include "./src/utils/recursive_list.h"
#include "./src/utils/syntactic_symbol_table.h"
#include "./src/utils/types.h"
#include "./src/utils/stack.h"

int yylex();
void yyerror(char* s);

char * get_var_type();

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
%type <recursive_list> OPT_VECTOR
%type <symbol> ATRIBSTAT
%type <symbol> ATRIBSTAT_RIGHT
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
%type <symbol> UNARYEXPR
%type <scope_and_expressions> FACTOR
%type <scope_and_expressions> LVALUE
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
       recursive_list * dimension;
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, $2, type, 1, dimension);
}; 
          
          
PARAMLIST : DATATYPE IDENT PARAMLISTAUX {
       // Add function declaration to this scope symbol table
       scope scope = peek();
       recursive_list * dimension;
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, $2, $1, 1, dimension);
}
          | 
          ;
       
PARAMLISTAUX : COMMA PARAMLIST
             | 
             ;
           
DATATYPE : INT_KEYWORD { strcpy($$, $1); }
         | FLOAT_KEYWORD { strcpy($$, $1); }
         | STRING_KEYWORD { strcpy($$, $1); };
          
STATEMENT : VARDECL SEMICOLON
          | ATRIBSTAT SEMICOLON
          | PRINTSTAT SEMICOLON
          | READSTAT SEMICOLON
          | RETURNSTAT SEMICOLON
          | IFSTAT
          | FORSTAT
          | LCURLYBRACKETS STATELIST RCURLYBRACKETS {
              //scopes.pop()
              pop();
          }
          | BREAK SEMICOLON {
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
          | SEMICOLON;
            
VARDECL : DATATYPE IDENT OPT_VECTOR {
       scope scope = peek();
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, $2, $1, 1, $3);
};

//use recursive list here, in the opt vector return     
OPT_VECTOR : LSQRBRACKETS INT_CONSTANT RSQRBRACKETS OPT_VECTOR {
              recursive_list * dimension;
              dimension->list.value = $2;
              dimension->list.list = $4;
              $$ = dimension;
           }
           | {
              recursive_list * dimension;
              $$ = dimension;
           }
           ;
          
ATRIBSTAT : LVALUE ASSIGN ATRIBSTAT_RIGHT;
        
ATRIBSTAT_RIGHT : FUNCCALL_OR_EXPRESSION
            | ALLOCEXPRESSION;                  

FUNCCALL_OR_EXPRESSION: PLUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            node right_node = $2->node;

                            if ($3 != NULL) {
                                   char * result_type = check_operation($3->node.result, right_node.result, $3->operation);
                                   node new_right_node_result = {$3->node.result, right_node.result, $3->operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            if ($4 != NULL) {
                                   char * result_type = check_operation($4->node.result, right_node.result, $4->operation);
                                   node new_right_node_result = {$4->node.result, right_node.result, $4->operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            num_expressions[top_num_expressions] = right_node;
                            top_num_expressions += 1;
                      }
                      | MINUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            node right_node = $2->node;
                            right_node.value.i *= -1;
                            right_node.value.f *= -1;

                            if ($3 != NULL) {
                                   char * result_type = check_operation($3->node.result, right_node.result, $3->operation);
                                   node new_right_node_result = {$3->node.result, right_node.result, $3->operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            if ($4 != NULL) {
                                   char * result_type = check_operation($4->node.result, right_node.result, $4->operation);
                                   node new_right_node_result = {$4->node.result, right_node.result, $4->operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            num_expressions[top_num_expressions] = right_node;
                            top_num_expressions += 1;
                      }
                      | INT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            node new_node;
                            new_node.value.i = $1;
                            new_node.result = "int";

                            if ($2 != NULL) {
                                   char * result_type = check_operation(new_node.result, $2->node.result, $2->operation);
                                   node new_right_node_result = {new_node.result, $2->node.result, $2->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ($3 != NULL) {
                                   char * result_type = check_operation(new_node.result, $3->node.result, $3->operation);
                                   node new_right_node_result = {new_node.result, $3->node.result, $3->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope;
                            this_scope->node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | FLOAT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            node new_node;
                            new_node.value.f = $1;
                            new_node.result = "float";

                            if ($2 != NULL) {
                                   char * result_type = check_operation(new_node.result, $2->node.result, $2->operation);
                                   node new_right_node_result = {new_node.result, $2->node.result, $2->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ($3 != NULL) {
                                   char * result_type = check_operation(new_node.result, $3->node.result, $3->operation);
                                   node new_right_node_result = {new_node.result, $3->node.result, $3->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope;
                            this_scope->node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | STRING_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            node new_node;
                            strcpy(new_node.value.str, $1);
                            new_node.result = "string";

                            if ($2 != NULL) {
                                   char * result_type = check_operation(new_node.result, $2->node.result, $2->operation);
                                   node new_right_node_result = {new_node.result, $2->node.result, $2->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ($3 != NULL) {
                                   char * result_type = check_operation(new_node.result, $3->node.result, $3->operation);
                                   node new_right_node_result = {new_node.result, $3->node.result, $3->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope;
                            this_scope->node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | RETURN_NULL REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
                      | LPAREN NUMEXPRESSION RPAREN REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            node new_node;
                            new_node = $2->node;

                            if ($4 != NULL) {
                                   char * result_type = check_operation(new_node.result, $4->node.result, $4->operation);
                                   node new_right_node_result = {new_node.result, $4->node.result, $4->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ($5 != NULL) {
                                   char * result_type = check_operation(new_node.result, $5->node.result, $5->operation);
                                   node new_right_node_result = {new_node.result, $5->node.result, $5->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope;
                            this_scope->node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | IDENT FOLLOW_IDENT {
                            node new_node;
                            new_node.operator = $1;
                            new_node.result = get_var_type($1);

                            if ($2 != NULL && $2->node.operator != NULL) {
                                   new_node.operator = $2->vector;

                                   char * result_type = check_operation(new_node.result, $2->node.result, $2->operation);
                                   node new_right_node_result = {new_node.result, $2->node.result, $2->operation, result_type};
                                   new_node = new_right_node_result;

                                   num_expressions[top_num_expressions] = new_node;
                                   top_num_expressions += 1;
                            }


                      };

FOLLOW_IDENT: OPT_ALLOC_NUMEXP REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
              node new_node;
              char * operation = "";

              if ($3 != NULL) {
                     if ($2 != NULL) {
                            new_node = $2->node;
                            operation = $2->operation;
                     } else {
                            new_node = $3->node;
                            operation = $3->operation;
                     }

                     char * result_type = check_operation(new_node.result, $3->node.result, $3->operation);
                     node new_right_node_result = {new_node.result, $3->node.result, $3->operation, result_type};
                     new_node = new_right_node_result;
              }

              scope_and_expressions * this_scope;
              this_scope->node = new_node;
              this_scope->operation = operation;
              this_scope->vector = $1;
              $$ = this_scope;
            }
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
             
IFSTAT : IF LPAREN EXPRESSION RPAREN STATEMENT OPT_ELSE { pop(); };
           
OPT_ELSE : ELSE STATEMENT { pop(); }
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

char * get_var_type(char *ident) {
    scope scope = peek();

    for (int i = 0; i < top; i++) {
       sst* symbol = lookup_sst_symbol(scope.symbol_table, scope.num_symbols, ident);
       if (symbol != NULL) {
              return symbol->type;
       }
    }
    printf("Error: Variable %s was not declared!\n", ident);
    return NULL;
}