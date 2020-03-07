// Written by Joseph Daniel Moreno				||
//								||
// GritVMBase.hpp and GritVMBase.cpp written and provided	||
// by the course instructor.					||
//								||
// Test files written and provided by the instructor:		||
// altseq.gvm, sumn.gvm, surfarea.gvm, test.gvm			||
//								||
// The program is an interpreter for a programming language	||
// called GritVM. It reads in a file written in GritVM,		||
// runs the code, and is able to return the results held in	||
// the GritVM object's memory.					||
//								||
// Main function is commented out at the bottom of this		||
// file.							||
//===============================================================

#include "GritVMBase.cpp"
#include "GritVM.hpp"

std::fstream readFile;
std::string::iterator it_s;

// GritVM
// 	Private functions
long GritVM::evaluate(std::list<Instruction>::iterator it) {
	long next = 1;
	int temp;	// Temporary variable that holds the arguments casted to int.

	//while ((it != instructMem.end()) && (status == RUNNING)) {
		switch((*it).operation) {
			case CLEAR: accu = 0;
				break;
			case AT: accu = dataMem.at((*it).argument);
				break;
			case SET: dataMem.at((*it).argument) = accu;
				break;
			case INSERT: temp = int((*it).argument);
				     dataMem.insert((dataMem.begin() + temp), accu);
				break;
			case ERASE: temp = int((*it).argument);
				    dataMem.erase(dataMem.begin() + temp);
				break;
			case ADDCONST: accu += (*it).argument;
				break;
			case SUBCONST: accu -= (*it).argument;
				break;
			case MULCONST: accu *= (*it).argument;
				break;
			case DIVCONST: accu /= (*it).argument;
				break;
			case ADDMEM: accu += dataMem.at((*it).argument);
				break;
			case SUBMEM: accu -= dataMem.at((*it).argument);
				break;
			case MULMEM: accu *= dataMem.at((*it).argument);
				break;
			case DIVMEM: accu /= dataMem.at((*it).argument);
				break;
			case JUMPREL: if ((*it).argument != 0) {
			     	     	return (*it).argument;
				      }else {
					status = ERRORED;
					return next;
				      }
				break;
			case JUMPZERO: if (((*it).argument != 0) && (accu == 0)) {
						return (*it).argument;
				       }else if (accu != 0) {
						break;
				       }else if ((*it).argument == 0) {
						status = ERRORED;
						return next;
				       }
				break;
			case JUMPNZERO: if (((*it).argument != 0) && (accu != 0)) {
						return (*it).argument;
					}else if (accu == 0) {
						break;
					}else if ((*it).argument == 0) {
						status = ERRORED;
						return next;
					}
				break;
			case NOOP: 
				break;
			case HALT: status = HALTED;
				   next = 0;
				break;
			case OUTPUT: std::cout << "Accumulator: " << accu << std::endl;
				break;
			case CHECKMEM: if (dataMem.size() < (unsigned int)((*it).argument)) {
						status = ERRORED;
						next = 0;
				       }
				break;
			default: status = ERRORED;
				 next = 0;
				break;
		}

		//++it;
	//}

	return next;
};

void GritVM::advance(long l) {
	long temp;

	// Increment or decrement the iterator of the current instruction based on l.
	if (l > 0) {
		for(temp = 0; temp < l; ++temp)
			++currentInstruct;
	}else {
		for(temp = 0; temp > l; --temp)
			--currentInstruct;
	}

	return;
};

// 	Public functions
GritVM::GritVM() {
	accu = 0;
	status = WAITING;
};

STATUS GritVM::load(const std::string filename, const std::vector<long> &initialMemory) {
	status = WAITING;

	readFile.open(filename);

	if (readFile.is_open()) {
		std::string temp;
		while(!readFile.eof()) {
			std::getline(readFile, temp);

			// Skip the line if it's empty, begins with a space, or begins with a '#'
			if ((temp.end() - temp.begin() != 0) && (*temp.begin() != ' ') && (*temp.begin() != '#')) {
				std::istringstream iss(temp);
				std::istream_iterator<std::string> iss_it(iss);

				if (GVMHelper::stringtoInstruction(*iss_it) != UNKNOWN_INSTRUCTION) {
					instructMem.push_back(GVMHelper::parseInstruction(temp));
					//std::cout << temp << std::endl;
				}else {
					status = ERRORED;	// Set status to ERRORED if the instruction isn't recognized.
					instructMem.clear();
					break;
				}

				iss.str("");
				iss.clear();
			}
		}

		readFile.close();
	}else {
		throw "File can't be opened.";
	}

	if (instructMem.size() == 0) {
		status = WAITING;
	}else {
		status = READY;
		dataMem = initialMemory;
	}

	return status;
};

STATUS GritVM::run() {
	long l;

	if (status == READY) {
		status = RUNNING;
		currentInstruct = instructMem.begin();

		while((status == RUNNING) && (currentInstruct != instructMem.end())) {
			l = evaluate(currentInstruct);
			advance(l);
		}

		if (currentInstruct == instructMem.end())
			status = HALTED;
	}
	
	return status;
};

std::vector<long> GritVM::getDataMem() {
	return dataMem;
};

STATUS GritVM::reset() {
	status = WAITING;
	accu = 0;
	instructMem.clear();
	dataMem.clear();
	
	return status;
};
//------------------------------------------------------------------------------

// TESTING CODE
/*int main() {

	GritVM GVM;
	GVM.load("altseq.gvm", GVM.getDataMem());
	std::cout << GVMHelper::statusToString(GVM.load("test.gvm", GVM.getDataMem())) << std::endl;
	GVM.run();
	GVM.reset();

	return(0);

};*/
