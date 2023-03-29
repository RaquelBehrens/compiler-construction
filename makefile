all: execute

execute: parser
	./parser

parser: lex.yy.c y.tab.c
	gcc lex.yy.c y.tab.c -o parser

y.tab.c: parser.y
	yacc -d parser.y

lex.yy.c: lex.l
	lex lex.l

	
clean:
	rm -rf lex.yy.c y.tab.c y.tab.h ./parser 