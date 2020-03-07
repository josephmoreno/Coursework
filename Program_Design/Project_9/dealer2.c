//-------------------------------------------------------------
// Written by Joseph Daniel Moreno
//
// read_line(...) function provided by the
// course instructor.
//
// Make file is used to compile project 8. Program modifies a
// linked list based on input from the user.
//-------------------------------------------------------------

#include <stdio.h>
#include "car.h"
#include "readline.h"

int main(void){

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
      default:  printf("Illegal code\n");
    }

    printf("\n");
  }

}
