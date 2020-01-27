//----------------------------------------------------
// Written by Joseph Daniel Moreno
//
// Using recursion to add numbers together rather than
// using the + operator.
//----------------------------------------------------

#include <stdio.h>

int add(int x, int y);

int main() {

	printf("\n");

	int a, b, sum;

	// Input from the user.
	printf("This program will add two numbers together. Enter the first number: ");
	scanf("%d", &a);

	printf("Enter the second number: ");
	scanf("%d", &b);

	// Call the add function.
	sum = add(a, b);

	// Output for the user.
	printf("\nSum: %d", sum); // Equivalent to: printf("\nSum: %d", add(a, b));

	printf("\n");

	return(0);

}

int add(int x, int y) {

	// Decrementing/incrementing y towards 0
	// and incrementing/decrementing x until
	// y is 0 depending on whether x and y
	// are positive or negative.
	while (y != 0){
		if (x >= 0 && y > 0)
			return add(++x, --y);
		else if (x >= 0 && y < 0)
			return add(--x, ++y);
		else if (x <= 0 && y < 0)
			return add(--x, ++y);
		else if (x <= 0 && y > 0)
			return add(++x, --y);
	}

	return x;
};

