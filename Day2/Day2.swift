//
//  Day2.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day2: Day {
    func run(input: String) -> String {
        return input.lines
            .filter { isValid(list: $0.allDigits) }
            .count
            .description
    }
    
    func isValid(list: [Int], canSkip: Bool = true, forceIncreasing: Bool? = nil) -> Bool {
        guard Set(list).count == list.count || Set(list).count + 1 == list.count else {
            return false
        }
        let increasing = forceIncreasing ?? (list.first! < list.last!)
        for (index, pair) in list.adjacentPairs().enumerated() where !isValid(pair: pair, increasing: increasing) {
            guard canSkip else {
                return false
            }
            let restOfList = Array(list.suffix(from: index + 2))
            if index == list.startIndex {
                if isValid(list: Array(list.dropFirst()), canSkip: false) {
                    return true
                } else if isValid(list: [list[0]] + restOfList, canSkip: false) {
                    return true
                } else {
                    return false
                }
            } else if index == list.count - 2 {
                return true
            } else {
                if isValid(list: [list[index - 1], pair.1] + restOfList, canSkip: false, forceIncreasing: increasing) {
                    return true
                } else if isValid(list: [pair.0] + restOfList, canSkip: false, forceIncreasing: increasing) {
                    return true
                } else {
                    return false
                }
            }
        }
        
        return true
    }
    
    func isValid(pair: (Int, Int), increasing: Bool) -> Bool {
        ((increasing && pair.0 < pair.1) || (!increasing && pair.0 > pair.1)) && ((1...3).contains(abs(pair.0 - pair.1)))
    }
}
