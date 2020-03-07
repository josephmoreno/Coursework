// Written by Joseph Daniel Moreno			||
//							||
// CalcListInterface.hpp written and provided by the	||
// instructor to specify the required functionality	||
// of my program.					||
//							||
// The program implements a doubly linked list (uses	||
// a header and trailer) based arithmetic		||
// calculator. The calculator keeps a running total	||
// of the operations, the overall total operations	||
// completed, and what each operation is.		||
//							||
// Main function is commented out at the bottom of	||
// this file.						||
//=======================================================

#include "CalcList.hpp"

// Global variables for the number of operations performed and the calculator's total.
int NUM_OF_OP = 0;
double TOTAL = 0;

OperationNode::OperationNode(int opN, double x, double opO, FUNCTIONS f, OperationNode *p, OperationNode *n) {
	opNum = opN;
	opTotal = x;
	opOperand = opO;
	function = f;
	prev = p;
	next = n;
};

OperationNode::OperationNode(bool H, bool T) {
	h = H;
	t = T;
};

// Unsure of whether a destructor is necessary or not.
/*OperationNode::~OperationNode() {
	if ((this->prev == nullptr) && (this->next != nullptr)) { // This else-if for deleting the header and trailer.
		delete this->next;
		this->next = nullptr;
	}

	delete this;
};*/

double CalcList::total() const {
	return TOTAL;
};

void CalcList::newOperation(const FUNCTIONS func, const double operand) {
		// Do the operation on global variable "TOTAL", create a new node, insert it into the linked list
		// and increment the number of operations "NUM_OF_OP".
		switch(func) {
			case ADDITION: { TOTAL += operand;
				         ++NUM_OF_OP;
				         OperationNode *newOp = new OperationNode(NUM_OF_OP, TOTAL, operand, ADDITION, current, current->next);
				       
				         current->next->prev = newOp;
				         current->next = newOp;
				         current = current->next; }
				       break;
			case SUBTRACTION: { TOTAL -= operand;
					    ++NUM_OF_OP;
					    OperationNode *newOp = new OperationNode(NUM_OF_OP, TOTAL, operand, SUBTRACTION, current, current->next);
				       	  
					    current->next->prev = newOp;
				            current->next = newOp;
				            current = current->next; }
					  break;
			case MULTIPLICATION: { TOTAL *= operand;
					       ++NUM_OF_OP;
					       OperationNode *newOp = new OperationNode(NUM_OF_OP, TOTAL, operand, MULTIPLICATION, current, current->next);
				       	     
					       current->next->prev = newOp;
				       	       current->next = newOp;
				       	       current = current->next; }
					     break;
			case DIVISION: { if (operand == 0) {
						throw "Cannot divide by zero; undefined."; // Exception for dividing by zero.
					 }
					 
					 TOTAL /= operand;
				         ++NUM_OF_OP;
				         OperationNode *newOp = new OperationNode(NUM_OF_OP, TOTAL, operand, DIVISION, current, current->next);
				       
				         current->next->prev = newOp;
				         current->next = newOp;
				         current = current->next; }
				       break;
			default: std::cout << "Not a valid function or operand." << std::endl;
		}
		
		return;
};

void CalcList::removeLastOperation() {
	if ((header->next == trailer) && (trailer->prev == header)) {
		throw "There are no operations to remove.";		// Exception for trying to remove an operation from an empty list.
	}

	// Latest operation is pointed at by current.
	if ((current->h != true) && (current->t != true)) { // If current is not the header and not the trailer...
		OperationNode *hold = current;
		current = current->prev;
		current->next = hold->next;
		hold->next->prev = current;

		delete hold;		// Delete the latest operation and
		hold = nullptr;		// set hold to nullptr.

		--NUM_OF_OP;			// Decrement the number of operations and
		TOTAL = current->opTotal;	// roll back "TOTAL" to the latest operation's total.
	}
		
	return;
};

std::string CalcList::toString(unsigned short precision) const {
	std::string calculation = "";	// Empty string.

	std::ostringstream outStream;

	OperationNode *temp = current;	// Temporary pointer to keep current at that latest operation.

	while(temp != header) {	
		switch(temp->function) {
			case ADDITION: outStream << temp->opNum << ": " << std::setprecision(precision) << std::fixed << temp->prev->opTotal << "+" 
				       		 << temp->opOperand << "=" << temp->opTotal << "\n"; 
			       	       break;
			case SUBTRACTION: outStream << temp->opNum << ": " << std::setprecision(precision) << std::fixed << temp->prev->opTotal << "-" 
				       		    << temp->opOperand << "=" << temp->opTotal << "\n";
				          break;
			case MULTIPLICATION: outStream << temp->opNum << ": " << std::setprecision(precision) << std::fixed << temp->prev->opTotal << "*" 
				       		       << temp->opOperand << "=" << temp->opTotal << "\n";
				     	     break;
			case DIVISION: outStream << temp->opNum << ": " << std::setprecision(precision) << std::fixed << temp->prev->opTotal << "/" 
				       		 << temp->opOperand << "=" << temp->opTotal << "\n";
			       	       break;
		}

		calculation += outStream.str(); // Concatenate to string "calculation".
		temp = temp->prev;

		outStream.str(""); // Clearing the buffer.
		outStream.clear();
	}

	temp = nullptr;
		
	return calculation;
};

CalcList::CalcList() {
	header = new OperationNode(true, false); // Create the header and have the header's "total" be zero.
	header->opTotal = 0;

	trailer = new OperationNode(false, true); // Create trailer.

	header->next = trailer;
	trailer->prev = header;
	current = header;
};

void CalcList::DeleteCalcList() {
	while ((header->next != trailer) && (trailer->prev != header)) { // Delete all operation nodes.
		removeLastOperation();
	}

	delete header;	// Delete header and trailer nodes and set pointers to nullptr.
	delete trailer;

	header = nullptr;
	trailer = nullptr;

	return;
};

CalcList::~CalcList() {
	DeleteCalcList();
};

// TESTING CODE
/*int main() {

//	int foo = 0;

	CalcList calc;
	calc.newOperation(ADDITION, 10);
	std::cout << calc.getCurOpNum() << ": " << calc.total() << std::endl;
	calc.newOperation(MULTIPLICATION, 5);
	std::cout << calc.getCurOpNum() << ": " << calc.total() << std::endl;
	calc.newOperation(SUBTRACTION, 15);
	std::cout << calc.getCurOpNum() << ": " << calc.total() << std::endl;
	calc.newOperation(DIVISION, 7);
	std::cout << calc.getCurOpNum() << ": " << calc.total() << std::endl;
	calc.removeLastOperation();
	std::cout << calc.getCurOpNum() << ": " << calc.total() << std::endl;
	calc.newOperation(SUBTRACTION, 30);
	std::cout << calc.getCurOpNum() << ": " << calc.total() << std::endl;
	calc.newOperation(ADDITION, 5);
	std::cout << calc.getCurOpNum() << ": " << calc.total() << std::endl;
	calc.removeLastOperation();
	std::cout << calc.getCurOpNum() << ": " << calc.total() << std::endl;

	std::cout << "\nALL OPERATIONS:\n" << calc.toString(2);

	return(0);

}*/
