CC ?= gcc

CFLAGS ?= -Werror -Wall -Wextra -funsigned-char -fwrapv -Wconversion -Wno-sign-conversion -Wmissing-format-attribute -Wpointer-arith -Wformat-nonliteral -Winit-self -Wwrite-strings -Wshadow -Wenum-compare -Wempty-body -Wparentheses -Wcast-align -Wstrict-aliasing --pedantic-errors

.PHONY: all clean test coverage

all: cmptest example1 example2

test: cmptest
	@./cmptest

%.o: %.c
	$(CC) $(CFLAGS) --std=c99 -g -O3 -I. -c -o $@ $<

libcmp.a: cmp.o cmp_stdio.o
	ar rc $@ $?
	ranlib $@

cmptest: cmp.o
	$(CC) $(CFLAGS) -Wno-error=deprecated-declarations -Wno-deprecated-declarations --std=c99 -I. -fprofile-arcs -ftest-coverage -g -O0 -o cmptest cmp.o test/test.c test/buf.c test/utils.c -lcmocka

example1:
	$(CC) $(CFLAGS) --std=c99 -O3 -I. -o example1 cmp.c examples/example1.c

example2:
	$(CC) $(CFLAGS) --std=c99 -O3 -I. -o example2 cmp.c examples/example2.c

coverage:
	@rm -f base_coverage.info test_coverage.info total_coverage.info
	@rm -rf coverage
	@lcov -q -c -i -d . -o base_coverage.info
	@lcov -q -c -d . -o test_coverage.info
	@lcov -q -a base_coverage.info -a test_coverage.info -o total_coverage.info
	@lcov -q --summary total_coverage.info
	@mkdir coverage
	@genhtml -q -o coverage total_coverage.info

clean:
	@rm -f cmptest
	@rm -f example1
	@rm -f example2
	@rm -f *.o
	@rm -f *.gcno *.gcda *.info
	@rm -f cmp_data.dat
