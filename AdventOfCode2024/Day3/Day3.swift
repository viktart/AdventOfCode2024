//
//  Day3.swift
//  AdventOfCode2024
//
//  Created by owel on 08/12/2024.
//

import Foundation
import RegexBuilder

class DayThree {
    static func partOne(_ fileName: String) -> Int {
        let input = readFile(fileName)
        let regex = /mul\((\d+),(\d+)\)/
        let ranges = input.ranges(of: regex)
        
        let result =
        ranges
            .map { range in
                input[range]
            }
            .map { mulExpression -> (Int, Int) in
                let s = String(mulExpression)
                let result = try! regex.wholeMatch(in: s)
                let a = Int(result!.1)!
                let b = Int(result!.2)!
                return (a, b)
            }
        //            .reduce(0) { partialResult, pair in
        //                return partialResult += 1
        //            }
        
        var sum = 0
        for iPair in result {
            sum += iPair.0 * iPair.1
        }
        
        return sum
    }
    
    static func partTwo(_ fileName: String) -> Int {
        let input = readFile(fileName)
        let regex = /do\(\)|don't\(\)|mul\((\d+),(\d+)\)/
        let ranges = input.ranges(of: regex)
        
        let commands =
        ranges
            .map { range in
                input[range]
            }
        
        var sum = 0
        var shouldMultiply = true
        for command in commands {
            if command == "do()" {
                shouldMultiply = true
            } else if command == "don't()" {
                shouldMultiply = false
            } else { // it's mul
                guard shouldMultiply else {
                    continue
                }
                let mulExpression = String(command)
                let mulMatch = try! regex.wholeMatch(in: mulExpression)
                let a = Int(mulMatch!.1!)!
                let b = Int(mulMatch!.2!)!
                sum += a * b
            }
        }
        
        return sum
    }
}
