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
        return lines.map { line in
            canMake(pattern: line, from: towels)
        }.sum.description
    }
    
    var cache = [String: Int]()
    func canMake(pattern: any StringProtocol, from towels: [String]) -> Int {
        guard !pattern.isEmpty else {
            return 1
        }
        if let cacheHit = cache[String(pattern)] {
            return cacheHit
        }
        let result = towels
            .filter { pattern.starts(with: $0) }
            .map { towel in
                canMake(pattern: pattern.dropFirst(towel.count), from: towels)
            }.sum
        cache[String(pattern)] = result
        return result
    }
}
