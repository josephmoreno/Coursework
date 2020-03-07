#include <iostream>
#include <algorithm>
#include <map>
#include "GraphBase.hpp"

class Vertex {
private:
	std::string vLabel = "\0";
	std::vector<Vertex*> adjacencies;
public:
	// Constructor
	Vertex() {}
	Vertex(std::string l) { vLabel = l; }

	// Getters
	std::string getLabel() { return vLabel; }
	std::vector<Vertex*> getAdjacencies() { return adjacencies; }

	// Used to add and remove an adjacent vertex.
	void addAdjacent(Vertex *v);
	void removeAdjacent(std::string l);
};

class Edge {
private:
	Vertex *v1;
	Vertex *v2;
	unsigned long eWeight;
public:
	// Constructor
	Edge() : v1(nullptr), v2(nullptr), eWeight(0) {}
	Edge(Vertex *V1, Vertex *V2, unsigned long edgeWeight) : v1(V1), v2(V2), eWeight(edgeWeight) {}

	// Getters
	Vertex *getV1() { return v1; }
	Vertex *getV2() { return v2; }
	unsigned long getWeight() { return eWeight; }
};

// Used in shortestPath(...)
struct leastPathValues {
	leastPathValues() : prev(""), least(999999999) {}
	std::string prev;
	unsigned long least;
};

class Graph : public GraphBase {
private:
	std::vector<Vertex*> vertices;
	std::vector<Edge*> edges;
public:
	// Constructor and destructor.
	Graph() {}
	~Graph();

	// Viewing the vertices and edges.
	void printVertices();
	void printEdges();

	// Used in shortestPath function.
	//unsigned long dijkstraAlg(Vertex *current, Vertex *end, std::vector<std::string> &p, std::map<std::string, leastPathValues *> &d);
	//Edge *findEdge(std::string l1, std::string l2);

	// Virtual functions from GraphBase.hpp
	void addVertex(std::string label);
	void removeVertex(std::string label);
	void addEdge(std::string label1, std::string label2, unsigned long weight);
	void removeEdge(std::string label1, std::string label2);
	unsigned long shortestPath(std::string startLabel, std::string endLabel, std::vector<std::string> &path);
};
