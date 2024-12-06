//
//  Day6.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day6: Day {
    func run(input: String) -> String {
        var grid = Set<Point>()
        var position = Point.zero
        var direction = Point.up
        
        let lines = input.lines
        for (y, line) in lines.enumerated() {
            for (x, cell) in line.enumerated() {
                if cell == "#" {
                    grid.insert([x, y])
                } else if cell == "^" {
                    position = [x, y]
                }
            }
        }
        
        let xBoundary = 0 ..< lines[0].count
        let yBoundary = 0 ..< lines.count
        
        var visited = Set<Point>()
        while xBoundary.contains(position.x) && yBoundary.contains(position.y) {
            visited.insert(position)
            if grid.contains(position + direction) {
                direction = direction.rotate(clockwise: true)
            } else {
                position += direction
            }
        }
        
        return visited.count.description
    }
}
