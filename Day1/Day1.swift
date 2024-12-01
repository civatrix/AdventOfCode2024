//
//  Day1.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day1: Day {
    func run(input: String) -> String {
        var list = [Int: Int]()
        var left = [Int]()
        input.allDigits.chunks(ofCount: 2).forEach {
            left.append($0[n: 0])
            list[$0[n: 1], default: 0] += 1
        }
        
        return left.map { list[$0, default: 0] * $0 }.sum.description
    }
}
