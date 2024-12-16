//
//  Day16.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day16: Day {
    func run(input: String) -> String {
        var grid = Set<Point>()
        var start = Point.zero
        var end = Point.zero
        for (y, line) in input.lines.enumerated() {
            for (x, cell) in line.enumerated() {
                if cell == "#" {
                    grid.insert([x, y])
                } else if cell == "S" {
                    start = [x, y]
                } else if cell == "E" {
                    end = [x, y]
                }
            }
        }
        
        var path = AStar(graph: ReindeerMazeGraph(walls: grid), heuristic: { $0.position.distance(to: $1.position) })
            .path(start: Vector(position: start, direction: .right), target: Vector(position: end, direction: .up))
        while path[path.count - 2].position == end {
            path = path.dropLast()
        }
        
        return path.adjacentPairs().map { lhs, rhs in
            lhs.position == rhs.position ? 1000 : 1
        }.sum.description
    }
}

struct ReindeerMazeGraph: Graph {
    struct Edge: WeightedEdge {
        let cost: Int
        let target: Vector
    }
    
    let walls: Set<Point>
    
    func edgesOutgoing(from vertex: Vector) -> [Edge] {
        var edges = [
            Edge(cost: 1000, target: Vector(position: vertex.position, direction: vertex.direction.rotate(clockwise: true))),
            Edge(cost: 1000, target: Vector(position: vertex.position, direction: vertex.direction.rotate(clockwise: false)))
        ]
        if !walls.contains(vertex.nextStep()) {
            edges.append(Edge(cost: 1, target: Vector(position: vertex.nextStep(), direction: vertex.direction)))
        }
        
        return edges
    }
}
