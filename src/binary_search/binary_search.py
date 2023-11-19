import random
import time

def binary_search(arr, target):
    left, right = 0, len(arr) - 1

    while left <= right:
        mid = left + (right - left) // 2

        if arr[mid] == target:
            return mid  # Element found
        elif arr[mid] < target:
            left = mid + 1  # Adjust the search range to the right
        else:
            right = mid - 1  # Adjust the search range to the left

    return -1  # Element not found

def measure_time_binary_search(arr, target):
    start_time = time.time()
    binary_search(arr, target)
    end_time = time.time()
    return (end_time - start_time) * 1000  # Convert to milliseconds

def main():
    # Set the default array size
    size = 1000000

    # Check if the array size is provided as a command-line argument
    import sys
    if len(sys.argv) > 1:
        size = int(sys.argv[1])

    # Generate a random array
    arr = list(range(size))
    random.shuffle(arr)

    # Sort the array (binary search requires a sorted array)
    arr.sort()

    # Choose a random element to search for
    target = random.choice(arr)

    # Output the result and time taken
    print(f"Element {target} found at index {binary_search(arr, target)}")

if __name__ == "__main__":
    main()
