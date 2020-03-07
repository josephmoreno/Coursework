#ifndef CAR_H

#define CAR_H
#define LEN 30

struct car{

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

struct car *first; //This will hold the first element of the linked list (the first entered car).

#endif
