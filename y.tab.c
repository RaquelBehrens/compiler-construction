/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "./src/parser.y"


#include <stdlib.h>
#include <stdio.h>
#include "./src/utils/recursive_list.h"
#include "./src/utils/syntactic_symbol_table.h"
#include "./src/utils/types.h"
#include "./src/utils/stack.h"
#include <string.h>

int yylex();
void yyerror(char* s);

char * get_var_type();
void new_scope(bool is_loop);

typedef struct scope_and_expressions {
       char * operation;
       char * vector;
       node node;
} scope_and_expressions;

int top_num_expressions = -1;
node num_expressions[10000];


#line 97 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
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
#line 28 "./src/parser.y"

  int address;
  char symbol[50];
  int usage_count;
  int integer_return;
  float float_return;
  struct recursive_list *recursive_list;
  struct node *node;
  struct scope_and_expressions *scope_and_expressions;

#line 238 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  50
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   202

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  40
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  41
/* YYNRULES -- Number of rules.  */
#define YYNRULES  89
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  178

#define YYUNDEFTOK  2
#define YYMAXUTOK   294


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   128,   128,   131,   134,   137,   139,   140,   143,   157,
     163,   166,   167,   170,   171,   172,   174,   175,   176,   177,
     178,   179,   180,   181,   185,   197,   199,   205,   211,   217,
     219,   220,   222,   240,   260,   284,   308,   332,   333,   356,
     373,   397,   399,   400,   403,   404,   407,   409,   411,   413,
     415,   416,   419,   421,   423,   424,   427,   432,   447,   450,
     455,   459,   463,   464,   465,   466,   467,   468,   470,   488,
     509,   512,   517,   524,   548,   554,   558,   563,   568,   574,
     582,   587,   593,   599,   605,   611,   614,   621,   630,   634
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "DEF", "IF", "ELSE", "FOR", "BREAK",
  "RETURN", "NEW", "READ", "PRINT", "INT_KEYWORD", "FLOAT_KEYWORD",
  "STRING_KEYWORD", "RETURN_NULL", "LCURLYBRACKETS", "RCURLYBRACKETS",
  "LPAREN", "RPAREN", "LSQRBRACKETS", "RSQRBRACKETS", "SEMICOLON", "COMMA",
  "PLUS", "MINUS", "TIMES", "DIVIDE", "MOD", "ASSIGN", "EQ", "NEQ", "GT",
  "LT", "GE", "LE", "IDENT", "INT_CONSTANT", "FLOAT_CONSTANT",
  "STRING_CONSTANT", "$accept", "PROGRAM", "FUNCLIST", "FUNCLISTAUX",
  "FUNCDEF", "PARAMLIST", "PARAMLISTAUX", "DATATYPE", "STATEMENT",
  "VARDECL", "OPT_VECTOR", "ATRIBSTAT", "ATRIBSTAT_RIGHT",
  "FUNCCALL_OR_EXPRESSION", "FOLLOW_IDENT", "PARAMLISTCALL",
  "PARAMLISTCALLAUX", "PRINTSTAT", "READSTAT", "RETURNSTAT", "IFSTAT",
  "OPT_ELSE", "FORSTAT", "STATELIST", "OPT_STATELIST", "ALLOCEXPRESSION",
  "OPT_ALLOC_NUMEXP", "EXPRESSION", "OPT_REL_OP_NUM_EXPR", "REL_OP",
  "NUMEXPRESSION", "REC_PLUS_MINUS_TERM", "PLUS_OR_MINUS", "TERM",
  "REC_UNARYEXPR", "UNARYEXPR_OP", "UNARYEXPR", "FACTOR", "LVALUE",
  "new_scope", "new_loop_scope", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294
};
# endif

