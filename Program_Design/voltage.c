//------------------------------------------
// Written by Joseph Daniel Moreno
//
// Calculate the voltage over a capacitor by
// using a formula for every fifteenth of a
// second up to one whole second.
//------------------------------------------

#include <stdio.h>
#include <math.h>

int main() {

	double capacitor_v, timer;

	// The table's header.
	printf("\nTime (sec)\tCapacitor Voltage\n");

	// For loop for showing output of the capacitor's voltage for every one-fifteenth of a second.
	for (timer = 0; timer <= 1; timer += 0.06666666666) {
		// Formula for the capacitor's voltage.
		capacitor_v = (10 * (1 - exp(-timer / 0.15))); // Power source is 10V and 0.15 = R * C where R is 3,000 Ohms
							       // and C is 50 * 10^-6 Farads.

		// Output for the user.
		printf("%1.2f\t\t%1.2f\n", timer, capacitor_v);
	}

	printf("\n");

	return(0);

}
