//
//  Day4.swift
//  AdventOfCode2024
//
//  Created by owel on 06/01/2025.
//

import Foundation

class DayFour {
    
    static func readDayFourInputFromFile(_ fileName: String) -> [[Int]] {
        let s = readFile(fileName)
        let lines = s.split(separator: "\n")
        let intTable = lines.map {
            $0.utf8.map { Int($0) }
        }
        return intTable
    }
    
    static func partOne(_ fileName: String) -> Int {
        let xmas = "XMAS".utf8.map { Int($0) }
        let input = readDayFourInputFromFile(fileName)
        var result = 0
        
        func isXmas(i: Int, j: Int, iSign: (Int, Int) -> Int, jSign: (Int, Int) -> Int) -> Bool {
            var ii = i, jj = j, count = 0
            while 0 <= ii, ii < input.count, 0 <= jj, jj < input[ii].count, count < xmas.count {
                guard input[ii][jj] == xmas[count] else {
                    return false
                }
                count += 1
                ii = iSign(ii, 1)
                jj = jSign(jj, 1)
            }
            return count == xmas.count
        }
        
        func noop(_ x: Int, _ y: Int) -> Int {
            return x
        }
        
        func countFromPos(i: Int, j: Int) -> Int {
            var result = 0
            func check(_ iSign: (Int, Int) -> Int, _ jSign: (Int, Int) -> Int) {
                result += isXmas(i: i, j: j, iSign: iSign, jSign: jSign) ? 1 : 0
            }
            check(noop, +)
            check(+, +)
            check(+, noop)
            check(-, -)
            check(noop, -)
            check(-, -)
            check(-, noop)
            check(+, -)
            return result
        }
        
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                result += countFromPos(i: i, j: j)
            }
        }
        
        return result
    }
}
