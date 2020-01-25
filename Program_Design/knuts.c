//---------------------------------------------------------------
// Written by Joseph Daniel Moreno
//
// This program converts an amount of knuts to galleons, sickles,
// and some leftover amount of knuts (Harry Potter currency).
//---------------------------------------------------------------

#include <stdio.h>

int main(void)
{
	// sickle = 29 knuts; galleon = 493 knuts
	int knuts; int sickles; int galleons;

	// Get user's input.
	printf("\nEnter the amount of knuts: ");
	scanf("%d", &knuts);

	// Disallow input less than 0 and more than a billion.
	if (knuts < 0){
		printf("Invalid amount of knuts.\n");
		return 0;
	}else if (knuts > 1000000000){
		printf("Invalid amount of knuts.\n");
		return 0;
	}

	// Calculate # of galleons, sickles, and knuts from the initial knuts.
	galleons = (knuts / 493);
	knuts -= (galleons * 493);
	sickles = (knuts / 29);
	knuts -= (sickles * 29);

	// Output for the user.
	printf("The amount entered equals %d galleon(s), %d sickle(s), and %d knut(s).\n", galleons, sickles, knuts);

	return 0;
}
