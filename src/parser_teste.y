%{

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "./src/utils/syntactic_symbol_table.h"
#include "./src/utils/stack.h"

int yylex();
void yyerror(char* s);

char * get_var_type();

typedef struct {
       operation node;
       char * operation;
       char * vector;
} scope_and_expressions;

int top_num_expressions = -1
operation num_expressions[10000];

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

PROGRAM : STATEMENT { 
              scope global_scope = scopes.pop();
        }
        | FUNCLIST { 
              scope global_scope = scopes.pop();
         }
        | 
        ;
           
FUNCLIST : FUNCDEF FUNCLISTAUX;
        
FUNCLISTAUX : FUNCLIST
            | 
            ;
            
FUNCDEF : DEF IDENT LPAREN PARAMLIST RPAREN LCURLYBRACKETS STATELIST RCURLYBRACKETS { 
       // Go back to upper scope
       scopes.pop();

       // Add function declaration to this scope symbol table
       scope scope = scopes.peek();
       char type[] = "function";
       int dimension[];
       insert_new_symbol(scope.symbol_table, scope.num_symbols, $2, type, 1, dimension);
       }; 
          
PARAMLIST : DATATYPE IDENT PARAMLISTAUX {
              // Add function declaration to this scope symbol table
              scope scope = scopes.peek();
              int dimension[];
              insert_new_symbol(scope.symbol_table, scope.num_symbols, $2, $1, 1, dimension);
              }
          | 
          ;
       
PARAMLISTAUX : COMMA PARAMLIST
             | 
             ;
           
DATATYPE : INT_KEYWORD { $$ = $1; }
         | FLOAT_KEYWORD { $$ = $1; }
         | STRING_KEYWORD { $$ = $1; };
          
STATEMENT : VARDECL SEMICOLON
          | ATRIBSTAT SEMICOLON
          | PRINTSTAT SEMICOLON
          | READSTAT SEMICOLON
          | RETURNSTAT SEMICOLON
          | IFSTAT
          | FORSTAT
          | LCURLYBRACKETS STATELIST RCURLYBRACKETS {
              scopes.pop();
              }
          | BREAK SEMICOLON {
              int t = top;
              while (true) {
                  if (scopes[t].isLoop == true) {
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
       scope scope = scopes.peek();
       insert_new_symbol(scope.symbol_table, scope.num_symbols, $2, $1, 1, $3);
}
;
         
OPT_VECTOR : LSQRBRACKETS INT_CONSTANT RSQRBRACKETS OPT_VECTOR {
              int dimension[][] = {{$2}, {$4}};
              $$ = dimension;
           }
           | {       
              int dimension[] = {};
              $$ = dimension;
           }
           ;
          
ATRIBSTAT : LVALUE ASSIGN ATRIBSTAT_RIGHT;
        
ATRIBSTAT_RIGHT : FUNCCALL_OR_EXPRESSION
            | ALLOCEXPRESSION;                  

FUNCCALL_OR_EXPRESSION: PLUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            int right_node = $2.node;

                            if ($3) {
                                   result_type = check_operation($3.node, right_node, $3.operation)

                                   operation new_right_node_result;
                                   new_right_node_result.node_before = $3.node;
                                   new_right_node_result.node_after = right_node;
                                   new_right_node_result.operation = $3.operation;
                                   new_right_node_result.result = result_type;
                                   
                                   right_node = new_right_node_result;
                            }

                            if ($4) {
                                   result_type = check_operation($4.node, right_node, $4.operation)

                                   operation new_right_node_result;
                                   new_right_node_result.node_before = $4.node;
                                   new_right_node_result.node_after = right_node;
                                   new_right_node_result.operation = $4.operation;
                                   new_right_node_result.result = result_type;
                                   
                                   right_node = new_right_node_result;
                            }

                            num_expressions[top_num_expressions] = right_node;
                            top_num_expressions += 1;
                      }
                      | MINUS FACTOR REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            int right_node = $2;
                            right_node = right_node * -1

                            if ($3) {
                                   result_type = check_operation($3.node, right_node, $3.operation);

                                   operation new_right_node_result;
                                   new_right_node_result.node_before = $3.node;
                                   new_right_node_result.node_after = right_node;
                                   new_right_node_result.operation = $3.operation;
                                   new_right_node_result.result = result_type;
                                   
                                   right_node = new_right_node_result;
                            }

                            if ($4) {
                                   result_type = check_operation($4.node, right_node, $4.operation);

                                   operation new_right_node_result;
                                   new_right_node_result.node_before = $4.node;
                                   new_right_node_result.node_after = right_node;
                                   new_right_node_result.operation = $4.operation;
                                   new_right_node_result.result = result_type;
                                   
                                   right_node = new_right_node_result;
                            }

                            num_expressions[top_num_expressions] = right_node;
                            top_num_expressions += 1;
                      }
                      | INT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            operation new_node;
                            new_node.operation = $1;
                            new_node.result = 'int';

                            if ($2) {
                                   result_type = check_operation(new_node, $2.node, $2.operation);
                                   new_node.node_before = new_node;
                                   new_node.node_after = $2.node;
                                   new_node.operation = $2.operation;
                                   new_node.result = result_type;
                            }

                            if ($3) {
                                   result_type = check_operation(new_node, $3.node, $3.operation);
                                   new_node.node_before = new_node;
                                   new_node.node_after = $3.node;
                                   new_node.operation = $3.operation;
                                   new_node.result = result_type;
                            }

                            scope_and_expressions this_scope;
                            this_scope.node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | FLOAT_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            operation new_node;
                            new_node.operation = $1;
                            new_node.result = 'float';

                            if ($2) {
                                   result_type = check_operation(new_node, $2.node, $2.operation);
                                   new_node.node_before = new_node;
                                   new_node.node_after = $2.node;
                                   new_node.operation = $2.operation;
                                   new_node.result = result_type;
                            }

                            if ($3) {
                                   result_type = check_operation(new_node, $3.node, $3.operation);
                                   new_node.node_before = new_node;
                                   new_node.node_after = $3.node;
                                   new_node.operation = $3.operation;
                                   new_node.result = result_type;
                            }

                            scope_and_expressions this_scope;
                            this_scope.node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | STRING_CONSTANT REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            operation new_node;
                            new_node.operation = $1;
                            new_node.result = 'string';

                            if ($2) {
                                   result_type = check_operation(new_node, $2.node, $2.operation);
                                   new_node.node_before = new_node;
                                   new_node.node_after = $2.node;
                                   new_node.operation = $2.operation;
                                   new_node.result = result_type;
                            }

                            if ($3) {
                                   result_type = check_operation(new_node, $3.node, $3.operation);
                                   new_node.node_before = new_node;
                                   new_node.node_after = $3.node;
                                   new_node.operation = $3.operation;
                                   new_node.result = result_type;
                            }

                            scope_and_expressions this_scope;
                            this_scope.node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | RETURN_NULL REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR
                      | LPAREN NUMEXPRESSION RPAREN REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
                            operation new_node;
                            new_node = $2.node;

                            if ($4) {
                                   result_type = check_operation(new_node, $4.node, $4.operation);
                                   new_node.node_before = new_node;
                                   new_node.node_after = $4.node;
                                   new_node.operation = $4.operation;
                                   new_node.result = result_type;
                            }

                            if ($5) {
                                   result_type = check_operation(new_node, $5.node, $5.operation);
                                   new_node.node_before = new_node;
                                   new_node.node_after = $5.node;
                                   new_node.operation = $5.operation;
                                   new_node.result = result_type;
                            }

                            scope_and_expressions this_scope;
                            this_scope.node = new_node;
                            $$ = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
                      | IDENT FOLLOW_IDENT {
                            operation new_node;
                            new_node.operation = $1;
                            new_node.result = get_var_type($1);

                            if ($2 == None || $2.node == None) {
                                   return;
                            }
                            
                            if ($2) {
                                   node.operation += $2.vector; //??????
                                   result_type = check_operation(new_node, $2.node, $2.operation);

                                   new_node.node_before = new_node;
                                   new_node.node_after = $2.node;
                                   new_node.operation = $2.operation;
                                   new_node.result = result_type;

                                   num_expressions[top_num_expressions] = new_node;
                                   top_num_expressions += 1;
                            }
                      };

FOLLOW_IDENT: OPT_ALLOC_NUMEXP REC_UNARYEXPR REC_PLUS_MINUS_TERM OPT_REL_OP_NUM_EXPR {
            operation node = None;
            char * operation = '';

            if ($2) {
              node = $2.node;
              operation = $2.operation;
            }

            if ($3) {
              if (node == None) {
                     node = $3.node;
                     operation = $3.operation;
              } else {
                     result_type = check_operation(node, $3.node, $3.operation);

                     operation new_node;
                     new_node.node_before = node;
                     new_node.node_after = $3.node;
                     new_node.operation = $3.operation;
                     new_node.result = result_type;
              }
            }

            scope_and_expressions this_scope;
            this_scope.node = new_node;
            this_scope.operation = operation;
            this_scope.vector = $1;
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
             
IFSTAT : IF LPAREN EXPRESSION RPAREN STATEMENT OPT_ELSE { scopes.pop(); };
           
OPT_ELSE : ELSE STATEMENT { scopes.pop(); };
         | 
         ;
            
FORSTAT : FOR LPAREN ATRIBSTAT SEMICOLON EXPRESSION SEMICOLON ATRIBSTAT RPAREN STATEMENT { scopes.pop(); };

STATELIST : STATEMENT OPT_STATELIST;
      
OPT_STATELIST : STATELIST
              | 
              ;
    
ALLOCEXPRESSION : NEW DATATYPE LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP {
       num_expressions[top_num_expressions] = $4.node;
       top_num_expressions += 1;
};
   
OPT_ALLOC_NUMEXP : LSQRBRACKETS NUMEXPRESSION RSQRBRACKETS OPT_ALLOC_NUMEXP {
       char 
       $$ = '[' + str($2) + ']' + $4 //?????????????????

       num_expressions[top_num_expressions] = $2.node;
       top_num_expressions += 1;
}
                 | { $$ = '' }
                 ;
         
EXPRESSION : NUMEXPRESSION OPT_REL_OP_NUM_EXPR {
       num_expressions[top_num_expressions] = $1.node;
       top_num_expressions += 1;
};

OPT_REL_OP_NUM_EXPR : REL_OP NUMEXPRESSION {
       num_expressions[top_num_expressions] = $2.node;
       top_num_expressions += 1;
}
                    | 
                    ;
             
REL_OP : LT
       | GT
       | LE
       | GE
       | EQ
       | NEQ;
      
NUMEXPRESSION : TERM REC_PLUS_MINUS_TERM {
       if ($2 == None) {
              $$ = $1;
       } else {
              result_type = check_operation($1.node, $2.node, $2.operation);

              operation new_node;
              new_node.node_before = $1.node;
              new_node.node_after = $2.node;
              new_node.operation = $2.operation;
              new_node.result = result_type;

              scope_and_expressions this_scope;
              this_scope.node = new_node;
              $$ = this_scope;
       }
};

REC_PLUS_MINUS_TERM : PLUS_OR_MINUS TERM REC_PLUS_MINUS_TERM {
       if ($3) {
              result_type = check_operation($2.node, $3.node, $3.operation);

              operation new_node;
              new_node.node_before = $2.node;
              new_node.node_after = $3.node;
              new_node.operation = $3.operation;
              new_node.result = result_type;

              scope_and_expressions this_scope;
              this_scope.node = new_node;
              this_scope.operation = $1.operation;
              $$ = this_scope;
       } else {
              scope_and_expressions this_scope;
              this_scope.node = $2.node;
              this_scope.operation = $1.operation;
              $$ = this_scope;
       }
}
                    | { $$ = None; }
                    ;
                      
      
PLUS_OR_MINUS : PLUS {
                     scope_and_expressions this_scope;
                     this_scope.operation = $1;
                     $$ = this_scope;
              }
              | MINUS {
                     scope_and_expressions this_scope;
                     this_scope.operation = $1;
                     $$ = this_scope;
              };
               
TERM : UNARYEXPR REC_UNARYEXPR {
       if ($2) {
              result_type = check_operation($1.node, $2.node, $2.operation);

              operation new_node;
              new_node.node_before = $1.node;
              new_node.node_after = $2.node;
              new_node.operation = $2.operation;
              new_node.result = result_type;

              scope_and_expressions this_scope;
              this_scope.node = new_node;
              this_scope.operation = $2.operation;
              $$ = this_scope;
       } else {
              scope_and_expressions this_scope;
              this_scope.node = $1.node;
              $$ = this_scope;
       }
};
      
REC_UNARYEXPR : UNARYEXPR_OP TERM {
                     scope_and_expressions this_scope;
                     this_scope.node = $2.node;
                     this_scope.operation = $1.operation;
                     $$ = this_scope;
              }
              | { $$ = NULL; }
              ;
       
UNARYEXPR_OP : TIMES {
                     scope_and_expressions this_scope;
                     this_scope.operation = $1;
                     $$ = this_scope;
              }
             | DIVIDE {
                     scope_and_expressions this_scope;
                     this_scope.operation = $1;
                     $$ = this_scope;
              }
             | MOD {
                     scope_and_expressions this_scope;
                     this_scope.operation = $1;
                     $$ = this_scope;
              };
          
UNARYEXPR : PLUS_OR_MINUS FACTOR {
              if ($1.operation == '-') {
                     $2.node.value *= -1;
              }    
              $$ = $2;
          }
          | FACTOR {
              $$ = $1;
          };
             
FACTOR : INT_CONSTANT {
              scope_and_expressions this_scope;
              this_scope.node.operator = $1;
              this_scope.node.result = 'int'
              $$ = this_scope;    
       }
       | FLOAT_CONSTANT {
              scope_and_expressions this_scope;
              this_scope.node.operator = $1;
              this_scope.node.result = 'float'
              $$ = this_scope;    
       }
       | STRING_CONSTANT {
              scope_and_expressions this_scope;
              this_scope.node.operator = $1;
              this_scope.node.result = 'string'
              $$ = this_scope;    
       }
       | RETURN_NULL {
              scope_and_expressions this_scope;
              this_scope.node.operator = $1;
              this_scope.node.result = 'null'
              $$ = this_scope;    
       }
       | LVALUE {
              $$ = $1;
       }
       | LPAREN NUMEXPRESSION RPAREN {
              $$ = $2;
              
              num_expressions[top_num_expressions] = $2.node;
              top_num_expressions += 1;
       };
             
LVALUE : IDENT OPT_ALLOC_NUMEXP {
       scope_and_expressions this_scope;
       this_scope.node.operator = $1 + $2; //??????????????
       this_scope.node.result = get_var_type($1);
       $$ = this_scope;   
};

%%

char * get_var_type(char *ident) {
    scope scope = scopes.peek();

    for (int i = 0; i < top; i++) {
       sst* symbol = lookup_symbol(scope.symbol_table, scope.num_symbols, ident);
       if (symbol != NULL) {
              return symbol.type;
       }
    }
    printf("Error: Variable %s was not declared!\n", ident);
    return NULL;
}