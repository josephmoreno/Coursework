//=========================================
// Project 3: Graph Modeling and Algorithms
// Written by Joseph Daniel Moreno
//=========================================

#include <iostream>
#include <vector>
#include <map>

struct Vertex {
	std::map<int, int> bucketsState;
	int numOfMoves;

	Vertex() {};

	Vertex(std::map<int, int> bucketsState, int numOfMoves) {
		this->bucketsState = bucketsState;
		this->numOfMoves = numOfMoves;
	};

	int getTotal() {
		int totalGal = 0;

		for(std::map<int, int>::iterator it = this->bucketsState.begin();
		    it != this->bucketsState.end(); ++it) {
			totalGal += it->second;
		}

		return totalGal;
	};

	void printMap() {
		std::map<int, int>:: iterator it;
	
		std::cout << "{ ";

		for(it = bucketsState.begin(); it != bucketsState.end(); ++it) {
			std::cout << it->first << "<-" << it->second << ", ";
		}
		std::cout << "} ";

		return;
	};

	// Function(s) used to help debug. =====================================================================================
	void printVertex() {
		for(std::map<int, int>::iterator it = bucketsState.begin();
	    	    it != bucketsState.end(); ++it) {
			std::cout << "Size (gal.): " << it->first << ", Currently holding (gal.): " << it->second << std::endl;
		}

		std::cout << "# of moves to get here: " << numOfMoves << std::endl << std::endl;

		return;
	};
	//======================================================================================================================
};

struct Graph {
	std::map<Vertex*, std::vector<Vertex*> > adjList;
	std::map<std::map<int, int>, Vertex*> encountered;
	Vertex *start = nullptr;
	unsigned int size;
	unsigned int edges = 0;

	Graph(Vertex *start) {
		this->start = start;
		std::vector<Vertex*> adj;
		adjList.emplace(start, adj);
		encountered.emplace(start->bucketsState, start);
		size = 1;
	};

	void addVertex(Vertex *v) {
		std::vector<Vertex*> adj;
		adjList.emplace(v, adj);
		encountered.emplace(v->bucketsState, v);
		++size;

		return;
	};

	void addEdge(Vertex *s, Vertex *e) {	// s -> starting vertex, e -> ending vertex
		adjList[s].push_back(e);
		++edges;

		return;
	};

	// Function used for checking adjacency list.
	void printAdj() {
		std::map<Vertex*, std::vector<Vertex*> >::iterator m_it;
		std::vector<Vertex*>::iterator v_it;

		for(m_it = adjList.begin(); m_it != adjList.end(); ++m_it) {
			(m_it->first)->printMap();
			std::cout << ": ";

			for(v_it = (m_it->second).begin();
			    v_it != (m_it->second).end();
			    ++v_it) {
				(*v_it)->printMap();
			}

			std::cout << std::endl;
		}

		return;
	};

	// Moves that can be done on the buckets. ===============================================================
	Vertex *fill(std::map<int, int> s, int s_bucket, int s_moves) {
		Vertex *newState = new Vertex(s, (s_moves + 1));	// Increment newState's moves by 1 and
		newState->bucketsState[s_bucket] = s_bucket;		// fill its bucket.

		return newState;
	};

	Vertex *transfer(std::map<int, int> s, int s_bucket1, int s_bucket2, int s_moves) {	// Transferring from s_bucket1
		Vertex *newState = new Vertex(s, (s_moves + 1));				// to s_bucket2.
		
		int available = s_bucket2 - s[s_bucket2];	// Available volume in s_bucket2.

		// Two cases: s_bucket1's amount of water >= s_bucket2's available volume
		// 	      or s_bucket1's amount of water < s_bucket2's available volume.
		if (s[s_bucket1] >= available) {
			newState->bucketsState[s_bucket2] += available;
			newState->bucketsState[s_bucket1] -= available;
		}else if (s[s_bucket1] < available) {
			newState->bucketsState[s_bucket2] += newState->bucketsState[s_bucket1];
			newState->bucketsState[s_bucket1] = 0;
		}

		return newState;
	};

	Vertex *empty(std::map<int, int> s, int s_bucket, int s_moves) {
		Vertex *newState = new Vertex(s, (s_moves + 1));
		newState->bucketsState[s_bucket] = 0;

		return newState;
	};
	//=======================================================================================================

	~Graph() {
		for(std::map<Vertex*, std::vector<Vertex*> >::iterator it = adjList.begin();
		    it != adjList.end(); ++it) {
			delete it->first;
		}
	};
};
