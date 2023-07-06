run: execute

execute: parser
	./parser

code: parser_code
	./parser_code

parser: lex.yy.c y.tab.c
	gcc lex.yy.c y.tab.c -o parser

parser_code: lex1.yy.c y1.tab.c
	gcc lex.yy.c y.tab.c -o parser_code

y.tab.c: ./src/parser.y
	yacc -d ./src/parser.y

y1.tab.c: ./src/code.y
	yacc -d ./src/code.y

lex.yy.c: ./src/lex.l
	lex ./src/lex.l

lex1.yy.c: ./src/lex_code.l
	lex ./src/lex_code.l

clean:
	rm -rf lex.yy.c y.tab.c y.tab.h ./parser ./parser_code

install:
	sudo apt-get install bison flex