//------------------------------------------------------
// Written by Joseph Daniel Moreno
//
// Takes in the user's input for two vectors to multiply
// together and compare the components using the
// multiply_vectors and compare_vectors functions.
//------------------------------------------------------

#include <stdio.h>

void multiply_vectors(int *vector1, int *vector2, int *resulting_vector, int q);

int compare_vectors(int *vector1, int *vector2, int q);

int main() {

	printf("\n");

	int q;

	// Take the user's input.
	printf("Enter the length of the two vectors: ");
	scanf("%d", &q);

	int vector1[q], vector2[q], resulting_vector[q];

	printf("Enter the components of vector 1 with a space between each one: ");
	for(int x = 0; x < q; x++){
		scanf("%d", &vector1[x]);
	}

	printf("Enter the components of vector 2 with a space between each one: ");
	for(int x = 0; x < q; x++){
		scanf("%d", &vector2[x]);
	}

	// multiply_vectors function called.
	multiply_vectors(&vector1[0], &vector2[0], &resulting_vector[0], q);
	printf("\nThe product of the two vectors is: ");
	for(int x = 0; x < q; x++){
		printf("%d ", resulting_vector[x]);
	}

	// compare_vectors function called.
	if (compare_vectors(&vector1[0], &vector2[0], q) == 1)
		printf("\nThe two vectors are the same.");
	else
		printf("\nThe two vectors are not the same.");
	

	printf("\n");

	return(0);

}

void multiply_vectors(int *vector1, int *vector2, int *resulting_vector, int q) {
	for(int x = 0; x < q; x++){
		*resulting_vector = (*vector1 * *vector2); // Multiplying the components together.
		++vector1;				   // Incrementing vector1 and...
		++vector2;				   // ...vector2 and...
		++resulting_vector;			   // ...resulting_vector pointers to access the arrays' elements.
	}

	return;
};

int compare_vectors(int *vector1, int *vector2, int q) {
	int compare_vectors = 1;

	for(int x = 0; x < q; x++){
		if (*vector1 != *vector2){	// If any of the components in the vectors are different...
			compare_vectors = 0;    // ...set compare_vectors to 0 and break the for-loop.
			break;
		}else {				// Otherwise, increment the pointers to compare the next elements in the arrays.
			++vector1;
			++vector2;
		}		
	}

	return compare_vectors;
};
