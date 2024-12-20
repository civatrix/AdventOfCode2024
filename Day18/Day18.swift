//
//  Day18.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day18: Day {
    var gridSize = 70
    var dropCount = 1024
    func run(input: String) -> String {
        var walls = Set<Point>()
        for index in 0 ... gridSize {
            walls.insert([index, -1])
            walls.insert([-1, index])
            walls.insert([index, gridSize + 1])
            walls.insert([gridSize + 1, index])
        }
        for line in input.lines.prefix(dropCount) {
            let numbers = line.allDigits
            walls.insert([numbers[0], numbers[1]])
        }
        
        return (AStar(graph: GridGraph(walls: walls), heuristic: Point.distance(between:and:))
            .path(start: .zero, target: [gridSize, gridSize])
            .count - 1).description
    }
}
