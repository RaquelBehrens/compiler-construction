run: execute

execute: parser
	./parser

parser: lex.yy.c y.tab.c
	gcc lex.yy.c y.tab.c -o parser

y.tab.c: ./src/parser.y
	yacc -d ./src/parser.y

lex.yy.c: ./src/lex.l
	lex ./src/lex.l

clean:
	rm -rf lex.yy.c y.tab.c y.tab.h ./parser 

install:
	sudo apt-get install bison flex