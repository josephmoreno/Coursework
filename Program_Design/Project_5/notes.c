//----------------------------------------
// Written by Joseph Daniel Moreno
//
// Encodes notes by swapping letters based
// on their position in the alphabet.
//----------------------------------------

#include <stdio.h>

void convert(char *s0, char *s1);

int main() {

	printf("\n");

	char s0[1000], s1[1000];

	printf("Enter a sentence to be encoded (under 1000 characters): ");
	for(int x = 0; x < 1000; ++x) {
		scanf("%c", &s0[x]);

		if (s0[x] == '\n') break;
	}

	convert(&s0[0], &s1[0]);

	printf("The encoded sentence: ");
	for(int x = 0; x < 1000; ++x) {
		if (s1[x] == '\n' || s1[x] == '\0') break;
		else printf("%c", s1[x]);
	}

	printf("\n");

	return(0);

}

void convert(char *s0, char *s1) {
	while(*s0 != '\0') {
		if (*s0 >= 'A' && *s0 <= 'Z')
			*s1 = 'Z' - (*s0 - 'A');
		else if (*s0 >= 'a' && *s0 <= 'z')
			*s1 = 'z' - (*s0 - 'a');
		else
			*s1 = *s0;

		++s0; ++s1;
	}

	return;
};
