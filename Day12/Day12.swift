//
//  Day12.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day12: Day {
    var grid = [Character: Set<Point>]()
    func run(input: String) -> String {
        for (y, line) in input.lines.enumerated() {
            for (x, cell) in line.enumerated() {
                grid[cell, default: []].insert([x, y])
            }
        }
        
        var plots = Set<Set<Point>>()
        for var plot in grid.values {
            while let seedCell = plot.popFirst() {
                var toVisit: Set<Point> = [seedCell]
                var visited = Set<Point>()
                while let cell = toVisit.popFirst() {
                    visited.insert(cell)
                    plot.remove(cell)
                    toVisit.formUnion(cell.adjacent.filter { plot.contains($0) })
                }
                plots.insert(visited)
            }
        }
        
        return plots.map { plot in
            var borderCells = Set<Point>()
            for cell in plot where cell.adjacent.filter({ plot.contains($0) }).count < 4 {
                borderCells.insert(cell)
            }
            var crawledCells = Set<Point>()
            var edges = 0
            while let start = borderCells.subtracting(crawledCells).min() {
                let startingDirection: Point
                if !plot.contains(start + .up) {
                    startingDirection = .right
                } else if !plot.contains(start + .right) {
                    startingDirection = .down
                } else if !plot.contains(start + .down) {
                    startingDirection = .left
                } else {
                    startingDirection = .up
                }
                var crawler = (location: start + startingDirection.rotate(clockwise: false), direction: startingDirection, touching: startingDirection.rotate(clockwise: true))
                let startLocation = crawler.location
                repeat {
                    crawledCells.insert(crawler.location + crawler.touching)
                    if borderCells.contains(crawler.location + crawler.direction) {
                        crawler.direction = crawler.direction.rotate(clockwise: false)
                        crawler.touching = crawler.touching.rotate(clockwise: false)
                        edges += 1
                    } else if !borderCells.contains(crawler.location + crawler.direction + crawler.touching) {
                        crawler.location = crawler.location + crawler.direction + crawler.touching
                        crawler.direction = crawler.direction.rotate(clockwise: true)
                        crawler.touching = crawler.touching.rotate(clockwise: true)
                        edges += 1
                    } else {
                        crawler.location += crawler.direction
                    }
                } while !(crawler.location == startLocation && crawler.direction == startingDirection)
            }
            
            return edges * plot.count
        }
        .sum
        .description
    }
}
