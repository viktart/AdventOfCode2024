//
//  main.swift
//  AdventOfCode2024
//
//  Created by owel on 05/12/2024.
//

import Foundation

func readFile(_ fileName: String) -> String {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError()
    }
    return try! String(contentsOf: url, encoding: .utf8)
}

/// Returns: (left, right)
func parseTwoColumnsOfNumbers(_ fileContent: String) -> ([Int], [Int]) {
    let lines = fileContent.split(separator: "\n")
    var left = [Int]()
    var right = [Int]()
    left.reserveCapacity(lines.count)
    right.reserveCapacity(lines.count)
    lines.forEach {
        let numbers = $0.split(separator: " ")
        left.append(Int(numbers.first!)!)
        right.append(Int(numbers.last!)!)
    }
    return (left, right)
}

func parseLinesOfNumbers(_ fileContent: String) -> [[Int]] {
    let lines = fileContent.split(separator: "\n")
    var result: [[Int]] = []
    for line in lines {
        let numbers = line.split(separator: " ").compactMap { Int($0)! }
        result.append(numbers)
    }
    return result
}

func readDayOneInputFromFile(_ fileName: String) -> ([Int], [Int]) {
    let fileContent = readFile(fileName)
    return parseTwoColumnsOfNumbers(fileContent)
}

// MARK: - 

//let result = dayOne(inputFileName: "Day1_1.txt")
//let result = dayOnePartTwo(inputFileName: "Day1_1.txt")
//let result = DayTwo.partOne("Day2_1.txt")
//let result = DayTwo.partTwo("Day2_1.txt")
//let result = DayThree.partOne("Day3_1.txt")
//let result = DayThree.partTwo("Day3_1.txt")
//let result = DayFour.partOne("Day4_1.txt")
//let result = DayFour.partTwo("Day4_0_2.txt")
let result = DayFour.partTwo("Day4_1.txt")
//let result = DayFive.partOne("Day5_0.txt")
print(result)
