// ReverseString.swift
//
// Created by Remy Skelton
// Created on 2025-April-12
// Version 1.0
// Copyright (c) Remy Skelton. All rights reserved.
//
// This program will read an multiple lines of strings from the a input file.
// It will then reverse those string using recursion and
// print the reversed strings to the output file.

// Import Foundation
import Foundation

// Define the InputError enum to handle errors
enum InputError: Error {
    case invalidInput
}

// Do catch block to catch any errors
do {
    // Welcome message
    print("Welcome to the Reverse String program!")
    print("This program reads multiple lines,", terminator: " ")
    print(" of strings from input.txt, reverses them, and ", terminator: " ")
    print("writes the result to output.txt.")

    // Initialize output string
    var outputStr = ""

    // Define the file paths
    let inputFile = "input.txt"
    let outputFile = "output.txt"

    // Open the input file for reading
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        throw InputError.invalidInput
    }

    // Read the contents of the input file
    let inputData = input.readDataToEndOfFile()

    // Convert the data to a string
    guard let inputStr = String(data: inputData, encoding: .utf8) else {
        // Throw an error if the data cannot be converted to a string
        throw InputError.invalidInput
    }

    // Split the input string into lines
    let inputLines = inputStr.components(separatedBy: "\n")

    // Create position variable
    var position = 0


    // While loop to read each line
    while position < inputLines.count {
        // Get the current line
        let currentLine = inputLines[position]

        // Reverse the current line using recursion
        let reversedLine = recReverse(word: currentLine)

        // Append the reversed line to the output string
        outputStr += "The reverse of "
                    + currentLine + " is "
                    + reversedLine + "\n"

        // Increment the position
        position += 1
    }

    // Write to output.txt
    try outputStr.write(toFile: outputFile, atomically: true, encoding: .utf8)

    // Print the output string
    print("Reverse written to output.txt.")

} catch {
    // Print the error message
    print("Error: \(error)")
}

// Function to to reverse a string using recursion
func recReverse(word : String) -> String {
    // Base case: if the string is empty
    if word.isEmpty {
        // Return an empty string if the word is empty
        return word
    } else {
        // Call recReverse without the first character
        // and add the first character to the end
        let index = word.index(after: word.startIndex)
        return recReverse(word: String(word[index...])) + String(word[word.startIndex])

    }
}