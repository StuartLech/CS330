#include <algorithm>
#include <iostream>

using namespace std;
int main() {
    // Add/subtract elements from the list for larger/smaller permutation list
    int arr[] = { 1, 2, 3, 4, 5, 6,7};

    sort(arr, arr + sizeof(arr) / sizeof(arr[0]));
    for (int i : arr) {
        cout << i << " ";
    }
    cout << "\n";

    while (next_permutation(arr, arr + sizeof(arr) / sizeof(arr[0]))) {
        for (int i : arr) {
            cout << i << " ";
        }
        cout << "\n";
    }
    system("pause");
    return 0;
}