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
            let prize = Point(x: game[n: 4], y: game[n: 5])
            
            var minTotal: Int?
            for aCount in 0 ... 100 {
                let aPosition = a * aCount
                guard aPosition.x <= prize.x && aPosition.y <= prize.y else { break }
                for bCount in 0 ... 100 {
                    let bPosition = b * bCount + aPosition
                    if bPosition == prize {
                        minTotal = min(minTotal ?? .max, aCount * 3 + bCount)
                    } else if bPosition.x > prize.x || bPosition.y > prize.y {
                        break
                    }
                }
            }
            
            return minTotal ?? 0
        }
        .sum
        .description
    }
}