#define YYPACT_NINF (-108)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     120,    -8,    -1,    22,    19,  -108,    20,   163,  -108,  -108,
    -108,   153,  -108,    37,    63,  -108,    61,    31,  -108,    48,
      49,    56,    58,    65,  -108,  -108,    59,    67,   163,    20,
    -108,  -108,  -108,   163,  -108,  -108,  -108,  -108,  -108,  -108,
      75,    -2,    -3,    23,  -108,  -108,   153,    73,   163,  -108,
    -108,  -108,  -108,  -108,    71,  -108,  -108,  -108,  -108,  -108,
    -108,   159,    47,    74,    70,    77,  -108,  -108,  -108,  -108,
    -108,  -108,  -108,   163,  -108,  -108,   163,  -108,  -108,  -108,
    -108,   163,  -108,  -108,  -108,    76,    62,  -108,    47,    23,
     163,    -2,    -2,    57,    23,    23,    23,  -108,  -108,  -108,
      81,    78,   153,   163,  -108,  -108,    -3,  -108,  -108,    37,
      91,    93,    -3,    96,    23,    23,    80,  -108,    23,    -3,
      -3,    -3,   101,    97,   114,    99,  -108,  -108,    71,   163,
      75,    23,    -3,    -3,   102,   103,    -3,    75,    75,    75,
     153,    47,  -108,   153,  -108,    20,  -108,   116,  -108,    -3,
      75,    75,    80,  -108,  -108,    75,  -108,  -108,  -108,   118,
    -108,  -108,  -108,   119,    37,    75,  -108,  -108,  -108,  -108,
    -108,  -108,   153,  -108,  -108,  -108,  -108,  -108
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       4,     0,     0,     0,     0,    48,     0,     0,    13,    14,
      15,     0,    25,    58,     0,    88,     7,     0,    88,     0,
       0,     0,     0,     0,    21,    22,     0,     0,     0,     0,
      24,    47,    84,     0,    71,    72,    81,    82,    83,    46,
      61,     0,    70,    75,    80,    85,    55,     0,     0,    87,
       1,     3,     6,     5,    28,     2,    16,    17,    18,    19,
      20,     0,    10,     0,     0,     0,    66,    67,    63,    62,
      65,    64,    59,     0,    79,    68,     0,    76,    77,    78,
      73,     0,    54,    53,    88,     0,     0,    26,     0,    75,
       0,     0,     0,    58,    75,    75,    75,    29,    30,    31,
       0,     0,     0,     0,    86,    60,    70,    74,    23,    58,
       0,     0,    70,     0,    75,    75,    43,    39,    75,    70,
      70,    70,     0,    12,    51,     0,    69,    57,    28,     0,
      61,    75,    70,    70,    45,     0,    70,    61,    61,    61,
       0,    10,     9,     0,    88,     0,    27,     0,    37,    70,
      61,    61,    43,    42,    41,    61,    34,    35,    36,     0,
      11,    88,    49,     0,    58,    61,    32,    33,    44,    40,
      88,    50,     0,    56,    38,     8,    89,    52
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
    -108,  -108,   123,  -108,  -108,     6,  -108,   -55,     1,  -108,
      13,   -27,  -108,  -108,  -108,    -4,  -108,  -108,  -108,  -108,
    -108,  -108,  -108,   -36,  -108,  -108,   -85,   -19,  -107,  -108,
     -28,   -94,   -38,   -62,   -42,  -108,  -108,   -26,     0,   -15,
    -108
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    14,    15,    53,    16,   100,   142,    17,    46,    19,
      87,    20,    97,    98,   117,   135,   153,    21,    22,    23,
      24,   144,    25,    47,    83,    99,    49,    39,    72,    73,
      40,    75,    41,    42,    80,    81,    43,    44,    45,    51,
     177
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      26,    18,    64,    55,    76,    65,    31,   101,   118,    63,
      82,    26,   126,    32,   106,    74,    33,    28,   130,   107,
      85,    34,    35,   148,   127,   137,   138,   139,    27,    26,
     156,   157,   158,   111,    13,    36,    37,    38,   150,   151,
      29,    30,   155,   166,   167,   105,    26,   112,   169,    77,
      78,    79,   119,   120,   121,   165,    13,    48,   174,     8,
       9,    10,   113,    50,     1,   114,   115,    54,    76,   108,
      56,    57,   132,   133,    76,   116,   136,    48,    58,   173,
      59,    76,    76,    76,   125,    62,   101,    60,    61,   149,
      84,    86,   103,   102,    76,    76,   104,   109,    76,   110,
     122,   147,    26,   124,   159,    66,    67,    68,    69,    70,
      71,    76,   128,   129,   123,   131,   134,   140,   163,   143,
     141,   145,   154,     1,     2,   152,     3,     4,     5,   162,
       6,     7,     8,     9,    10,   170,    11,   164,   172,    52,
      26,   146,    12,    26,   161,    26,   171,   160,   168,     0,
       0,     0,     0,     0,     0,   175,    13,     2,     0,     3,
       4,     5,     0,     6,     7,     8,     9,    10,    88,    11,
       0,     0,    26,   176,    89,    12,     0,    90,    32,     0,
       0,    33,     0,    91,    92,     0,     0,    34,    35,    13,
       0,     0,     0,     0,     0,    93,    94,    95,    96,    13,
      36,    37,    38
};

