//=========================================
// Project 3: Graph Modeling and Algorithms
// Written by Joseph Daniel Moreno
// ========================================

#include <fstream>

#include "graph.hpp"

std::fstream fs1, fs2;

int bucketAlg(std::map<int, int> bMap, std::vector<int> &m);
void printMap(Vertex *v);

int main() {

	std::map<int, int> bucketMap;	// <bucketSize, current # of gal>
	std::vector<int> moves;	// Example: moves[4] = minimum # of moves to get 4 gal.

	int numOfBuckets;	// # of buckets
	int bucketSize; 	// Used to read in and assign bucket sizes.
	int maxCapacity = 0;	// Maximum gal. possible with given bucket sizes.
	int sol;

	fs1.open("input.txt", std::fstream::in);
	fs2.open("output.txt", std::fstream::out);

	if (!fs1.is_open()) {
		return(0);
	}else if (fs1.eof()) {
		fs1.close();
		fs2.close();
		return(0);
	}

	fs1 >> numOfBuckets;

	for(int i = 0; i < numOfBuckets; ++i) {
		if (fs1.eof())
			break;

		// Read in bucket sizes from input.txt and
		// emplace them in bucketMap as empty (0 gal.).
		fs1 >> bucketSize;
		maxCapacity += bucketSize;
		bucketMap.emplace(bucketSize, 0);
	}

	// Initialize moves vector to -1 for moves[0..(maxCapacity + 1)].
	moves.resize(maxCapacity + 1, -1);
	moves[0] = 0;	// Takes 0 moves to get 0 gal. of water.

	// Checking moves vector.
	/*for(unsigned int j = 0; j < moves.size(); ++j) {
		std::cout << j << " gal. requires " << moves[j] << " moves." << std::endl;
	}*/

	// Checking if map is being written properly.
	/*for(std::map<int, int>::iterator it = bucketMap.begin();
	    it != bucketMap.end(); ++it) {
		std::cout << "Size (gal.): " << it->first << ", Currently holding (gal.): " << it->second << std::endl;
	}*/

	sol = bucketAlg(bucketMap, moves);
	//std::cout << sol << " " << moves[sol] << std::endl;	// Checking output.
	fs2 << sol << " " << moves[sol];

	fs1.close();
	fs2.close();

	return(0);

};

