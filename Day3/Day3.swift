//
//  Day3.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation
import RegexBuilder

final class Day3: Day {
    func run(input: String) -> String {
        let regex = Regex {
            "mul("
            TryCapture {
                OneOrMore(.digit)
            } transform: { str -> Int? in
                guard str.count <= 3 else { return nil }
                return Int(str)
            }
            ","
            TryCapture {
                OneOrMore(.digit)
            } transform: { str -> Int? in
                guard str.count <= 3 else { return nil }
                return Int(str)
            }
            ")"
        }
        
        let doIndexes = input.ranges(of: "do()").map { $0.lowerBound }
        let dontIndexes = input.ranges(of: "don't()").map { $0.lowerBound }
        
        return input.matches(of: regex).map { match in
            let doIndex = doIndexes.last { $0 < match.range.lowerBound } ?? input.startIndex
            guard let dontIndex = dontIndexes.last(where: { $0 < match.range.lowerBound }) else {
                return match.output.1 * match.output.2
            }
            if doIndex > dontIndex {
                return match.output.1 * match.output.2
            } else {
                return 0
            }
        }
        .sum
        .description
    }
}