static const yytype_int16 yycheck[] =
{
       0,     0,    29,    18,    42,    33,     6,    62,    93,    28,
      46,    11,   106,    15,    76,    41,    18,    18,   112,    81,
      48,    24,    25,   130,   109,   119,   120,   121,    36,    29,
     137,   138,   139,    88,    36,    37,    38,    39,   132,   133,
      18,    22,   136,   150,   151,    73,    46,    89,   155,    26,
      27,    28,    94,    95,    96,   149,    36,    20,   165,    12,
      13,    14,    90,     0,     3,    91,    92,    36,   106,    84,
      22,    22,   114,   115,   112,    18,   118,    20,    22,   164,
      22,   119,   120,   121,   103,    18,   141,    22,    29,   131,
      17,    20,    22,    19,   132,   133,    19,    21,   136,    37,
      19,   129,   102,   102,   140,    30,    31,    32,    33,    34,
      35,   149,    21,    20,    36,    19,    36,    16,   145,     5,
      23,    22,    19,     3,     4,    23,     6,     7,     8,   144,
      10,    11,    12,    13,    14,    17,    16,    21,    19,    16,
     140,   128,    22,   143,   143,   145,   161,   141,   152,    -1,
      -1,    -1,    -1,    -1,    -1,   170,    36,     4,    -1,     6,
       7,     8,    -1,    10,    11,    12,    13,    14,     9,    16,
      -1,    -1,   172,   172,    15,    22,    -1,    18,    15,    -1,
      -1,    18,    -1,    24,    25,    -1,    -1,    24,    25,    36,
      -1,    -1,    -1,    -1,    -1,    36,    37,    38,    39,    36,
      37,    38,    39
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     3,     4,     6,     7,     8,    10,    11,    12,    13,
      14,    16,    22,    36,    41,    42,    44,    47,    48,    49,
      51,    57,    58,    59,    60,    62,    78,    36,    18,    18,
      22,    78,    15,    18,    24,    25,    37,    38,    39,    67,
      70,    72,    73,    76,    77,    78,    48,    63,    20,    66,
       0,    79,    42,    43,    36,    79,    22,    22,    22,    22,
      22,    29,    18,    67,    51,    70,    30,    31,    32,    33,
      34,    35,    68,    69,    77,    71,    72,    26,    27,    28,
      74,    75,    63,    64,    17,    70,    20,    50,     9,    15,
      18,    24,    25,    36,    37,    38,    39,    52,    53,    65,
      45,    47,    19,    22,    19,    70,    73,    73,    79,    21,
      37,    47,    74,    70,    77,    77,    18,    54,    66,    74,
      74,    74,    19,    36,    48,    67,    71,    66,    21,    20,
      71,    19,    74,    74,    36,    55,    74,    71,    71,    71,
      16,    23,    46,     5,    61,    22,    50,    70,    68,    74,
      71,    71,    23,    56,    19,    71,    68,    68,    68,    63,
      45,    48,    79,    51,    21,    71,    68,    68,    55,    68,
      17,    79,    19,    66,    68,    79,    48,    80
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    40,    41,    41,    41,    42,    43,    43,    44,    45,
      45,    46,    46,    47,    47,    47,    48,    48,    48,    48,
      48,    48,    48,    48,    48,    48,    49,    50,    50,    51,
      52,    52,    53,    53,    53,    53,    53,    53,    53,    53,
      54,    54,    55,    55,    56,    56,    57,    58,    59,    60,
      61,    61,    62,    63,    64,    64,    65,    66,    66,    67,
      68,    68,    69,    69,    69,    69,    69,    69,    70,    71,
      71,    72,    72,    73,    74,    74,    75,    75,    75,    76,
      76,    77,    77,    77,    77,    77,    77,    78,    79,    80
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     2,     2,     0,     2,     1,     0,     9,     3,
       0,     2,     0,     1,     1,     1,     2,     2,     2,     2,
       2,     1,     1,     4,     2,     1,     3,     4,     0,     3,
       1,     1,     5,     5,     4,     4,     4,     4,     6,     2,
       4,     3,     2,     0,     2,     0,     2,     2,     1,     7,
       3,     0,    10,     2,     1,     0,     6,     4,     0,     2,
       2,     0,     1,     1,     1,     1,     1,     1,     2,     3,
       0,     1,     1,     2,     2,     0,     1,     1,     1,     2,
       1,     1,     1,     1,     1,     1,     3,     2,     0,     0
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 128 "./src/parser.y"
                              {
              pop();
        }
#line 1546 "y.tab.c"
    break;

  case 3:
#line 131 "./src/parser.y"
                             {
              pop();
        }
#line 1554 "y.tab.c"
    break;

  case 4:
#line 134 "./src/parser.y"
          { /*empty rule*/ }
#line 1560 "y.tab.c"
    break;

  case 7:
#line 140 "./src/parser.y"
              { /*empty rule*/ }
#line 1566 "y.tab.c"
    break;

  case 8:
#line 143 "./src/parser.y"
                                                                                              { 
       // Go back to upper scope
       // scopes.pop()
       pop();

       // Add function declaration to this scope symbol table
       //scope scope = scopes.peek();
       scope scope = peek();
       char type[9] = "function";
       recursive_list * dimension;
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, (yyvsp[-7].symbol), type, 1, dimension);
}
#line 1583 "y.tab.c"
    break;

  case 9:
