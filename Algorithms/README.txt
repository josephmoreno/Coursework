Project 3 - Joseph Daniel Moreno ||
==================================

* Project details explained in project3-s2019.pdf
* sample input.txt used to verify my program's
  functionality.

The .cpp/.hpp files were written and compiled on
a Windows machine; compilation was done using MinGW.

Compilation command used:
g++ -std=gnu++17 buckets.cpp -o buckets

OR

g++ -std=c++17 buckets.cpp -o buckets

The first two numbers written to output.txt by my program
will not match the first two numbers of each of the sample
outputs in sample input.txt.

I coded my program in such a way so that vertices aren't
created for impossible bucket volume combinations given
certain bucket sizes.

For example, with two buckets with sizes 5 gal. and 3 gal.,
there are 8 impossible bucket volume combinations:
(Format is {5 gal. bucket, 3 gal. bucket})

{1, 1}, {1, 2}, {2, 1}, {2, 2}, {3, 1}, {3, 2}, {4, 1}, and
{4, 2}

With the three moves "fill", "empty", and "transfer water",
the 8 above vertices/states will not be created by my
program.

To summarize, the first two numbers in output.txt (# of
vertices and # of edges) will not match the corresponding
output in sample input.txt, but the last two numbers of
output.txt (the bucket volume that takes the most moves
to make and # of moves for that volume) will match the
corresponding output in sample input.txt.