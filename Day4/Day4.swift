//
//  Day4.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day4: Day {
    let target = "XMAS".map { $0 }
    
    func run(input: String) -> String {
        let grid = input.lines.map { $0.map { $0 }}
        var x = 0
        var y = 0
        var count = 0
        while y < grid.count {
            x = 0
            while x < grid[y].count {
                count += search(input: grid, for: target, at: [x, y])
                x += 1
            }
            y += 1
        }
        
        return count.description
    }
    
    func search(input: [[Character]], for target: [Character], at: Point) -> Int {
        guard at.value(in: input) == target.first else {
            return 0
        }
        
        return Point.allDirections.filter { direction in
            for index in target.indices.dropFirst() {
                let current = at + (direction * index)
                guard current.value(in: input) == target[index] else {
                    return false
                }
            }
            
            return true
        }.count
    }
}
