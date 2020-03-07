// Written by Joseph Daniel Moreno			||
//							||
// GraphBase.hpp written and provided by the course	||
// instructor to specify how my program should		||
// function.						||
//							||
// The program implements an undirected, weighted	||
// graph ADT and perform's Djikstra's Algorithm		||
// to find the shortest path between two vertices.	||
// The graph is represented as an adjacency list.	||
//							||
// The main function is commented out at the bottom	||
// of this file.					||
//=======================================================

#include "Graph.hpp"

std::vector<Vertex*>::iterator v_it, v_it1;
std::vector<Edge*>::iterator e_it, e_it1;

// Graph destructor
Graph::~Graph() {
//	std::cout << "Destructor called." << std::endl;

	if (!vertices.empty()) {
		for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
			delete (*v_it);
		}
	}

	if (!edges.empty()) {
		for(e_it = edges.begin(); e_it != edges.end(); ++e_it) {
			delete (*e_it);
		}
	}
};

// Graph public function(s)
void Graph::printVertices() {
	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		std::cout << "Label: " << (*v_it)->getLabel() << std::endl;
	}

	return;
};

void Graph::printEdges() {
	for(e_it = edges.begin(); e_it != edges.end(); ++e_it) {
		std::cout << "(" << (*e_it)->getV1()->getLabel() << ")--(" << (*e_it)->getV2()->getLabel() << "), Weight: " << (*e_it)->getWeight() << std::endl;
	}

	return;
};

// Virtual functions from GraphBase.hpp
void Graph::addVertex(std::string label) {
	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		if ((*v_it)->getLabel() == label) {
			throw "Duplicate label.";
		}
	}

	Vertex *v = new Vertex(label);
	vertices.push_back(v);

	return;
};

void Graph::removeVertex(std::string label) {
	// Remove edges related to the vertex with label.
	for(e_it = edges.begin(); e_it != edges.end(); ++e_it) {
		if ((*e_it)->getV1()->getLabel() == label || (*e_it)->getV2()->getLabel() == label) {
			delete (*e_it);	// TRYING TO FREE MEMORY
			edges.erase(e_it);
			--e_it;
		}
	}

	// Remove the vertex from vertices.
	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		if ((*v_it)->getLabel() == label) {
			delete (*v_it);	// TRYING TO FREE MEMORY
			vertices.erase(v_it);
			break;
		}
	}

	return;
};

void Graph::addEdge(std::string label1, std::string label2, unsigned long weight) {
	Vertex *temp1 = nullptr;
	Vertex *temp2 = nullptr;
	
	// Check if there exists vertices with label1 and label2.
	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		if ((*v_it)->getLabel() == label1) {
			temp1 = *v_it;
			break;
		}
	}

	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		if ((*v_it)->getLabel() == label2) {
			temp2 = *v_it;
			break;
		}
	}

	if (temp1 == nullptr || temp2 == nullptr)
		throw "Label(s) not found.";

	// Create edge and add it to edges.
	Edge *e = new Edge(temp1, temp2, weight);
	edges.push_back(e);

	temp1->addAdjacent(temp2);
	temp2->addAdjacent(temp1);

	temp1 = nullptr;
	temp2 = nullptr;

	return;
};

void Graph::removeEdge(std::string label1, std::string label2) {
	// Remove the vertices from each others' adjacency vectors.
	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		if ((*v_it)->getLabel() == label1) {
			(*v_it)->removeAdjacent(label2);
			break;
		}
	}

	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		if ((*v_it)->getLabel() == label2) {
			(*v_it)->removeAdjacent(label1);
			break;
		}
	}

	// Remove the edge from edges.
	for(e_it = edges.begin(); e_it != edges.end(); ++e_it) {
		if (((*e_it)->getV1()->getLabel() == label1 && (*e_it)->getV2()->getLabel() == label2)
		   || ((*e_it)->getV1()->getLabel() == label2 && (*e_it)->getV2()->getLabel() == label1)) {
			delete (*e_it);	// TRYING TO FREE MEMORY
			edges.erase(e_it);
			break;
		}
	}

	return;
};

