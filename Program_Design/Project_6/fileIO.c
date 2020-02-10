//------------------------------------------------------
// Main function written by Joseph Daniel Moreno
//
// read_line(...) and isAnagram(...) functions provided
// by the course instructor.
//
// Reads in a text file, stores each line in a 2D array,
// then compares the lines with each other to determine
// if they are anagrams of each other. Those anagrams
// are organized and written to a new file. 
//------------------------------------------------------

// words.txt used as an example input file.
// Output file will have the extension ".ang"
// (words.txt.ang).

#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define S_LENGTH 100

int read_line(char *string, int n);
int isAnagram(char *string1, char *string2);

int main() {

	printf("\n");

	char file_name[S_LENGTH + 1], new_file[S_LENGTH + 1], words[1000][S_LENGTH + 1];

	printf("Enter the file name: ");
	read_line(file_name, S_LENGTH + 1);

	// The new file will have the same name as file_name with ".ang" attached to it.
	strcpy(new_file, file_name);
	strcat(new_file, ".ang");

	FILE *pFile = fopen(file_name, "r");

	if (pFile == NULL) {
		printf("No file by the name of %s.\n\n", file_name);
	
		return(1);
	}

	int x = 0;
	while(!feof(pFile) && !ferror(pFile)){
		fgets(words[x], S_LENGTH + 1, pFile);
	      //printf("%s", words[x]);			// Used to make sure the array is getting the correct data.
		++x;					// x is a counter for the amount of lines the text file we're reading has.
	}

	fclose(pFile);

	FILE *pFile2 = fopen(new_file, "w");

	// Calling the isAnagram function to match up words that are anagrams of each other.
	int counter = 1, y, z;
	for(y = 0; y < x; y++){
		for(z = y + 1; z < x; z++){
			if (isAnagram(words[y], words[z]) == 1){
				fprintf(pFile2, "%d\t%s\t%s\n", counter, words[y], words[z]);
				++counter;
				break;
			}
		}
	}

	fclose(pFile2);

	printf("Anagrams have been matched up together in words.txt.ang\n");
	
	return(0);

}

int read_line(char *string, int n) {
	int i = 0;

	char character;

	while((character = getchar()) != '\n'){
		if (i >= n)
			break;

		*string = character;
		++string;
		++i;
	}

	*string = '\0';
	
	return i;
};

int isAnagram(char *string1, char *string2) {
	int letters[26] = {0}, counter = 0, i;

	char character;
	char *p;
	char *q;

	// Increment the position in the array corresponding
	// with the alphabetic letter in the string.
	for(p = string1; *p != '\0'; ++p) {
		if (isalpha(*p)){
			character = tolower(*p);
			letters[character - 'a']++;
		}
	}

	// Decrement the position in the array corresponding
	// with the alphabetic letter in the string.
	for(q = string2; *q != '\0'; ++q) {
		if (isalpha(*q)){
			character = tolower(*q);
			letters[character - 'a']--;
		}
	}

	// If all positions in the array equal 0, then the two
	// strings are anagrams of each other.
	for(i = 0; i < 26; ++i) {
		if (letters[i] == 0)
			++counter;
	}

	if (counter == 26)
		return 1;
	else
		return 0;

	return 0;
};
