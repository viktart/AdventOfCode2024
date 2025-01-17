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
    
    private static func checkWord(input: [[Int]], word: String, i: Int, j: Int, iSign: (Int, Int) -> Int, jSign: (Int, Int) -> Int) -> Bool {
        let word = word.utf8.map { Int($0) }
        var ii = i, jj = j, count = 0
        while 0 <= ii, ii < input.count, 0 <= jj, jj < input[ii].count, count < word.count {
            guard input[ii][jj] == word[count] else {
                return false
            }
            count += 1
            ii = iSign(ii, 1)
            jj = jSign(jj, 1)
        }
        return count == word.count
    }
    
    private static func noop(_ x: Int, _ y: Int) -> Int {
        return x
    }
    
    static func partOne(_ fileName: String) -> Int {
        let input = readDayFourInputFromFile(fileName)
        var result = 0
        
        func countFromPos(i: Int, j: Int) -> Int {
            var result = 0
            func check(_ iSign: (Int, Int) -> Int, _ jSign: (Int, Int) -> Int) {
                result += checkWord(input: input, word: "XMAS", i: i, j: j, iSign: iSign, jSign: jSign) ? 1 : 0
            }
            check(noop, +)
            check(+, noop)
            check(+, +)
            check(-, -)
            check(noop, -)
            check(-, noop)
            check(+, -)
            check(-, +)
            return result
        }
        
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                result += countFromPos(i: i, j: j)
            }
        }
        
        return result
    }
    
    // MARK: - Part Two
    
    static func partTwo(_ fileName: String) -> Int {
        let input = readDayFourInputFromFile(fileName)
        var result = 0
        let passString = "MAS"
        let pass = passString.utf8.map { Int($0) }
        
        /// Is it the center of the cross?
        func checkPos(i: Int, j: Int) -> Int {
            var result = 0
            
            func check(_ iDir1: Bool, _ jDir1: Bool, _ iDir2: Bool, _ jDir2: Bool) {
                let passDelta = pass.count / 2
                
                func checkDelta(_ iDir: Bool, _ jDir: Bool) -> Bool {
                    let iSReverse = (!iDir).sign
                    let jSReverse = (!jDir).sign
                    let newPos = (iSReverse(i, passDelta), jSReverse(j, passDelta))
                    return checkWord(input: input, word: passString, i: newPos.0, j: newPos.1, iSign: iDir.sign, jSign: jDir.sign)
                }
                
                if checkDelta(iDir1, jDir1) && checkDelta(iDir2, jDir2) {
                    result += 1
                }
            }
            
//            check(+, +, -, +)
//            check(+, +, +, -)
//            check(-, +, -, -)
//            check(+, -, -, -)
            check(true, true, false, true)
            check(true, true, true, false)
            check(false, true, false, false)
            check(true, false, false, false)
            
            assert(result < 2)
            
            return result
        }
        
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                result += checkPos(i: i, j: j)
            }
        }
        
        return result
    }
}

fileprivate typealias Sign = (Int, Int) -> Int

fileprivate extension Bool {
    var sign: Sign {
        self ? (+) : (-)
    }
}
