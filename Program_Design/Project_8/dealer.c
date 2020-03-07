//-------------------------------------------
// Written by Joseph Daniel Moreno
//
// read_line(...) function provided by the
// course instructor.
//
// Program allows the user to modify, search,
// and view the information of cars using a
// linked list.
//-------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define LEN 30

struct car {
	char make[LEN+1];
	char model[LEN+1];
	char color[LEN+1];
	int year;
	int city_mpg;
	int highway_mpg;
	int quantity;
	struct car *next;
};

struct car *append_to_list(struct car *list);
void find_car(struct car *list);
void printList(struct car *list);
void clearList(struct car *list);
int read_line(char str[], int n);

/**********************************************************
 * main: Prompts the user to enter an operation code,     *
 *       then calls a function to perform the requested   *
 *       action. Repeats until the user enters the        *
 *       command 'q'. Prints an error message if the user *
 *       enters an illegal code.                          *
 **********************************************************/

struct car *first; // This will hold the first element of the linked list (the first entered car).

int main(void) {
  
  char code;

  struct car *car_list = NULL;  
  printf("\nOperation Code: a for appending to the list, f for finding a car"
	  ", p for printing the list; q for quit.\n");
  
  for ( ; ; ){
    printf("Enter operation code: ");
    scanf(" %c", &code);
    while (getchar() != '\n')   /* skips to end of line */
      ;
    
    switch (code) {
      case 'a': car_list = append_to_list(car_list);
                break;
      case 'f': find_car(car_list);
                break;
      case 'p': printList(car_list);
                break;
      case 'q': clearList(car_list);
		return 0;
      default:  printf("Illegal code.\n");
    }
    
    printf("\n");
  }

}

struct car *append_to_list(struct car *list) {

	struct car *new_car;
	struct car *previous, *current;

	new_car = malloc(sizeof(struct car));
	if (new_car == NULL) {
		printf("\nmalloc function failed. Unable to create new car entry.");
		return list;
	}		

	printf("\nEnter the car's make: ");
	read_line((*new_car).make, LEN);

	printf("Enter the car's model: ");
	read_line((*new_car).model, LEN);

	printf("Enter the car's color: ");
	read_line((*new_car).color, LEN);

	printf("Enter the car's year: ");
	scanf("%d", &(*new_car).year);

	printf("Enter the car's MPG in the city: ");
	scanf("%d", &(*new_car).city_mpg);

	printf("Enter the car's MPG on the highway: ");
	scanf("%d", &(*new_car).highway_mpg);

	printf("Enter the quantity of this car: ");
	scanf("%d", &(*new_car).quantity);

	if (list == NULL) {
		first = new_car;
		list = new_car;
		list->next = NULL;
	} else {
		previous = list;
		(*list).next = new_car;
		list = new_car;
		list->next = NULL;

		for(current = first; current != list; current = (*current).next) {
                	if (strcmp((*current).make, (*new_car).make) == 0
                    	    && strcmp((*current).model, (*new_car).model) == 0
                    	    && strcmp((*current).color, (*new_car).color) == 0
                    	    && (*current).year == (*new_car).year){
                        	printf("\nThis car is already listed.");
                        	free(new_car);
				list = previous;
				list->next = NULL;
                        	break;
			}
		}
	}

	return list;

}

void find_car(struct car *list) {
	
	struct car *current;

	char this_make[LEN + 1];
	char this_model[LEN + 1];

	int match_status = 0;

	printf("\nEnter the make of the car that you want to search: ");
	read_line(this_make, LEN);

	printf("Enter the model of the car that you want to search: ");
	read_line(this_model, LEN);

	printf("\nSearch results for make %s and model %s: ", this_make, this_model);

	current = first;
	while(current != NULL) {
		if (strcmp(this_make, (*current).make) == 0
		    && strcmp(this_model, (*current).model) == 0) {
			printf("\nColor: %s\tYear: %d\tCity MPG: %d\tHighway MPG: %d\tQuantity: %d", (*current).color, (*current).year,
			       (*current).city_mpg, (*current).highway_mpg, (*current).quantity);

			match_status = 1;
		}

		current = current->next;
	}

	if (match_status == 0)
		printf("No matches found.");

	printf("\n");

	return;

}

void printList(struct car *list) {

	struct car *current;

	//printf("\nMake\t\tModel\t\tYear\t\tColor");

	for(current = first; current != NULL; current = (*current).next)
		printf("\nMake: %s\tModel: %s\tYear: %d\tColor: %s", (*current).make, (*current).model, (*current).year,
		       (*current).color);

	printf("\n");

	return;

}

void clearList(struct car *list) {

	struct car *current = first;
	struct car *temp;

	while(current != NULL) {
		temp = current;
		current = (*current).next;

		if (temp != NULL)
			free(temp);
	}

	return;

}

int read_line(char str[], int n) {

  int ch, i = 0;

  while (isspace(ch = getchar()))
    ;
  str[i++] = ch;
  while ((ch = getchar()) != '\n') {
    if (i < n)
      str[i++] = ch;
    
   }
   
   str[i] = '\0';
   return i;
 
}
