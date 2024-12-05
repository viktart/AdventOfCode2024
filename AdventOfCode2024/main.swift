//
//  main.swift
//  AdventOfCode2024
//
//  Created by owel on 05/12/2024.
//

import Foundation

func readFile(_ fileName: String) -> String {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError()
    }
    return try! String(contentsOf: url, encoding: .utf8)
}

let result = dayOne(inputFileName: "Day1_1.txt")
print(result)