#line 157 "./src/parser.y"
                                        {
       // Add function declaration to this scope symbol table
       scope scope = peek();
       recursive_list * dimension;
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, (yyvsp[-1].symbol), (yyvsp[-2].symbol), 1, dimension);
}
#line 1594 "y.tab.c"
    break;

  case 10:
#line 163 "./src/parser.y"
            { /*empty rule*/ }
#line 1600 "y.tab.c"
    break;

  case 12:
#line 167 "./src/parser.y"
               { /*empty rule*/ }
#line 1606 "y.tab.c"
    break;

  case 13:
#line 170 "./src/parser.y"
                       { strcpy((yyval.symbol), (yyvsp[0].symbol)); }
#line 1612 "y.tab.c"
    break;

  case 14:
#line 171 "./src/parser.y"
                         { strcpy((yyval.symbol), (yyvsp[0].symbol)); }
#line 1618 "y.tab.c"
    break;

  case 15:
#line 172 "./src/parser.y"
                          { strcpy((yyval.symbol), (yyvsp[0].symbol)); }
#line 1624 "y.tab.c"
    break;

  case 23:
#line 181 "./src/parser.y"
                                                              {
              //scopes.pop()
              pop();
          }
#line 1633 "y.tab.c"
    break;

  case 24:
#line 185 "./src/parser.y"
                            {
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
#line 1650 "y.tab.c"
    break;

  case 26:
#line 199 "./src/parser.y"
                                    {
       scope scope = peek();
       insert_new_sst_symbol(scope.symbol_table, scope.num_symbols, (yyvsp[-1].symbol), (yyvsp[-2].symbol), 1, (yyvsp[0].recursive_list));
}
#line 1659 "y.tab.c"
    break;

  case 27:
#line 205 "./src/parser.y"
                                                               {
              recursive_list * dimension;
              dimension->list.value = (yyvsp[-2].integer_return);
              dimension->list.list = (yyvsp[0].recursive_list);
              (yyval.recursive_list) = dimension;
           }
#line 1670 "y.tab.c"
    break;

  case 28:
#line 211 "./src/parser.y"
             {
              recursive_list * dimension;
              (yyval.recursive_list) = dimension;
           }
#line 1679 "y.tab.c"
    break;

  case 29:
#line 217 "./src/parser.y"
                                          {}
#line 1685 "y.tab.c"
    break;

  case 32:
#line 222 "./src/parser.y"
                                                                                          {
                            node right_node = (yyvsp[-3].scope_and_expressions)->node;

                            if ((yyvsp[-2].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation((yyvsp[-2].scope_and_expressions)->node.result, right_node.result, (yyvsp[-2].scope_and_expressions)->operation);
                                   node new_right_node_result = {(yyvsp[-2].scope_and_expressions)->node.result, right_node.result, (yyvsp[-2].scope_and_expressions)->operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            if ((yyvsp[-1].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation((yyvsp[-1].scope_and_expressions)->node.result, right_node.result, (yyvsp[-1].scope_and_expressions)->operation);
                                   node new_right_node_result = {(yyvsp[-1].scope_and_expressions)->node.result, right_node.result, (yyvsp[-1].scope_and_expressions)->operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            num_expressions[top_num_expressions] = right_node;
                            top_num_expressions += 1;
                      }
#line 1708 "y.tab.c"
    break;

  case 33:
#line 240 "./src/parser.y"
                                                                                           {
                            node right_node = (yyvsp[-3].scope_and_expressions)->node;
                            right_node.value.i *= -1;
                            right_node.value.f *= -1;

                            if ((yyvsp[-2].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation((yyvsp[-2].scope_and_expressions)->node.result, right_node.result, (yyvsp[-2].scope_and_expressions)->operation);
                                   node new_right_node_result = {(yyvsp[-2].scope_and_expressions)->node.result, right_node.result, (yyvsp[-2].scope_and_expressions)->operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            if ((yyvsp[-1].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation((yyvsp[-1].scope_and_expressions)->node.result, right_node.result, (yyvsp[-1].scope_and_expressions)->operation);
                                   node new_right_node_result = {(yyvsp[-1].scope_and_expressions)->node.result, right_node.result, (yyvsp[-1].scope_and_expressions)->operation, result_type};
                                   right_node = new_right_node_result;
                            }

                            num_expressions[top_num_expressions] = right_node;
                            top_num_expressions += 1;
                      }
#line 1733 "y.tab.c"
    break;

  case 34:
#line 260 "./src/parser.y"
                                                                                           {
                            node new_node;
                            new_node.value.i = (yyvsp[-3].integer_return);
                            new_node.result = "int";

                            if ((yyvsp[-2].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation(new_node.result, (yyvsp[-2].scope_and_expressions)->node.result, (yyvsp[-2].scope_and_expressions)->operation);
                                   node new_right_node_result = {new_node.result, (yyvsp[-2].scope_and_expressions)->node.result, (yyvsp[-2].scope_and_expressions)->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ((yyvsp[-1].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation(new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation);
                                   node new_right_node_result = {new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope;
                            this_scope->node = new_node;
                            (yyval.scope_and_expressions) = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
#line 1762 "y.tab.c"
    break;

  case 35:
#line 284 "./src/parser.y"
                                                                                             {
                            node new_node;
                            new_node.value.f = (yyvsp[-3].float_return);
                            new_node.result = "float";

                            if ((yyvsp[-2].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation(new_node.result, (yyvsp[-2].scope_and_expressions)->node.result, (yyvsp[-2].scope_and_expressions)->operation);
                                   node new_right_node_result = {new_node.result, (yyvsp[-2].scope_and_expressions)->node.result, (yyvsp[-2].scope_and_expressions)->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ((yyvsp[-1].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation(new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation);
                                   node new_right_node_result = {new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope;
                            this_scope->node = new_node;
                            (yyval.scope_and_expressions) = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
#line 1791 "y.tab.c"
    break;

  case 36:
#line 308 "./src/parser.y"
                                                                                              {
                            node new_node;
                            strcpy(new_node.value.str, (yyvsp[-3].symbol));
                            new_node.result = "string";

                            if ((yyvsp[-2].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation(new_node.result, (yyvsp[-2].scope_and_expressions)->node.result, (yyvsp[-2].scope_and_expressions)->operation);
                                   node new_right_node_result = {new_node.result, (yyvsp[-2].scope_and_expressions)->node.result, (yyvsp[-2].scope_and_expressions)->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ((yyvsp[-1].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation(new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation);
                                   node new_right_node_result = {new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope;
                            this_scope->node = new_node;
                            (yyval.scope_and_expressions) = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
#line 1820 "y.tab.c"
    break;

  case 37:
#line 332 "./src/parser.y"
                                                                                          {}
#line 1826 "y.tab.c"
    break;

  case 38:
#line 333 "./src/parser.y"
                                                                                                          {
                            node new_node;
                            new_node = (yyvsp[-4].scope_and_expressions)->node;

                            if ((yyvsp[-2].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation(new_node.result, (yyvsp[-2].scope_and_expressions)->node.result, (yyvsp[-2].scope_and_expressions)->operation);
                                   node new_right_node_result = {new_node.result, (yyvsp[-2].scope_and_expressions)->node.result, (yyvsp[-2].scope_and_expressions)->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            if ((yyvsp[-1].scope_and_expressions) != NULL) {
                                   char * result_type = check_operation(new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation);
                                   node new_right_node_result = {new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation, result_type};
                                   new_node = new_right_node_result;
                            }

                            scope_and_expressions * this_scope;
                            this_scope->node = new_node;
                            (yyval.scope_and_expressions) = this_scope;

                            num_expressions[top_num_expressions] = new_node;
                            top_num_expressions += 1;
                      }
#line 1854 "y.tab.c"
    break;

  case 39:
#line 356 "./src/parser.y"
                                           {
                            node new_node;
                            new_node.operator = (yyvsp[-1].symbol);
                            new_node.result = get_var_type((yyvsp[-1].symbol));

                            if ((yyvsp[0].scope_and_expressions) != NULL && (yyvsp[0].scope_and_expressions)->node.operator != NULL) {
                                   new_node.operator = (yyvsp[0].scope_and_expressions)->vector;

                                   char * result_type = check_operation(new_node.result, (yyvsp[0].scope_and_expressions)->node.result, (yyvsp[0].scope_and_expressions)->operation);
                                   node new_right_node_result = {new_node.result, (yyvsp[0].scope_and_expressions)->node.result, (yyvsp[0].scope_and_expressions)->operation, result_type};
                                   new_node = new_right_node_result;

                                   num_expressions[top_num_expressions] = new_node;
                                   top_num_expressions += 1;
                            }
                      }
#line 1875 "y.tab.c"
    break;

  case 40:
#line 373 "./src/parser.y"
                                                                                     {
              node new_node;
              char * operation = "";

              if ((yyvsp[-1].scope_and_expressions) != NULL) {
                     if ((yyvsp[-2].scope_and_expressions) != NULL) {
                            new_node = (yyvsp[-2].scope_and_expressions)->node;
                            operation = (yyvsp[-2].scope_and_expressions)->operation;
                     } else {
                            new_node = (yyvsp[-1].scope_and_expressions)->node;
                            operation = (yyvsp[-1].scope_and_expressions)->operation;
                     }

                     char * result_type = check_operation(new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation);
                     node new_right_node_result = {new_node.result, (yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[-1].scope_and_expressions)->operation, result_type};
                     new_node = new_right_node_result;
              }

              scope_and_expressions * this_scope;
              this_scope->node = new_node;
              this_scope->operation = operation;
              this_scope->vector = (yyvsp[-3].symbol);
              (yyval.scope_and_expressions) = this_scope;
            }
#line 1904 "y.tab.c"
    break;

  case 41:
#line 397 "./src/parser.y"
                                          {}
#line 1910 "y.tab.c"
    break;

  case 43:
#line 400 "./src/parser.y"
                { /*empty rule*/ }
#line 1916 "y.tab.c"
    break;

  case 45:
#line 404 "./src/parser.y"
                   { /*empty rule*/ }
#line 1922 "y.tab.c"
    break;

  case 49:
#line 413 "./src/parser.y"
                                                                  { pop(); }
#line 1928 "y.tab.c"
    break;

  case 50:
#line 415 "./src/parser.y"
                                    { pop(); }
#line 1934 "y.tab.c"
    break;

  case 51:
#line 416 "./src/parser.y"
           { /*empty rule*/ }
#line 1940 "y.tab.c"
    break;

  case 52:
#line 419 "./src/parser.y"
                                                                                                        { pop(); }
#line 1946 "y.tab.c"
    break;

  case 55:
#line 424 "./src/parser.y"
                { /*empty rule*/ }
#line 1952 "y.tab.c"
    break;

  case 56:
#line 427 "./src/parser.y"
                                                                                        {
       num_expressions[top_num_expressions] = (yyvsp[-2].scope_and_expressions)->node;
       top_num_expressions += 1;
}
#line 1961 "y.tab.c"
    break;

  case 57:
#line 432 "./src/parser.y"
                                                                            {
       char node_str[100];  // Assuming a maximum size of 100 characters for the string representation of a node
       sprintf(node_str, "%d", (yyvsp[-2].scope_and_expressions)->node.value.i);  // Convert the node to a string using the appropriate format specifier

       char* temp = (char*) malloc(strlen("[") + strlen(node_str) + strlen("]") + strlen((yyvsp[0].symbol)) + 1);
       strcpy(temp, "[");
       strcat(temp, node_str);
       strcat(temp, "]");
       strcat(temp, (yyvsp[0].symbol));

       num_expressions[top_num_expressions] = (yyvsp[-2].scope_and_expressions)->node;
       top_num_expressions += 1;

       strcpy((yyval.symbol), temp);
}
#line 1981 "y.tab.c"
    break;

  case 58:
#line 447 "./src/parser.y"
  { strcpy((yyval.symbol), "");; }
#line 1987 "y.tab.c"
    break;

  case 59:
#line 450 "./src/parser.y"
                                               {
       num_expressions[top_num_expressions] = (yyvsp[-1].scope_and_expressions)->node;
       top_num_expressions += 1;
}
#line 1996 "y.tab.c"
    break;

  case 60:
#line 455 "./src/parser.y"
                                           {
       num_expressions[top_num_expressions] = (yyvsp[0].scope_and_expressions)->node;
       top_num_expressions += 1;
}
#line 2005 "y.tab.c"
    break;

  case 61:
#line 459 "./src/parser.y"
                      { /*empty rule*/ }
#line 2011 "y.tab.c"
    break;

  case 68:
#line 470 "./src/parser.y"
                                         {
       if ((yyvsp[0].scope_and_expressions) != NULL) {
              char* result_type = check_operation((yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[0].scope_and_expressions)->node.result, (yyvsp[0].scope_and_expressions)->node.operator);

              node new_node;
              new_node.node_before = (yyvsp[-1].scope_and_expressions)->node.result;
              new_node.node_after = (yyvsp[0].scope_and_expressions)->node.result;
              new_node.operator = (yyvsp[0].scope_and_expressions)->node.operator;
              new_node.result = result_type;

              scope_and_expressions* this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node = new_node;
              (yyval.scope_and_expressions) = this_scope;
       } else {
              (yyval.scope_and_expressions) = (yyvsp[-1].scope_and_expressions);
       }
}
#line 2033 "y.tab.c"
    break;

  case 69:
#line 488 "./src/parser.y"
                                                             {
       if ((yyvsp[0].scope_and_expressions)) {
              char* result_type = check_operation((yyvsp[-1].scope_and_expressions)->node.result, (yyvsp[0].scope_and_expressions)->node.result, (yyvsp[0].scope_and_expressions)->operation);

              node new_node;
              new_node.node_before = (yyvsp[-1].scope_and_expressions)->node.result;
              new_node.node_after = (yyvsp[0].scope_and_expressions)->node.result;
              new_node.operator = (yyvsp[0].scope_and_expressions)->operation;
              new_node.result = result_type;

              scope_and_expressions * this_scope;
              this_scope->node = new_node;
              this_scope->operation = (yyvsp[-2].scope_and_expressions)->operation;
              (yyval.scope_and_expressions) = this_scope;
       } else {
              scope_and_expressions * this_scope;
              this_scope->node = (yyvsp[-1].scope_and_expressions)->node;
              this_scope->operation = (yyvsp[-2].scope_and_expressions)->operation;
              (yyval.scope_and_expressions) = this_scope;
       }
}
#line 2059 "y.tab.c"
    break;

  case 70:
#line 509 "./src/parser.y"
                      { (yyval.scope_and_expressions) = NULL; }
#line 2065 "y.tab.c"
    break;

  case 71:
#line 512 "./src/parser.y"
                     {
                     scope_and_expressions * this_scope;
                     this_scope->operation = (yyvsp[0].symbol);
                     (yyval.scope_and_expressions) = this_scope;
              }
#line 2075 "y.tab.c"
    break;

  case 72:
#line 517 "./src/parser.y"
                      {
                     scope_and_expressions * this_scope;
                     this_scope->operation = (yyvsp[0].symbol);
                     (yyval.scope_and_expressions) = this_scope;
              }
#line 2085 "y.tab.c"
    break;

  case 73:
#line 524 "./src/parser.y"
                               {
       node new_node2;
       char * operation = "";
       if ((yyvsp[0].scope_and_expressions)) {

              char* result_type = check_operation((yyvsp[-1].symbol), (yyvsp[0].scope_and_expressions)->node.result, (yyvsp[0].scope_and_expressions)->operation);

              node new_node;
              new_node.node_before = (yyvsp[-1].symbol);
              new_node.node_after = (yyvsp[0].scope_and_expressions)->node.result;
              new_node.operator = (yyvsp[0].scope_and_expressions)->operation;
              new_node.result = result_type;

              scope_and_expressions * this_scope;
              this_scope->node = new_node;
              this_scope->operation = (yyvsp[0].scope_and_expressions)->operation;
              (yyval.scope_and_expressions) = this_scope;
       } else {
              scope_and_expressions * this_scope;
              this_scope->operation = (yyvsp[-1].symbol);
              (yyval.scope_and_expressions) = this_scope;
       }
}
#line 2113 "y.tab.c"
    break;

  case 74:
#line 548 "./src/parser.y"
                                  {
                     scope_and_expressions * this_scope;
                     this_scope->node = (yyvsp[0].scope_and_expressions)->node;
                     this_scope->operation = (yyvsp[-1].scope_and_expressions)->operation;
                     (yyval.scope_and_expressions) = this_scope;
              }
#line 2124 "y.tab.c"
    break;

  case 75:
#line 554 "./src/parser.y"
                { (yyval.scope_and_expressions) = NULL; }
#line 2130 "y.tab.c"
    break;

  case 76:
#line 558 "./src/parser.y"
                     {
                     scope_and_expressions * this_scope;
                     this_scope->operation = (yyvsp[0].symbol);
                     (yyval.scope_and_expressions) = this_scope;
              }
#line 2140 "y.tab.c"
    break;

  case 77:
#line 563 "./src/parser.y"
                      {
                     scope_and_expressions * this_scope;
                     this_scope->operation = (yyvsp[0].symbol);
                     (yyval.scope_and_expressions) = this_scope;
              }
#line 2150 "y.tab.c"
    break;

  case 78:
#line 568 "./src/parser.y"
                   {
                     scope_and_expressions * this_scope;
                     this_scope->operation = (yyvsp[0].symbol);
                     (yyval.scope_and_expressions) = this_scope;
              }
#line 2160 "y.tab.c"
    break;

  case 79:
#line 574 "./src/parser.y"
                                 {
              if ((yyvsp[-1].scope_and_expressions)->operation == "-") {
                     (yyvsp[0].scope_and_expressions)->node.value.f = -1 * (yyvsp[0].scope_and_expressions)->node.value.f;

                     (yyvsp[0].scope_and_expressions)->node.value.i = -1 * (yyvsp[0].scope_and_expressions)->node.value.i;
              }    
              strcpy((yyval.symbol), (yyvsp[0].scope_and_expressions)->operation);
          }
#line 2173 "y.tab.c"
    break;

  case 80:
#line 582 "./src/parser.y"
                   {
              strcpy((yyval.symbol), (yyvsp[0].scope_and_expressions)->operation);
          }
#line 2181 "y.tab.c"
    break;

  case 81:
#line 587 "./src/parser.y"
                      {
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node.value.i = (yyvsp[0].integer_return);
              this_scope->node.result = "int";
              (yyval.scope_and_expressions) = this_scope;    
       }
#line 2192 "y.tab.c"
    break;

  case 82:
#line 593 "./src/parser.y"
                        {
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              this_scope->node.value.f = (yyvsp[0].float_return);
              this_scope->node.result = "float";
              (yyval.scope_and_expressions) = this_scope;    
       }
#line 2203 "y.tab.c"
    break;

  case 83:
#line 599 "./src/parser.y"
                         {
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              strcpy(this_scope->node.value.str, (yyvsp[0].symbol));
              this_scope->node.result = "string";
              (yyval.scope_and_expressions) = this_scope;    
       }
#line 2214 "y.tab.c"
    break;

  case 84:
#line 605 "./src/parser.y"
                     {
              scope_and_expressions * this_scope = malloc(sizeof(scope_and_expressions));
              strcpy(this_scope->node.value.str, (yyvsp[0].symbol));
              this_scope->node.result = "null";
              (yyval.scope_and_expressions) = this_scope;    
       }
#line 2225 "y.tab.c"
    break;

  case 85:
#line 611 "./src/parser.y"
                {
              (yyval.scope_and_expressions) = (yyvsp[0].scope_and_expressions);
       }
#line 2233 "y.tab.c"
    break;

  case 86:
#line 614 "./src/parser.y"
                                     {
              (yyval.scope_and_expressions) = (yyvsp[-1].scope_and_expressions);
              
              num_expressions[top_num_expressions] = (yyvsp[-1].scope_and_expressions)->node;
              top_num_expressions += 1;
       }
#line 2244 "y.tab.c"
    break;

  case 87:
#line 621 "./src/parser.y"
                                {
       scope_and_expressions* this_scope = malloc(sizeof(scope_and_expressions));
       this_scope->node.operator = malloc(strlen((yyvsp[-1].symbol)) + strlen((yyvsp[0].symbol)) + 1); // Allocate memory for concatenated string
       strcpy(this_scope->node.operator, (yyvsp[-1].symbol)); // Copy $1 into the operator string
       strcat(this_scope->node.operator, (yyvsp[0].symbol)); // Concatenate $2 to the operator string
       this_scope->node.result = get_var_type((yyvsp[-1].symbol));
       (yyval.scope_and_expressions) = this_scope;   
}
#line 2257 "y.tab.c"
    break;

  case 88:
#line 630 "./src/parser.y"
            {
       new_scope(false);
}
#line 2265 "y.tab.c"
    break;

  case 89:
#line 634 "./src/parser.y"
                 {
       new_scope(true);
}
#line 2273 "y.tab.c"
    break;


#line 2277 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 638 "./src/parser.y"


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

void new_scope(bool is_loop) {
       scope scope;
       scope.is_loop = true;
       push(scope);
}
