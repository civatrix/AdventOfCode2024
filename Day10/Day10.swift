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
        
        return trailheads.map { destinations(from: $0) }.sum.description
    }
    
    var cache: [Point: Int] = [:]
    func destinations(from: Point) -> Int {
        if let hit = cache[from] {
            return hit
        }
        if map[from] == 9 {
            return 1
        }
        
        let nextElevation = map[from]! + 1
        let result = from.adjacent
            .filter { map[$0, default: -1] == nextElevation }
            .map { destinations(from: $0) }
            .sum
        cache[from] = result
        return result
    }
}
