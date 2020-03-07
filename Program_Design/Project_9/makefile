readline.o: readline.c readline.h
	gcc -c readline.c

car.o: car.c car.h
	gcc -c car.c

dealer2.o: dealer2.c
	gcc -c dealer2.c

dealer2: dealer2.o car.o readline.o
	gcc -o dealer2 dealer2.o car.o readline.o
