//
//  Day5.swift
//  AdventOfCode2024
//
//  Created by owel on 13/01/2025.
//

import Foundation

class DayFive {
    static func readDayFiveInput(_ fileName: String) -> ([(Int,Int)], [[Int]]) {
        let fileContent = readFile(fileName)
        let lines = fileContent.split(separator: "\n", omittingEmptySubsequences: false)
        var lineNumber = 0
        // parse rules
        var rules: [(Int, Int)] = []
        while lines[lineNumber].count > 2 {
            let line = lines[lineNumber]
            let numbers = line.split(separator: "|")
            let left = Int(numbers.first!)!
            let right = Int(numbers.last!)!
            rules.append((left, right))
            lineNumber += 1
        }
        // parse updates
        lineNumber += 1
        var updates: [[Int]] = []
        while lineNumber < lines.count {
            let line = lines[lineNumber]
            let numbers = line.split(separator: ",")
            let update: [Int] = numbers.map { Int($0)! }
            updates.append(update)
            lineNumber += 1
        }
        
        return (rules, updates)
    }
    
    static func partOne(_ fileName: String) -> Int {
        let (rules, updates) = readDayFiveInput(fileName)
        
        var ruleTable: [Int: [Int]] = [:]
        for (first, second) in rules {
            if ruleTable[first] == nil {
                ruleTable[first] = [second]
            } else {
                ruleTable[first] = ruleTable[first]! + [second]
            }
        }
        
        var correctUpdates: [[Int]] = []
        
        for update in updates {
            var isCorrectUpdate = true
            numberCycle: for numberIndex in 0..<update.count {
                let number = update[numberIndex]
                for prevNumberIndex in 0..<numberIndex {
                    let prevNumber = update[prevNumberIndex]
                    if ruleTable[number]?.contains(prevNumber) == true {
                        isCorrectUpdate = false
                        break numberCycle
                    }
                }
            }
            
            if isCorrectUpdate {
                correctUpdates.append(update)
            }
        }
        
        var result = 0
        
        for update in correctUpdates {
            guard !update.isEmpty else {
                continue
            }
            result += update[update.count / 2]
        }
        
        return result
    }
}
