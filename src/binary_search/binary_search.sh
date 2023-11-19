#!/bin/bash

echo
echo "----------------------------------------------------------------"
echo 

# Compile the C++ program
g++ binary_search.cpp -o binary_search_cpp

# Set the array size
array_size=10000000

# Record the start time for C++ program
start_time_cpp=$(date +%s.%N)

# Run the C++ program
./binary_search_cpp $array_size

# Record the end time for C++ program
end_time_cpp=$(date +%s.%N)

# Calculate the time difference for C++ program
time_difference_cpp=$(echo "$end_time_cpp - $start_time_cpp" | bc)

# Print the time difference for C++ program
echo "Time taken by the C++ program: ${time_difference_cpp} seconds"

echo
echo "----------------------------------------------------------------"
echo

# Record the start time for Rust program
start_time_rust=$(date +%s.%N)

# Run the Rust program
./binary_search $array_size

# Record the end time for Rust program
end_time_rust=$(date +%s.%N)

# Calculate the time difference for Rust program
time_difference_rust=$(echo "$end_time_rust - $start_time_rust" | bc)

# Print the time difference for C++ program
echo "Time taken by the Rust program: ${time_difference_rust} seconds"

echo
echo "----------------------------------------------------------------"
echo 


# Record the start time for Python program
start_time_py=$(date +%s.%N)

# Run the Python program
python3 binary_search.py $array_size

# Record the end time for Python program
end_time_py=$(date +%s.%N)

# Calculate the time difference for Python program
time_difference_py=$(echo "$end_time_py - $start_time_py" | bc)

# Print the time difference for Rust program
echo "Time taken by the Python program: ${time_difference_py} seconds"

echo
echo "----------------------------------------------------------------"
echo 

