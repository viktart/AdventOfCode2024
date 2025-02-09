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
    
    /// key is the number and value is an array containing all the number that should follow it in an update
    private static func buildRuleTable(rules: [(Int, Int)]) -> [Int: [Int]] {
        var ruleTable: [Int: [Int]] = [:]
        for (first, second) in rules {
            if ruleTable[first] == nil {
                ruleTable[first] = [second]
            } else {
                ruleTable[first] = ruleTable[first]! + [second]
            }
        }
        return ruleTable
    }
    
    private static func isCorrectPair(ruleTable: [Int: [Int]], _ a: Int, _ b: Int) -> Bool {
        return ruleTable[b]?.contains(a) != true
    }
    
    private static func findCorrectUpdates(ruleTable: [Int: [Int]], updates: [[Int]]) -> [[Int]] {
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
        
        return correctUpdates
    }
    
    static func partOne(_ fileName: String) -> Int {
        let (rules, updates) = readDayFiveInput(fileName)
        let ruleTable = buildRuleTable(rules: rules)
        
        let correctUpdates = findCorrectUpdates(ruleTable: ruleTable, updates: updates)
        
        var result = 0
        for update in correctUpdates {
            guard !update.isEmpty else {
                continue
            }
            result += update[update.count / 2]
        }
        
        return result
    }
    
    private static func bubbleSort<T: Comparable>(_ a: inout [T]) {
        for i in 0..<a.count {
            for j in i+1..<a.count {
                if a[j] > a[i] {
                    a.swapAt(i, j)
                }
            }
        }
    }
    
    static func partTwo(_ fileName: String) -> Int {
        let (rules, updates) = readDayFiveInput(fileName)
        
        let ruleTable = buildRuleTable(rules: rules)
        let correctUpdates = findCorrectUpdates(ruleTable: ruleTable, updates: updates)
        var inCorrectUpdates = updates.filter { !correctUpdates.contains($0) }
        
        inCorrectUpdates = inCorrectUpdates.map { update in
            return update.sorted {
                isCorrectPair(ruleTable: ruleTable, $0, $1)
            }
        }
        
        var result = 0
        result = inCorrectUpdates.reduce(into: 0) { partialResult, update in
            partialResult = partialResult + update[update.count / 2]
        }
        
        return result
    }
}
