# compiler-construction

This application is a compiler for the language defined in 'grammar.pdf'. For now, it only supports lexical analysis. It is based on Lex, in order to develop the lexical analyzer, and Yacc (parser) for further syntax analysis.

To run our application, please first type the following command:
`make install`

Then, to run the compiler, type the following command:

`make run`

We have three tests files available at ./tests/ directory. Therefore, please type the file path to a source code, for example:

`./tests/test1.txt`

Lex will start analyzing it. Lex will show the symbol table and the token list, and return any error if found.

When you are done testing files, just type 'exit' to close the application.

To clean all generated files, please type:

`make clean`
