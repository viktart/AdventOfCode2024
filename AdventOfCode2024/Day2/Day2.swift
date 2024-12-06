//
//  Day2.swift
//  AdventOfCode2024
//
//  Created by owel on 06/12/2024.
//

import Foundation

class DayTwo {
    
    static private func findFirstUnsafeIndex(_ line: [Int]) -> Int? {
        findFirstUnsafeIndex(line[0..<line.count])
    }
    
    static private func findFirstUnsafeIndex(_ line: ArraySlice<Int>) -> Int? {
        guard !line.isEmpty else {
            return -1
        }
        guard line.count > 1 else {
            return nil
        }
        guard line[line.startIndex] != line[line.startIndex + 1] else {
            return line.startIndex
        }
        
        let isAscending = line[line.startIndex] < line[line.startIndex + 1]
        if abs(line[line.startIndex] - line[line.startIndex + 1]) > 3 {
            return line.startIndex
        }
        
        for i in line.startIndex + 2 ..< line.endIndex {
            if line[i - 1] == line[i] {
                return i - 1
            }
            let currentAscending = line[i - 1] < line[i]
            if isAscending != currentAscending {
                return i - 1
            }
            if abs(line[i - 1] - line[i]) > 3 {
                return i - 1
            }
        }
        
        return nil
    }
    
    static func partOne(_ inputFileName: String) -> Int {
        let fileContent = readFile(inputFileName)
        let numbers = parseLinesOfNumbers(fileContent)
        let result = numbers.reduce(0) { partialResult, line in
            return findFirstUnsafeIndex(line) == nil ? partialResult + 1 : partialResult
        }
        return result
    }
    
    static func partTwo(_ inputFileName: String) -> Int {
        let fileContent = readFile(inputFileName)
        let numbers = parseLinesOfNumbers(fileContent)
        let result = numbers.reduce(0) { partialResult, line in
            
            func excludeAndCheck(index: Int) -> Bool {
                var newLine = line
                newLine.remove(at: index)
                let unsafeIndex = findFirstUnsafeIndex(newLine)
                return unsafeIndex == nil
            }
            
            if findFirstUnsafeIndex(line) == nil {
                return partialResult + 1
            }
            if findFirstUnsafeIndex(line[1..<line.count]) == nil {
                return partialResult + 1
            }
            if excludeAndCheck(index: line.startIndex + 1) {
                return partialResult + 1
            }
            
            guard let unsafeIndex = findFirstUnsafeIndex(line) else {
                fatalError("Programming error")
            }
            guard unsafeIndex > line.startIndex else {
                return partialResult
            }
            
            if excludeAndCheck(index: unsafeIndex) || excludeAndCheck(index: unsafeIndex + 1) {
                return partialResult + 1
            }

            return partialResult
        }
        
        return result
    }
}
