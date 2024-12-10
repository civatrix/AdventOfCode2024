//
//  Day10.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day10: Day {
    var map = [Point: Int]()
    func run(input: String) -> String {
        var trailheads = [Point]()
        for (y, line) in input.lines.enumerated() {
            for (x, cell) in line.enumerated() {
                map[[x, y]] = cell.wholeNumberValue ?? -1
                if cell == "0" {
                    trailheads.append([x, y])
                }
            }
        }
        
        return trailheads.map { destinations(from: $0).count }.sum.description
    }
    
    func destinations(from: Point) -> Set<Point> {
        if map[from] == 9 {
            return [from]
        }
        
        let nextElevation = map[from]! + 1
        return from.adjacent
            .filter { map[$0, default: -1] == nextElevation }
            .map { destinations(from: $0) }
            .reduce(into: [], { $0.formUnion($1) })
    }
}
