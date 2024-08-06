// sample main

#include <iostream>
#include <fstream>
#include <iomanip>
#include <string>



using namespace std;

union valueType 
{
	int j; 
	double x;
	char ch;
}; // j, x, ch share the same memory location. 

int main (void)
{
	valueType cv_table[5]; 
	// declare a  table for values of constants in a compiler-type program, 
	cv_table[3].j = 100; 
	cout << cv_table[3].ch << endl; // what will be printed? 'd'
	cv_table[3].ch = 'a'; // store 'a' in location 3, 
	cout << cv_table[3].j << endl; // what will be printed this time? 97
	cout << cv_table[3].x << endl; // what will be printed this time? junk
	system("pause");
	return 0;
}
