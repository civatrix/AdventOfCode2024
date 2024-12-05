//
//  Day5.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day5: Day {
    func run(input: String) -> String {
        var before = [Int: Set<Int>]()
        return input.lines.map { $0.allDigits }.map { line in
            if line.count == 2 {
                before[line[1], default: []].insert(line[0])
            } else {
                let isCorrect = line.indices.allSatisfy { before[line[$0], default: []].isSuperset(of: line.prefix(upTo: $0)) }
                
                if !isCorrect {
                    let sorted = line.sorted { before[$0, default: []].contains($1) }
                    return sorted[sorted.count / 2]
                }
            }
            return 0
        }.sum.description
    }
}
