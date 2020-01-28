//-----------------------------------------------------
// Written by Joseph Daniel Moreno
//
// Takes the user's input for a username and determines
// whether it's valid/invalid based on the amount of
// characters and the symbols used.
//-----------------------------------------------------

#include <stdio.h>

int main() {

	char c;
	int characters = 0, invalid = 0;

	// Prompt user for input.
	printf("\nType a username and press \"Enter\": ");
	
	// Evaluate the username's individual characters.
	do {
		c = getchar(); // ...or scanf("%c", &c);
		
		if (c == '_' || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9'))
			++characters;
		else if (c == '\n')
			continue;
		else
			invalid = 1;

		if (invalid == 1)
			break;
	} while(c != '\n');

	printf("\n");

	// Tell the user the username is invalid.
	if (invalid == 1)
		printf("Username cannot use symbols other than an underscore.\n");

	if (characters < 5 || characters > 10)
		printf("Username needs to be at least 5 characters and can have at most 10 characters.\n");

	// Output of confirmation that the username is valid.
	if (characters >= 5 && characters <= 10 && invalid != 1)
		printf("Username accepted!\n");

	return(0);

}
