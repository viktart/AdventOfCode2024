//
//  Day1.swift
//  AdventOfCode2024
//
//  Created by owel on 05/12/2024.
//

import Foundation

func dayOne(inputFileName: String) -> Int {
    // Reading
    let fileContent = readFile(inputFileName)
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
    
    // Solving
    left.sort()
    right.sort()
    
    var result = 0
    for i in 0..<left.count {
        result += abs(left[i] - right[i])
    }
    
    return result
}
