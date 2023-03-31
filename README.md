# compiler-construction

This application is a compiler for the language defined in 'grammar.pdf'. For now, it only supports lexical analysis. It is based on Lex, in order to develop the lexical analyzer, and Yacc (parser) for further syntax analysis.


To start the lex:

`make`

Type the file path to a source code, and then Lex will start analyzing it. Lex will show the symbol table and the token list, and return any error if found.

Some tests are already defined at ./tests/.

When you are done testing files, just type 'exit' to close the application.
