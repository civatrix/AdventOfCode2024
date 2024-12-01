//
//  Day1.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day1: Day {
    func run(input: String) -> String {
        var left: [Int] = []
        var right: [Int] = []
        input.allDigits.chunks(ofCount: 2).forEach {
            left.append($0[n: 0])
            right.append($0[n: 1])
        }
        left.sort()
        right.sort()
        
        return zip(left, right).map {
            abs($0.0 - $0.1)
        }.sum.description
    }
}
