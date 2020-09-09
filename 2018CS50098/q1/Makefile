all:
	@lex decomment.l
	@gcc -o decomment lex.yy.c -ll
	@./decomment < somefile.c > somefileWithoutComments.c 2> errorsAndWarnings
	@rm decomment
	@rm lex.yy.c
