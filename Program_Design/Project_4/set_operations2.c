//-------------------------------------------------------
// Written by Joseph Daniel Moreno
//
// Takes input of two sets from the user and outputs
// the differences between the sets and the complementing
// sets by using the set_difference and set_complement
// functions.
//-------------------------------------------------------

// Example Solution:
// Set A = {1, 9, 3} and Set B = {1, 8, 9, 7}
//
// Set A can be represented with a set of 0's and 1's like this:
// {0, 1, 0, 1, 0, 0, 0, 0, 0, 1}
// 
// 1's occupy the spaces in the array that correspond with the
// values in set A.
//
// Differences between A and B: 3, 7, 8
// Difference between A and B (A - B; values in A that are not in B): 3
// A's complement set: 0, 2, 4, 5, 6, 7, 8
// B's complement set: 0, 2, 3, 4, 5, 6

#include <stdio.h>

void set_difference(int *A_array, int *B_array, int array_max, int *difference);

void set_complement(int *_array, int array_max, int *complement);

int main() {

	printf("\n");

	int i, j, A_max, B_max;

	// Set A.
	printf("Enter the number of elements in set A: ");
	scanf("%d", &i);

	int a[i];

	printf("Enter the numbers of set A with a space separating each element: ");
	for(int x = 0; x < i; x++)
		scanf("%d", &a[x]);

	A_max = a[0];
	for(int x = 1; x < i; x++) {
		if (a[x] > A_max)
			A_max = a[x];
	}

	// Set B.
	printf("\nEnter the number of elements in set B: ");
	scanf("%d", &j);

	int b[j];

	printf("Enter the numbers of set B with a space separating each element: ");
	for(int x = 0; x < j; x++)
		scanf("%d", &b[x]);

	B_max = b[0];
	for(int x = 1; x < j; x++) {
		if (b[x] > B_max)
			B_max = b[x];
	}

	// Compare A_max and B_max, see which one is bigger, then set that as the size for the arrays with 0's and 1's.
	int array_max;

	if (A_max > B_max)
		array_max = A_max;
	else if (B_max >= A_max)
		array_max = B_max;

	int A_array[(array_max + 1)], B_array[(array_max + 1)];

	// Array for set A with 0's and 1's.
	for(int x = 0; x < (array_max + 1); ++x)
		A_array[x] = 0;

	for(int x = 0; x < i; ++x)
		A_array[a[x]] = 1;

	// Array for set B with 0's and 1's.
	for(int x = 0; x < (array_max + 1); ++x)
		B_array[x] = 0;

	for(int x = 0; x < j; ++x)
		B_array[b[x]] = 1;

      /*Old comparison code of A_array and B_array.
	printf("\nThe difference(s) between set A and B is (are): ");
	for(int x = 0; x < (array_max + 1); x++) {
		if (A_array[x] != B_array[x])
			printf("%d ", x);
	}*/

      /*Original difference code.
	printf("\nThe difference of set A and B (set A - set B) is: ");
	for(int x = 0; x < (array_max + 1); x++) {
		if ((A_array[x] - B_array[x]) == 1)
			printf("%d ", x);
	}*/

	// New difference code that calls the set_difference function.
	int k = 0;
	for(int x = 0; x < (array_max + 1); x++) {
		if ((A_array[x] == 1) && (B_array[x] == 0)) // Determining the size of difference[].
			++k;
	}
	int difference[k];

	set_difference(&A_array[0], &B_array[0], array_max, &difference[0]);
	printf("\nThe difference(s) of set A from B is (are): ");
	for(int x = 0; x < k; x++)
		printf("%d ", difference[x]);

      /*Original complement code.
	// Complement sets.
	printf("\nThe complementing set of set A is: ");
	for(int x = 0; x < (array_max + 1); x++) {
		if (A_array[x] == 0)
			printf("%d ", x);
	}

	printf("\nThe complementing set of set B is: ");
	for(int x = 0; x < (array_max + 1); x++) {
		if (B_array[x] == 0)
			printf("%d ", x);
	}*/

	// New complement code that calls the set_complement function.
	
	// Set A complement code.
	int l = 0;
	for(int x = 0; x < (array_max + 1); x++) { // Determining the size of A_complement[].
		if (A_array[x] == 0)
			++l;
	}
	int A_complement[l];

	set_complement(&A_array[0], array_max, &A_complement[0]);
	printf("\nThe complementing set of set A is: ");
	for(int x = 0; x < l; x++) {
		printf("%d ", A_complement[x]);
	}

	// Set B complement code.
	l = 0;
	for(int x = 0; x < (array_max + 1); x++) { // Determining the size of B_complement.
		if (B_array[x] == 0)
			l++;
	}
	int B_complement[l];

	set_complement(&B_array[0], array_max, &B_complement[0]);
	printf("\nThe complementing set of Set B is: ");
	for(int x = 0; x < l; x++) {
		printf("%d ", B_complement[x]);
	}

	// Code for making sure that A_array and B_array are picking up the 0's and 1's properly.
	/*printf("\n");
	for(int x = 0; x < (array_max + 1); x++) {
		printf("%d\n", A_array[x]);
	}

	printf("\n");

	for(int x = 0; x < (array_max +1); x++) {
		printf("%d\n", B_array[x]);
	}*/

	printf("\n");

	return(0);

}

void set_difference(int *A_array, int *B_array, int array_max, int *difference) {
	// The for-loop keeps the elements' evaluation within the boundaries of A_array and B_array.
	// The boundaries of A_array and B_array are defined by array_max + 1 (see lines 50 through 60).
	for(int x = 0; x < (array_max + 1); x++) {
		if ((*A_array == 1) && (*B_array == 0)) {
			*difference = x;
			++difference;
		}
			++A_array;
			++B_array;
	}

	return;
};

void set_complement(int *_array, int array_max, int *complement) {
	for (int x = 0; x < (array_max + 1); x++) {
		if (*_array == 0) {
			*complement = x;
			++_array;
			++complement;
		}
		else
			++_array;
	}

	return;
};
