/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    DEF = 258,
    IF = 259,
    ELSE = 260,
    FOR = 261,
    BREAK = 262,
    RETURN = 263,
    NEW = 264,
    READ = 265,
    PRINT = 266,
    INT_KEYWORD = 267,
    FLOAT_KEYWORD = 268,
    STRING_KEYWORD = 269,
    RETURN_NULL = 270,
    LCURLYBRACKETS = 271,
    RCURLYBRACKETS = 272,
    LPAREN = 273,
    RPAREN = 274,
    LSQRBRACKETS = 275,
    RSQRBRACKETS = 276,
    SEMICOLON = 277,
    COMMA = 278,
    PLUS = 279,
    MINUS = 280,
    TIMES = 281,
    DIVIDE = 282,
    MOD = 283,
    ASSIGN = 284,
    EQ = 285,
    NEQ = 286,
    GT = 287,
    LT = 288,
    GE = 289,
    LE = 290,
    IDENT = 291,
    INT_CONSTANT = 292,
    FLOAT_CONSTANT = 293,
    STRING_CONSTANT = 294
  };
#endif
/* Tokens.  */
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
#define LCURLYBRACKETS 271
#define RCURLYBRACKETS 272
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
#line 14 "./src/parser.y"

  int address;
  char *symbol;
  int usage_count;

#line 141 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
