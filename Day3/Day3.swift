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
        
        return input.matches(of: regex).map { match in
            match.output.1 * match.output.2
        }
        .sum
        .description
    }
}
