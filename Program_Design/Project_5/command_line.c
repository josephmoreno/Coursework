//----------------------------------------
// Written by Joseph Daniel Moreno
//
// Calculates the median or average based
// on the arguments passed by the user.
//----------------------------------------

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void sort(double *d, int s);

int main(int argc, char *argv[]) {

	printf("\n");

	if (argc > 12 || argc < 3) {
		printf("Invalid # of arguments.\n");
		printf("This program is used to calculate the average (-a)");
		printf(" or median (-m) of a dataset that holds up to 10");
		printf(" numbers.\n\nExample of usage: program -m 1 2 3 4 5 6 7");
		printf("\n\nThe example above takes the median from the dataset");
		printf(" {1, 2, 3, ..., 7}.\nThe set must have at least 1 number");
		printf(" and at most 10 numbers.\n");
		return(0);
	}

	if (strcmp("-m", argv[1]) != 0 && strcmp("-a", argv[1]) != 0) {
		printf("Invalid 1st argument; enter \"-a\" to calculate the");
		printf(" average or \"-m\" to calculate the median.\n");
		return(0);
	}

	int size = argc - 2;
	double d[size];

	for(int x = 0; x < size; ++x)
		d[x] = atof(argv[x + 2]);

	sort(d, size);

	printf("Sorted Dataset:\n");

	for(int x = 0; x < size; ++x)
		printf("%0.2f ", d[x]);

	printf("\n");

	if (strcmp("-m", argv[1]) == 0) {
		if (size % 2 == 0) {
			printf("Median = %0.2f", ((d[(size / 2) - 1] + d[size / 2]) / 2));
		} else {
			printf("Median = %0.2f", d[size / 2]);
		}
	}

	if (strcmp("-a", argv[1]) == 0) {
		double sum = 0;

		for(int x = 0; x < size; ++x) {
			sum += d[x];
		}

		printf("Average = %0.2f", (sum / size));
	}

	printf("\n");

	return(0);

}

void sort(double *d, int s) {
	double temp, i, *d0, *d1;
	
	for(int x = 1; x < s; ++x) {
		d1 = &d[x]; d0 = d1 - 1;
		i = x;

		while(*d1 < *d0) {
			temp = *d0;
			*d0 = *d1;
			*d1 = temp;
			--i;

			if (i <= 0) break;
			else { --d1; --d0; }
		}
	}

	return;
};
