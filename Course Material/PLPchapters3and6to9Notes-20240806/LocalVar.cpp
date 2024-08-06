// sample main

#include <iostream>
#include <fstream>


using namespace std;


const int maxSize=1000000; 

int main (void)
{

//	int A[maxSize];
	int *A;
	A = new int[maxSize];
	int	count=0, sum=0;;

	// read up to a million numbers from a file
	ifstream cin("large.in");
	while (count<maxSize && cin >> A[count])
		sum += A[count++];

	cout << "Average: " << float (sum) / count << endl;

	system("pause");
	return 0;
}


