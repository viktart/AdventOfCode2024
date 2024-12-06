//
//  Day2.swift
//  AdventOfCode2024
//
//  Created by owel on 06/12/2024.
//

import Foundation

func dayTwoPartOne(_ inputFileName: String) -> Int {
    let fileContent = readFile(inputFileName)
    let numbers = parseLinesOfNumbers(fileContent)
    let result = numbers.reduce(0) { partialResult, line in
        guard !line.isEmpty else {
            return partialResult
        }
        guard line.count > 1 else {
            return partialResult + 1
        }
        guard line[0] != line[1] else {
            return partialResult
        }
        
        let isAscending = line[0] < line[1]
        if abs(line[0] - line[1]) > 3 {
            return partialResult
        }
        
        for i in 2..<line.count {
            if line[i - 1] == line[i] {
                return partialResult
            }
            let currentAscending = line[i - 1] < line[i]
            if isAscending != currentAscending {
                return partialResult
            }
            if abs(line[i - 1] - line[i]) > 3 {
                return partialResult
            }
        }
        
        return partialResult + 1
    }
    return result
}