unsigned long Graph::shortestPath(std::string startLabel, std::string endLabel, std::vector<std::string> &path) {
	unsigned long minDistance = 0;
	std::vector<Vertex*> ntv;	// Need to be visited.
	std::map<std::string, bool> unvisited;
	std::map<std::string, leastPathValues *> distances;

	std::map<std::string, leastPathValues *>::iterator m_it;

	// Emplace the vertices' strings with a leastPathValue object into distances and mark it as unvisited.
	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		if (distances.count((*v_it)->getLabel()) == 0) {
			leastPathValues *lpv = new leastPathValues();
			distances.emplace((*v_it)->getLabel(), lpv);
			unvisited.emplace((*v_it)->getLabel(), true);
		}
	}

	// Get the vertex pointers corresponding with startLabel and endLabel.
	Vertex *start = nullptr;
	Vertex *end = nullptr;

	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		if ((*v_it)->getLabel() == startLabel) {
			start = (*v_it);
			break;
		}
	}

	for(v_it = vertices.begin(); v_it != vertices.end(); ++v_it) {
		if ((*v_it)->getLabel() == endLabel) {
			end = (*v_it);
			break;
		}
	}

	if (start == nullptr || end == nullptr)
		throw "Start and/or end label(s) not found.";

	// Have current point to the start.
	Vertex *current = start;

	// Change the start label's leastPathValues values.
	(distances.at(start->getLabel()))->least = 0;
	(distances.at(start->getLabel()))->prev = start->getLabel();

	// Put the start into the queue.
	ntv.push_back(current);

	while(!ntv.empty() && !edges.empty()) {
		Vertex *x = nullptr;
		Vertex *y = nullptr;

		current = *(ntv.begin());
		ntv.erase(ntv.begin());

		// Find all edges connected to current.
		for(e_it = edges.begin(); e_it != edges.end(); ++e_it) {
			if ((*e_it)->getV1() == current && unvisited.count((*e_it)->getV2()->getLabel()) == 1) {
				x = (*e_it)->getV1();
				y = (*e_it)->getV2();
			}else if ((*e_it)->getV2() == current && unvisited.count((*e_it)->getV1()->getLabel()) == 1) {
				x = (*e_it)->getV2();
				y = (*e_it)->getV1();
			}else {
				continue;
			}

			if (unvisited.count(y->getLabel()) == 1) {
				// If x's distance from start + edge's distance < y's least distance from start...
				if (((distances.at(x->getLabel()))->least + (*e_it)->getWeight()) < ((distances.at(y->getLabel()))->least)) {
					// Store that smaller distance at y and...
					(distances.at(y->getLabel()))->least = ((distances.at(x->getLabel()))->least + (*e_it)->getWeight());
					
					// ...store the vertex label corresponding with that smaller distance at y.
					(distances.at(y->getLabel()))->prev = x->getLabel();
				}

				// Insert the neighboring vertices into the vector if not already.
				bool inQueue = false;
				for(v_it = ntv.begin(); v_it != ntv.end(); ++v_it) {
					if (*v_it == y) {
						inQueue = true;
						break;
					}
				}
				
				if (inQueue == false) {
					// Vector should be ordered from least to most distance from the start.
					for(v_it = ntv.begin(); v_it != ntv.end(); ++v_it) {	
						if ((distances.at((*v_it)->getLabel()))->least > (distances.at(y->getLabel()))->least) {
							ntv.insert(v_it, y);
							break;
						}
					}

					if (v_it == ntv.end())
						ntv.push_back(y);
				}
			}
		}

		// Now that all neighbors have been evaluated, remove the current label from unvisited.
		unvisited.erase(current->getLabel());		
	}

	// Set minDistance to the least distance from the start stored for the end label.
	minDistance = (distances.at(end->getLabel()))->least;

	// Set pathing to the label of the end vertex and work backwards for the path.
	std::string pathing = end->getLabel();

	do {
		path.push_back(pathing);
		pathing = (distances.at(pathing))->prev;
	}while ((distances.at(pathing))->prev != pathing);

	path.push_back(start->getLabel());

	std::reverse(path.begin(), path.end());

	// Destroy the leastPathValues objects created for the map.
	for(m_it = distances.begin(); m_it != distances.end(); ++m_it) {
		delete m_it->second;
	}

	return minDistance;
}

/*unsigned long Graph::dijkstraAlg(Vertex *current, Vertex *end, std::vector<std::string> &p, std::map<std::string, leastPathValues> &d) {
	while(current != end) {
		
	}

	return 100;
};*/

/*Edge *Graph::findEdge(std::string l1, std::string l2) {
	Edge *edge = nullptr;

	for(e_it1 = edges.begin(); e_it1 != edges.end(); ++e_it) {
		if (((*e_it1)->getV1()->getLabel() == l1 && (*e_it1)->getV2()->getLabel() == l2)
		   || ((*e_it1)->getV1()->getLabel() == l2 && (*e_it1)->getV2()->getLabel() == l1)) {
			edge = (*e_it1);
			break;
		}
	}

	return edge;
};*/

// Vertex public function(s)
void Vertex::addAdjacent(Vertex *v) {
	adjacencies.push_back(v);

	return;
};

void Vertex::removeAdjacent(std::string l) {
	for(v_it1 = adjacencies.begin(); v_it1 != adjacencies.end(); ++v_it1) {
		if ((*v_it1)->getLabel() == l) {
			adjacencies.erase(v_it1);
			break;
		}
	}

	return;
};

/*int main() {

	Graph graph;

	std::vector<std::string> p;
	std::vector<std::string>::iterator it;

	graph.addVertex("1");
	graph.addVertex("2");
	graph.addVertex("3");
	graph.addVertex("4");
	graph.addVertex("5");
	graph.addVertex("6");
	graph.addEdge("1", "2", 7);
	graph.addEdge("1", "3", 9);
	graph.addEdge("1", "6", 14);
	graph.addEdge("2", "3", 10);
	graph.addEdge("2", "4", 15);
	graph.addEdge("3", "4", 11);
	graph.addEdge("3", "6", 2);
	graph.addEdge("4", "5", 6);
	graph.addEdge("5", "6", 9);

	std::cout << "SHORTEST PATH FROM 1 TO 5: WEIGHT = " << graph.shortestPath("1", "5", p) << std::endl;
	std::cout << "PATH: " << std::endl;
	for(it = p.begin(); it != p.end(); ++it) {
		std::cout << *it << std::endl;
	}
	std::cout << "\n";
	p.clear();

	std::cout << "SHORTEST PATH FROM 3 TO 6: WEIGHT = " << graph.shortestPath("3", "6", p) << std::endl;
	std::cout << "PATH: " << std::endl;
	for(it = p.begin(); it != p.end(); ++it) {
		std::cout << *it << std::endl;
	}
	std::cout << "\n";
	p.clear();

	std::cout << "SHORTEST PATH FROM 5 TO 2: WEIGHT = " << graph.shortestPath("5", "2", p) << std::endl;
	std::cout << "PATH: " << std::endl;
	for(it = p.begin(); it != p.end(); ++it) {
		std::cout << *it << std::endl;
	}
	std::cout << "\n";
	p.clear();

	return(0);

}*/
