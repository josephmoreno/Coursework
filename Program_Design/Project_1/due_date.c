//-----------------------------------------------------------------------------------------------------
// Written by Joseph Daniel Moreno
//
// User enters the current weekday and an amount of days students are allowed to work on an assignment
// and the program adjusts the amount of days to work to avoid any religious holy days that the due
// date may fall on.
//-----------------------------------------------------------------------------------------------------

#include <stdio.h>

int main(void){

	int days;		// Amount of days students are allowed to work on the assignment.
	int current_day;	// The day input by the user.
	int calculated_date;	// Adds days to the current_day and is used in if statements to determine the unmodified due date.
	int day_due;		// Variable used as a condition for the switch statement.
	
	printf("\nEnter today's day using 0-6, with 0 being Sunday and 6 being Saturday: ");
	scanf("%d", &current_day);

	if (current_day < 0){
		printf("Invalid input.\n");
		return 0;
	}else if (current_day > 6){
		printf("Invalid input.\n");
		return 0;
	}

	printf("Enter the amount of days the students are allowed to work on the assignment: ");
	scanf("%d", &days);

	if (days < 0){
		printf("Invalid input.\n");
		return 0;
	}

	calculated_date = (current_day + days);

	if ((calculated_date % 7) == 0)
		day_due = 0;
	else if ((calculated_date % 7) == 1)
		day_due = 1;
	else if ((calculated_date % 7) == 2)
		day_due = 2;
	else if ((calculated_date % 7) == 3)
		day_due = 3;
	else if ((calculated_date % 7) == 4)
		day_due = 4;
	else if ((calculated_date % 7) == 5)
		day_due = 5;
	else if ((calculated_date % 7) == 6)
		day_due = 6;

	printf("\n");

	switch (day_due){
		case 0: printf("The due date is on a Sunday. Correcting the amount of days students are allowed to work.\n");
			days = (days + 1);
			printf("Students are allowed to work %d day(s) and the assignment is due on a Monday.", days);
			break;
		case 1: printf("The assignment isn't due on a religion's holy day.\n");
			printf("Students are allowed to work %d day(s) and the assignment is due on a Monday.", days);
			break;
		case 2: printf("The assignment isn't due on a religion's holy day.\n");
			printf("Students are allowed to work %d day(s) and the assignment is due on a Tuesday.", days);
			break;
		case 3: printf("The assignment isn't due on a religion's holy day.\n");
			printf("Students are allowed to work %d day(s) and the assignment is due on a Wednesday.", days);
			break;
		case 4: printf("The assignment isn't due on a religion's holy day.\n");
			printf("Students are allowed to work %d day(s) and the assignment is due on a Thursday.", days);
			break;
		case 5: printf("The due date is on a Friday. Correcting the amount of days students are allowed to work.\n");
			days = (days + 3);
			printf("Students are allowed to work %d day(s) and the assignment is due on a Monday.", days);
			break;
		case 6: printf("The due date is on a Saturday. Correcting the amount of days students are allowed to work.\n");
			days = (days + 2);
			printf("Students are allowed to work %d day(s) and the assignment is due on a Monday.", days);
			break;
	}

	printf("\n");

	return 0;
}
