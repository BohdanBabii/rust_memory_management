#include <iostream>
#include <algorithm>
#include <vector>
#include <chrono>
#include <cstdlib>

// Binary search function
int binarySearch(const std::vector<int>& arr, int target) {
    int left = 0;
    int right = arr.size() - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (arr[mid] == target) {
            return mid; // Element found
        } else if (arr[mid] < target) {
            left = mid + 1; // Adjust the search range to the right
        } else {
            right = mid - 1; // Adjust the search range to the left
        }
    }

    return -1; // Element not found
}


int main(int argc, char *argv[]) {
    // Set the default array size
    int size = 1000000;

    // Check if the array size is provided as a command-line argument
    if (argc > 1) {
        size = std::atoi(argv[1]);
    }

    // Generate a random array
    std::vector<int> arr(size);
    for (int i = 0; i < size; ++i) {
        arr[i] = i;
    }

    // Shuffle the array to make it random
    std::random_shuffle(arr.begin(), arr.end());

    // Sort the array (binary search requires a sorted array)
    std::sort(arr.begin(), arr.end());

    // Choose a random element to search for
    int target = arr[rand() % size];

    // Output the result and time taken
    std::cout << "Element " << target << " found at index " << binarySearch(arr, target) << std::endl;

    return 0;
}
