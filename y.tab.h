/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    DEF = 258,                     /* DEF  */
    IF = 259,                      /* IF  */
    ELSE = 260,                    /* ELSE  */
    FOR = 261,                     /* FOR  */
    BREAK = 262,                   /* BREAK  */
    RETURN = 263,                  /* RETURN  */
    NEW = 264,                     /* NEW  */
    READ = 265,                    /* READ  */
    PRINT = 266,                   /* PRINT  */
    INT_KEYWORD = 267,             /* INT_KEYWORD  */
    FLOAT_KEYWORD = 268,           /* FLOAT_KEYWORD  */
    STRING_KEYWORD = 269,          /* STRING_KEYWORD  */
    RETURN_NULL = 270,             /* RETURN_NULL  */
    LBRACKETS = 271,               /* LBRACKETS  */
    RBRACKETS = 272,               /* RBRACKETS  */
    LPAREN = 273,                  /* LPAREN  */
    RPAREN = 274,                  /* RPAREN  */
    LSQRBRACKETS = 275,            /* LSQRBRACKETS  */
    RSQRBRACKETS = 276,            /* RSQRBRACKETS  */
    SEMICOLON = 277,               /* SEMICOLON  */
    COMMA = 278,                   /* COMMA  */
    PLUS = 279,                    /* PLUS  */
    MINUS = 280,                   /* MINUS  */
    TIMES = 281,                   /* TIMES  */
    DIVIDE = 282,                  /* DIVIDE  */
    MOD = 283,                     /* MOD  */
    ASSIGN = 284,                  /* ASSIGN  */
    EQ = 285,                      /* EQ  */
    NEQ = 286,                     /* NEQ  */
    GT = 287,                      /* GT  */
    LT = 288,                      /* LT  */
    GE = 289,                      /* GE  */
    LE = 290,                      /* LE  */
    IDENT = 291,                   /* IDENT  */
    INT_CONSTANT = 292,            /* INT_CONSTANT  */
    FLOAT_CONSTANT = 293,          /* FLOAT_CONSTANT  */
    STRING_CONSTANT = 294          /* STRING_CONSTANT  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define DEF 258
#define IF 259
#define ELSE 260
#define FOR 261
#define BREAK 262
#define RETURN 263
#define NEW 264
#define READ 265
#define PRINT 266
#define INT_KEYWORD 267
#define FLOAT_KEYWORD 268
#define STRING_KEYWORD 269
#define RETURN_NULL 270
#define LBRACKETS 271
#define RBRACKETS 272
#define LPAREN 273
#define RPAREN 274
#define LSQRBRACKETS 275
#define RSQRBRACKETS 276
#define SEMICOLON 277
#define COMMA 278
#define PLUS 279
#define MINUS 280
#define TIMES 281
#define DIVIDE 282
#define MOD 283
#define ASSIGN 284
#define EQ 285
#define NEQ 286
#define GT 287
#define LT 288
#define GE 289
#define LE 290
#define IDENT 291
#define INT_CONSTANT 292
#define FLOAT_CONSTANT 293
#define STRING_CONSTANT 294

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "./src/parser.y"

  int address;
  char *symbol;
  int usage_count;

#line 151 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
