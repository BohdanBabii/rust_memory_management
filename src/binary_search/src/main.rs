extern crate rand;
use rand::seq::SliceRandom;
use rand::Rng; // Add this line to bring the Rng trait into scope
use std::cmp::Ordering;

// Binary search function
fn binary_search(arr: &[i32], target: i32) -> Option<usize> {
    let mut left = 0;
    let mut right = arr.len() - 1;

    while left <= right {
        let mid = left + (right - left) / 2;

        match arr[mid].cmp(&target) {
            Ordering::Equal => return Some(mid), // Element found
            Ordering::Less => left = mid + 1,     // Adjust the search range to the right
            Ordering::Greater => right = mid - 1, // Adjust the search range to the left
        }
    }

    None // Element not found
}

fn main() {
    // Parse the array size if provided as a command-line argument
    let args: Vec<String> = std::env::args().collect();
    let size = if args.len() > 1 {
        args[1].parse().unwrap_or(10) // Default size is 10 if not provided
    } else {
        10 // Default size is 10 if no arguments are provided
    };

    // Generate a random array
    let mut arr: Vec<i32> = (1..=size as i32).collect();
    arr.shuffle(&mut rand::thread_rng());

    // Sort the array (binary search requires a sorted array)
    arr.sort();

    // Choose a random element to search for
    let target = rand::thread_rng().gen_range(0..size);

    // Perform binary search
    match binary_search(&arr, target) {
        Some(index) => println!("Element {} found at index {}", target, index),
        None => println!("Element {} not found", target),
    }
}
