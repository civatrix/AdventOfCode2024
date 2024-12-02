//
//  Day2.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day2: Day {
    func run(input: String) -> String {
        return input.lines
            .map { $0.allDigits }
            .map {
                let increasing = $0.first! < $0.last!
                for pair in $0.adjacentPairs() {
                    if increasing && pair.0 > pair.1 {
                        return 0
                    } else if !increasing && pair.0 < pair.1 {
                        return 0
                    }
                    let difference = abs(pair.0 - pair.1)
                    if !(1...3).contains(difference) {
                        return 0
                    }
                }
                return 1
            }
            .sum.description
    }
}
