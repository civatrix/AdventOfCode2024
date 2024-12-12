//
//  Day11.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day11: Day {
    func run(input: String) -> String {
        var stones = input.allDigits
        
        for _ in 0 ..< 25 {
            var nextStones = [Int]()
            
            for stone in stones {
                if stone == 0 {
                    nextStones.append(1)
                } else if stone.description.count.isMultiple(of: 2) {
                    let string = stone.description
                    let midIndex = string.index(string.startIndex, offsetBy: string.count / 2)
                    nextStones.append(Int(string.prefix(upTo: midIndex))!)
                    nextStones.append(Int(string.suffix(from: midIndex))!)
                } else {
                    nextStones.append(stone * 2024)
                }
            }
            
            stones = nextStones
        }
        
        return stones.count.description
    }
}
