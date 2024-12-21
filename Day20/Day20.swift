//
//  Day20.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day20: Day {
    var cheatThreshold = 100
    func run(input: String) -> String {
        var grid = Set<Point>()
        var walls = Set<Point>()
        var start = Point.zero
        var end = Point.zero
        for (y, line) in input.lines.enumerated() {
            for (x, cell) in line.enumerated() {
                switch cell {
                case "#": walls.insert([x, y])
                case ".": grid.insert([x, y])
                case "S": start = [x, y]
                case "E": end = [x, y]
                default: fatalError("Unknown cell \(cell)")
                }
            }
        }
        grid.insert(start)
        let maxX = walls.max()!.x
        let maxY = walls.max()!.y
        
        let aStar = AStar(graph: GridGraph(walls: walls), heuristic: Point.distance(between:and:))
        let defaultPath = aStar.path(start: start, target: end)
        let pathIndexes = [Point: Int](uniqueKeysWithValues: defaultPath.enumerated().map { ($0.element, $0.offset) })
        let cheats = grid.flatMap { point in
            Point.adjacentDirections
                .map { (point, point + ($0 * 2)) }
                .filter { !walls.contains($0.1) }
                .filter { $0.1.x > 0 && $0.1.y > 0 && $0.1.x < maxX && $0.1.y < maxY }
        }
        return cheats.map { (cheatStart, cheatEnd) in
            let startIndex = pathIndexes[cheatStart]!
            let endIndex = pathIndexes[cheatEnd]!
            return endIndex - startIndex - 2
        }
        .filter { $0 >= cheatThreshold }
        .count
        .description
    }
}
