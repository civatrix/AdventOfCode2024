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
        
        let graph = ReindeerMazeGraph(walls: grid)
        let startEdge = ReindeerMazeGraph.Edge(cost: 0, target: .init(position: start, direction: .right))
        var toExplore: [(ReindeerMazeGraph.Edge, [[ReindeerMazeGraph.Edge]])] = [(startEdge, [[startEdge]])]
        var paths = [[ReindeerMazeGraph.Edge]]()
        var cache = [Vector: Int]()
        var bestCost = 102504
        while let next = toExplore.popLast() {
            let from = next.0
            let soFar = next.1
            if let cacheCost = cache[from.target], (cacheCost < from.cost || from.cost > bestCost) {
                continue
            }
            cache[from.target] = from.cost
            if from.target.position == end {
                bestCost = min(bestCost, from.cost)
                paths.append(contentsOf: soFar)
                continue
            }
            
            for edge in graph.edgesOutgoing(from: from) {
                toExplore.append((edge, soFar.map { $0 + [edge] }))
            }
        }
        return Set(paths
            .filter { $0.last?.cost == bestCost }
            .flatMap { $0.map { $0.target.position } })
            .count
            .description
    }
}

struct ReindeerMazeGraph {
    struct Edge: WeightedEdge {
        let cost: Int
        let target: Vector
    }
    
    let walls: Set<Point>
    
    func edgesOutgoing(from edge: Edge) -> [Edge] {
        var edges = [Edge]()
        let clockwise = edge.target.direction.rotate(clockwise: true)
        let counterclockwise = edge.target.direction.rotate(clockwise: false)
        
        if !walls.contains(edge.target.position + clockwise) {
            edges.append(Edge(cost: edge.cost + 1001, target: Vector(position: edge.target.position + clockwise, direction: clockwise)))
        }
        if !walls.contains(edge.target.position + counterclockwise) {
            edges.append(Edge(cost: edge.cost + 1001, target: Vector(position: edge.target.position + counterclockwise, direction: counterclockwise)))
        }
        if !walls.contains(edge.target.nextStep()) {
            edges.append(Edge(cost: edge.cost + 1, target: Vector(position: edge.target.nextStep(), direction: edge.target.direction)))
        }
        
        return edges
    }
}
