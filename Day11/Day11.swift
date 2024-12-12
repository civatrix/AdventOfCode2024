//
//  Day11.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day11: Day {
    func run(input: String) -> String {
        var mapping = [Int: Int]()
        for stone in input.allDigits {
            mapping[stone, default: 0] += 1
        }
        
        for _ in 0 ..< 75 {
            var newMapping = [Int: Int]()
            for (stone, count) in mapping {
                if stone == 0 {
                    newMapping[1, default: 0] += count
                } else if stone.description.count.isMultiple(of: 2) {
                    let string = stone.description
                    let midIndex = string.index(string.startIndex, offsetBy: string.count / 2)
                    newMapping[Int(string.prefix(upTo: midIndex))!, default: 0] += count
                    newMapping[Int(string.suffix(from: midIndex))!, default: 0] += count
                } else {
                    newMapping[stone * 2024, default: 0] += count
                }
            }
            mapping = newMapping
        }
        
        return mapping.values.sum.description
    }
}
