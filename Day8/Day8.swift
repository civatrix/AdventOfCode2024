//
//  Day8.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day8: Day {
    func run(input: String) -> String {
        var antennaeMap = [Character: Set<Point>]()
        
        let lines = input.lines
        for (y, line) in lines.enumerated() {
            for (x, cell) in line.enumerated() where cell != "." {
                antennaeMap[cell, default: []].insert([x, y])
            }
        }
        
        let xBoundary = 0 ..< lines[0].count
        let yBoundary = 0 ..< lines.count
        
        var antinodes = Set<Point>()
        for antennae in antennaeMap.values {
            for pair in antennae.combinations(ofCount: 2) {
                let minNode = min(pair[0], pair[1])
                let maxNode = max(pair[0], pair[1])
                let vector = maxNode - minNode
                let node1 = minNode - vector
                if xBoundary.contains(node1.x) && yBoundary.contains(node1.y) {
                    antinodes.insert(node1)
                }
                let node2 = maxNode + vector
                if xBoundary.contains(node2.x) && yBoundary.contains(node2.y) {
                    antinodes.insert(node2)
                }
            }
        }
        
        return antinodes.count.description
    }
}
