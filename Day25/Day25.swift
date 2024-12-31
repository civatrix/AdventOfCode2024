//
//  Day25.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day25: Day {
    func run(input: String) -> String {
        var keys = [[Int]]()
        var locks = [[Int]]()
        
        for chunk in input.split(separator: "\n\n") {
            let grid = chunk.parseGrid()
            if grid.contains([0, 0]) {
                var lock = [Int]()
                for column in 0 ..< 5 {
                    lock.append(grid.filter { $0.x == column }.map { $0.y }.max()!)
                }
                locks.append(lock)
            } else if grid.contains([0, 6]) {
                var key = [Int]()
                for column in 0 ..< 5 {
                    key.append(6 - grid.filter { $0.x == column }.map { $0.y }.min()!)
                }
                keys.append(key)
            } else {
                fatalError("Unknown chunk \(chunk)")
            }
        }
        
        var total = 0
        for key in keys {
            for lock in locks {
                let overlaps = (0 ..< 5).contains { key[$0] + lock[$0] >= 6 }
                if !overlaps {
                    total += 1
                }
            }
        }
        return total.description
    }
}
