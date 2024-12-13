//
//  Day13.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day13: Day {
    func run(input: String) -> String {
        input.allDigits.chunks(ofCount: 6).map { game in
            let a = Point(x: game[n: 0], y: game[n: 1])
            let b = Point(x: game[n: 2], y: game[n: 3])
            let prize = Point(x: game[n: 4] + 10000000000000, y: game[n: 5] + 10000000000000)
            
            let bCount = (a.x * prize.y - a.y * prize.x) / (-b.x * a.y + a.x * b.y)
            let aCount = (prize.x - bCount*b.x)/a.x
            if a * aCount + b * bCount == prize {
                return aCount * 3 + bCount
            } else {
                return 0
            }
        }
        .sum
        .description
    }
}
