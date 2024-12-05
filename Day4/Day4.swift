//
//  Day4.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day4: Day {
    func run(input: String) -> String {
        let grid = input.lines.map { $0.map { $0 }}
        var x = 0
        var y = 0
        var count = 0
        while y < grid.count {
            x = 0
            while x < grid[y].count {
                if search(input: grid, at: [x, y]) {
                    count += 1
                }
                x += 1
            }
            y += 1
        }
        
        return count.description
    }
    
    func search(input: [[Character]], at: Point) -> Bool {
        guard at.value(in: input) == "A" else {
            return false
        }
        
        let topLeft = (at + .left + .up).value(in: input)
        let bottomLeft = (at + .left + .down).value(in: input)
        let topRight = (at + .right + .up).value(in: input)
        let bottomRight = (at + .right + .down).value(in: input)
        
        return ((topLeft == "M" && bottomRight == "S") || (topLeft == "S" && bottomRight == "M")) && ((topRight == "M" && bottomLeft == "S") || (topRight == "S" && bottomLeft == "M"))
    }
}
