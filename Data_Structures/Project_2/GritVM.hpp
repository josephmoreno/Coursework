#include "GritVMBase.hpp"

#include <iostream>
#include <fstream>
#include <list>

class GritVM : public GritVMInterface {
private:
	// Functions
	long evaluate(std::list<Instruction>::iterator it);
	void advance(long l);

	// Members
	std::vector<long> dataMem;
	std::list<Instruction> instructMem;
	std::list<Instruction>::iterator currentInstruct;
	STATUS status;
	long accu;
public:
	GritVM();

	// Virtual functions from GritVMBase.hpp
	STATUS load(const std::string filename, const std::vector<long> &initialMemory);
	STATUS run();
	std::vector<long> getDataMem();
	STATUS reset();
	//--------------------------------------
};
