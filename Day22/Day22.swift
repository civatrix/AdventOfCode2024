//
//  Day22.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day22: Day {
    func run(input: String) -> String {
        return input.lines.map { line in
            var value = Int(line)!
            for _ in 0 ..< 2000 {
                value = nextSecretNumber(value)
            }
            return value
        }
        .sum
        .description
    }
    
    func nextSecretNumber(_ initial: Int) -> Int {
        var next = initial
        next ^= initial << 6
        next &= 16777215
        next ^= next >> 5
        next &= 16777215
        next ^= next << 11
        next &= 16777215
        
        return next
    }
}
