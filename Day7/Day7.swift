//
//  Day7.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day7: Day {
    func run(input: String) -> String {
        return input.lines.map { line in
            var digits = line.allDigits
            let total = digits.removeFirst()
            let matches = recur(numbers: digits, nextOperator: +, target: total) || recur(numbers: digits, nextOperator: *, target: total)
            
            return matches ? total : 0
        }
        .sum.description
    }
    
    func recur(numbers: [Int], nextOperator: (Int, Int) -> Int, target: Int) -> Bool {
        guard numbers.count > 1 else {
            return numbers[0] == target
        }
        
        let total = nextOperator(numbers[0], numbers[1])
        if total > target {
            return false
        }
        
        let nextNumbers = [total] + numbers.dropFirst(2)
        return recur(numbers: nextNumbers, nextOperator: +, target: target) || recur(numbers: nextNumbers, nextOperator: *, target: target)
    }
}
