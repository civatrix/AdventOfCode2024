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
        var start = Vector(position: .zero, direction: .up)
        
        let lines = input.lines
        for (y, line) in lines.enumerated() {
            for (x, cell) in line.enumerated() {
                if cell == "#" {
                    grid.insert([x, y])
                } else if cell == "^" {
                    start.position = [x, y]
                }
            }
        }
        
        let xBoundary = 0 ..< lines[0].count
        let yBoundary = 0 ..< lines.count
        
        var visited = Set<Vector>()
        var current = start
        while xBoundary.contains(current.position.x) && yBoundary.contains(current.position.y) {
            visited.insert(current)
            if grid.contains(current.nextStep()) {
                current = current.rotate(clockwise: true)
            } else {
                current.position = current.nextStep()
            }
        }
        
        visited.remove(start)
        
        let group = DispatchGroup()
        var obstacles = Set<Point>()
        for point in visited.map({ $0.position }) {
            DispatchQueue.global().async {
                group.enter()
                var newGrid = grid
                newGrid.insert(point)
                
                var newVisited = Set<Vector>()
                var newCurrent = start
                while xBoundary.contains(newCurrent.position.x) && yBoundary.contains(newCurrent.position.y) {
                    if newVisited.contains(newCurrent) {
                        break
                    }
                    newVisited.insert(newCurrent)
                    if newGrid.contains(newCurrent.nextStep()) {
                        newCurrent = newCurrent.rotate(clockwise: true)
                    } else {
                        newCurrent.position = newCurrent.nextStep()
                    }
                }
                
                if newVisited.contains(newCurrent) {
                    DispatchQueue.main.async {
                        obstacles.insert(point)
                    }
                }
                group.leave()
            }
        }
        
        group.wait()
        return obstacles.count.description
    }
}
