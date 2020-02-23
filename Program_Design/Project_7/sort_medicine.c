//-------------------------------------------------------
// Main function written by Joseph Daniel Moreno
//
// read_line(...) and selection_sort(...) functions
// provided by the course instructor.
//
// Reads in a file of medicines to be sorted by the total
// units sold, then creates a new file after sorting the
// medicines.
//-------------------------------------------------------

#include <stdio.h>
#include <string.h>

#define MAX 100
#define MONTHS 6

int read_line(char *string, int n);

struct medicine{
	char name[MAX + 1];
	int unitsInStock;
	int monthlyUnitsSold[MONTHS];
	int totalUnitsSold;
};

struct medicine constructor(char med_name[], int inStock, int monthlySold[], int totalSold) {
	struct medicine med;

	strcpy(med.name, med_name);
	med.unitsInStock = inStock;
	
	int i;
	int *monthly = monthlySold;
	for(i = 0; i < MONTHS; i++) {
		med.monthlyUnitsSold[i] = *monthly;
		++monthly;
	}

	med.totalUnitsSold = totalSold;

	return med;
};

void selection_sort(struct medicine meds[], int n);

int main() {

	printf("\n");

	struct medicine meds[MAX];
	struct medicine currentMed;

	char file_name[MAX + 1], new_file[MAX + 1];

	// User input.
	printf("Enter the file name with its extension: ");
	scanf("%s", file_name);

	// Create a file name for the new file to be created.
	strcpy(new_file, file_name);
	strcat(new_file, ".srt");	

	FILE *pFile = fopen(file_name, "r");
	/*FILE *pFile2 = fopen(new_file, "w");

	fprintf(pFile2, "#\tName\t\tIn Stock\tJan.\tFeb.\tMar.\tApr.\tMay\tJun.\tTotal\n");*/

	if (pFile == NULL)
		return(1);

	int j = 0, m;
	while(!feof(pFile) && !ferror(pFile)){
		fscanf(pFile, "%s", currentMed.name);
		fscanf(pFile, "%d", &currentMed.unitsInStock);

		m = 0;
		while(!feof(pFile) && (fscanf(pFile, "%d", &currentMed.monthlyUnitsSold[m]) >= 0) && m < 6){
			++m;
		}
		
		int k, sum = 0;
		for(k = 0; k < MONTHS; k++){
			sum += currentMed.monthlyUnitsSold[k];
		}

		currentMed.totalUnitsSold = sum;

		meds[j] = currentMed; // Stores all the currentMed's data into the meds array.
		++j;		      // Increment j to move the array to the next element.
	}

	fclose(pFile);

	selection_sort(meds, j); // Call the selection_sort function.

	FILE *pFile2 = fopen(new_file, "w");

	fprintf(pFile2, "#\t\t\tName\tIn Stock\tJan.\tFeb.\tMar.\tApr.\tMay\tJun.\tTotal\n");
	
	int l;
	for(l = 0; l < j; l++){
		fprintf(pFile2, "%d\t%20s\t%d\t\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", (l + 1), meds[l].name, meds[l].unitsInStock,
			meds[l].monthlyUnitsSold[0], meds[l].monthlyUnitsSold[1], meds[l].monthlyUnitsSold[2],
			meds[l].monthlyUnitsSold[3], meds[l].monthlyUnitsSold[4], meds[l].monthlyUnitsSold[5], meds[l].totalUnitsSold);
	}

	fclose(pFile2);

	printf("A new file has been created: %s\n", new_file);
	
	return(0);

}

void selection_sort(struct medicine meds[], int n) {
	struct medicine temp;

	int i, largest = 0;

	if (n == 1)
		return;

	for(i = 1; i < n; ++i) {
		if (meds[i].totalUnitsSold > meds[largest].totalUnitsSold)
			largest = i;
	}

	if (largest < (n - 1)) {		// if-statement moves the medicine structures to different indices of the meds array.
		temp = meds[n - 1];
		meds[n - 1] = meds[largest];
		meds[largest] = temp;
	}

	selection_sort(meds, (n - 1));

	return;
};

int read_line(char *string, int n) {
	int i = 0;

	char character;

	while((character = getchar()) != '\n') {
		if (i >= n)
			break;

		*string = character;
		++string;
		++i;
	}

	*string = '\0';
	return i;
};
