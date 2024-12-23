//
//  Day22.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day22: Day {
    func run(input: String) -> String {
        let histories = input.lines.map { line in
            var priceHistory = [[Int]: Int]()
            var currentHistory = [Int]().dropFirst()
            var value = Int(line)!
            var lastPrice = 0
            for index in 0 ..< 2000 {
                nextSecretNumber(&value)
                let price = value % 10
                if index > 0 {
                    let difference = lastPrice - price
                    if currentHistory.count < 4 {
                        currentHistory.append(difference)
                    } else {
                        currentHistory = currentHistory.dropFirst()
                        currentHistory.append(difference)
                        if priceHistory[Array(currentHistory)] == nil {
                            priceHistory[Array(currentHistory)] = price
                        }
                    }
                }
                lastPrice = price
            }
            return priceHistory
        }
        
        return Set(histories.flatMap { $0.keys })
            .map { key in histories.map { $0[key, default: 0] }.sum }
            .max()!
            .description
    }
    
    func nextSecretNumber(_ number: inout Int) {
        number ^= number << 6
        number &= 16777215
        number ^= number >> 5
        number &= 16777215
        number ^= number << 11
        number &= 16777215
    }
}
