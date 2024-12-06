//
//  Day2.swift
//  AdventOfCode2024
//
//  Created by owel on 06/12/2024.
//

import Foundation

func dayOnePartTwo(inputFileName: String) -> Int {
    var (left, right) = readInputFromFile(inputFileName)
    var result = 0
    
    right.sort()
    for leftElement in left {
        guard var rightIndex = right.binarySearch(leftElement) else {
            continue
        }
        while rightIndex > 0 && right[rightIndex - 1] == leftElement {
            rightIndex -= 1
        }
        while rightIndex < right.count && right[rightIndex] == leftElement {
            result += leftElement
            rightIndex += 1
        }
    }
    
    return result
}


extension Array where Element: Comparable {
    /// Finds any index of an element in the sorted array
    func binarySearch(_ element: Element) -> Int? {
        var left = 0
        var n = self.count
        while n > 0 {
            let middleIndex = left + n / 2
            let middleElement = self[middleIndex]
            if middleElement == element {
                return middleIndex
            } else if middleElement < element { // right half
                left = middleIndex + 1
                n = n / 2 - (n - 1) % 2
            } else if middleElement > element { // left half
                n = n / 2
            }
        }
        
        return nil
    }
}
