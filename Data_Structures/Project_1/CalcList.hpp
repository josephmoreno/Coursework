// Header file for CalcList that inherits the CalcListInterface
// virtual functions and defines the node struct for each operation.

#include <iostream>
#include <sstream>
#include <iomanip>
#include <exception>

#include "CalcListInterface.hpp"

struct OperationNode {
	bool h = false;		// Used for the header node.
	bool t = false;		// Used for the trailer node.
	int opNum;		// Used for the operation's specific step number.
	double opTotal;		// Result after operation.
	double opOperand;	// Operand used in this operation.
	FUNCTIONS function;
	OperationNode *prev = nullptr;
	OperationNode *next = nullptr;

	// Constructors
	OperationNode(int opN, double x, double opO, FUNCTIONS f, OperationNode *p, OperationNode *n); // Used for nodes with operations.
	OperationNode(bool H, bool T); // For header and trailer nodes.

	// Destructor (unsure of whether it's necessary or not; I think the delete keyword frees up the node's memory anyway.)
	//~OperationNode();
};

class CalcList : public CalcListInterface {
private:
	OperationNode *current;	// Will be used to point to the latest operation node.
	OperationNode *header;
	OperationNode *trailer;

public:
	// Virtual functions from CalcListInterface.hpp
	double total() const;	// Returns the global variable TOTAL in CalcList.cpp

	void newOperation(const FUNCTIONS func, const double operand); // Switch used for each function in CalcList.cpp

	void removeLastOperation(); // Nodes' next and prev pointers need to be changed.

	std::string toString(unsigned short precision) const; // Using ostringstream to create a continuous string with white space.
	//-----------------------------------------------

	// Constructor
	CalcList(); 
	
	// Destructor
	~CalcList();	// Using DeleteCalcList() function.

	// Deleting the list.
	void DeleteCalcList(); // Using a while loop to traverse and delete the list.

	// Get current's opNum.
	int getCurOpNum() { return current->opNum; }
};
