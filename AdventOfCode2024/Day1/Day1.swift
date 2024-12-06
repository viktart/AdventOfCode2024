//
//  Day1.swift
//  AdventOfCode2024
//
//  Created by owel on 05/12/2024.
//

import Foundation

func dayOne(inputFileName: String) -> Int {
    // Reading
    var (left, right) = readInputFromFile(inputFileName)
    
    // Solving
    left.sort()
    right.sort()
    
    var result = 0
    for i in 0..<left.count {
        result += abs(left[i] - right[i])
    }
    
    return result
}
