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
        
        var total = 0
        for plot in plots {
            var borders = plot.count * 4
            for cell in plot {
                borders -= cell.adjacent.filter { plot.contains($0) }.count
            }
            
            total += borders * plot.count
        }
        return total.description
    }
}
