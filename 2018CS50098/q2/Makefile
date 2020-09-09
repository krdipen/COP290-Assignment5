all:
	@lex tokenizer.l
	@yacc parser.y
	@yacc -d parser.y
	@gcc y.tab.c -o conversion
	@./conversion postfix.txt result.txt
	@rm conversion
	@rm y.tab.h
	@rm y.tab.c
	@rm lex.yy.c
