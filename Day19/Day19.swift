//
//  Day19.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day19: Day {
    func run(input: String) -> String {
        var lines = input.lines
        let towels = lines.removeFirst().components(separatedBy: ", ")
        return lines.filter { line in
            canMake(pattern: line, from: towels)
        }.count.description
    }
    
    func canMake(pattern: any StringProtocol, from towels: [String]) -> Bool {
        guard !pattern.isEmpty else {
            return true
        }
        for towel in towels where pattern.starts(with: towel) {
            if canMake(pattern: pattern.dropFirst(towel.count), from: towels) {
                return true
            }
        }
        
        return false
    }
}