int bucketAlg(std::map<int, int> bMap, std::vector<int> &m) {
	int max = 0;
	int sol = 0;
	std::map<int, int>::iterator it, it2;

	Vertex *s = new Vertex(bMap, 0);
	Graph G(s);
	
	std::vector<Vertex*> q;	// Using a vector as a queue.
	q.push_back(s);

	// Breadth-first graph construction.
	while(!q.empty()) {
		Vertex *cur = q.front();	// Current vertex to perform moves on.
		Vertex *newV;	// Used to create new vertices and add them to G.
		
		q.erase(q.begin());

		for(it = cur->bucketsState.begin();
		    it != cur->bucketsState.end(); ++it) {
			// Filling buckets and creating vertices.
			// If the bucket isn't full, then fill it.
			if (it->second != it->first) {
				newV = G.fill(cur->bucketsState, it->first, cur->numOfMoves);

				// If this state has been encountered before
				// and its numOfMoves <= newV's numOfMoves,
				// then delete newV.
				if (G.encountered.count(newV->bucketsState) == 1
				    && m[newV->getTotal()] != -1 
				    && m[newV->getTotal()] <= newV->numOfMoves) {
					G.addEdge(cur, G.encountered[newV->bucketsState]);
					delete newV;
				}else {
				// Else, add newV to the graph, update least moves
				// for that total of gal., and create an edge from
				// cur to newV. Add newV to the queue.
					G.addVertex(newV);
					G.addEdge(cur, newV);
					q.push_back(newV);

				//	printMap(newV);	// DEBUGGING

					if (m[newV->getTotal()] > newV->numOfMoves || m[newV->getTotal()] == -1) {
						m[newV->getTotal()] = newV->numOfMoves;
						
						/*if (m[newV->getTotal()] > max) {
							max = m[newV->getTotal()];
							sol = newV->getTotal();
						}*/
					}
				}
			}

			// Transferring water from one bucket to another and creating vertices.
			it2 = it;
			++it2;
			while(it2 != cur->bucketsState.end()) {
				if (it2->second != it2->first && it->second != 0) {
					newV = G.transfer(cur->bucketsState, it->first, it2->first, cur->numOfMoves);

					if (G.encountered.count(newV->bucketsState) == 1
				    	    && m[newV->getTotal()] != -1 
				    	    && m[newV->getTotal()] <= newV->numOfMoves) {
						G.addEdge(cur, G.encountered[newV->bucketsState]);
						delete newV;
					}else {
						G.addVertex(newV);
						G.addEdge(cur, newV);
						q.push_back(newV);

					//	printMap(newV);	// DEBUGGING

						if (m[newV->getTotal()] > newV->numOfMoves || m[newV->getTotal()] == -1) {
							m[newV->getTotal()] = newV->numOfMoves;
						
							/*if (m[newV->getTotal()] > max) {
								max = m[newV->getTotal()];
								sol = newV->getTotal();
							}*/
						}
					}
				}

				if (it->second != it->first && it2->second != 0) {
					newV = G.transfer(cur->bucketsState, it2->first, it->first, cur->numOfMoves);

					if (G.encountered.count(newV->bucketsState) == 1
				    	    && m[newV->getTotal()] != -1 
				    	    && m[newV->getTotal()] <= newV->numOfMoves) {
						G.addEdge(cur, G.encountered[newV->bucketsState]);
						delete newV;
					}else {
						G.addVertex(newV);
						G.addEdge(cur, newV);
						q.push_back(newV);

					//	printMap(newV);	// DEBUGGING

						if (m[newV->getTotal()] > newV->numOfMoves || m[newV->getTotal()] == -1) {
							m[newV->getTotal()] = newV->numOfMoves;
						
							/*if (m[newV->getTotal()] > max) {
								max = m[newV->getTotal()];
								sol = newV->getTotal();
							}*/
						}
					}
				}

				++it2;
			}
			
			// Emptying buckets and creating vertices.
			if (it->second != 0) {
				newV = G.empty(cur->bucketsState, it->first, cur->numOfMoves);

				if (G.encountered.count(newV->bucketsState) == 1
				    && m[newV->getTotal()] != -1 
				    && m[newV->getTotal()] <= newV->numOfMoves) {
					G.addEdge(cur, G.encountered[newV->bucketsState]);
					delete newV;
				}else {
					G.addVertex(newV);
					G.addEdge(cur, newV);
					q.push_back(newV);

				//	printMap(newV);	// DEBUGGING

					if (m[newV->getTotal()] > newV->numOfMoves || m[newV->getTotal()] == -1) {
						m[newV->getTotal()] = newV->numOfMoves;
						
						/*if (m[newV->getTotal()] > max) {
							max = m[newV->getTotal()];
							sol = newV->getTotal();
						}*/
					}
				}
			}

		}

	//	std::cout << std::endl;	// Part of debugging code.
	}

	for(unsigned int i = 0; i < m.size(); ++i) {
		//std::cout << i << ": " << m[i] << std::endl;

		if (m[i] > max) {
			max = m[i];
			sol = i;
		}

	}

	// Checking adjacency list.
	//G.printAdj();

	//std::cout << G.size << " " << G.edges << " ";	// Checking output.
	fs2 << G.size << " " << G.edges << " ";

	return sol;
};

void printMap(Vertex *v) {
	std::map<int, int>:: iterator it;
	
	std::cout << "{ ";

	for(it = v->bucketsState.begin(); it != v->bucketsState.end(); ++it) {
		std::cout << it->first << "<-" << it->second << ", ";
	}
	std::cout << "} ";

	return;
};
