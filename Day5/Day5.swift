//
//  Day5.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day5: Day {
    func run(input: String) -> String {
        var before = [Int: Set<Int>]()
        var after = [Int: Set<Int>]()
        var lines = input.lines.map { $0.allDigits }.makeIterator()
        var nextLine = lines.next()
        while let line = nextLine {
            guard line.count == 2 else {
                break
            }
            
            before[line[1], default: []].insert(line[0])
            after[line[0], default: []].insert(line[1])
            nextLine = lines.next()
        }
        
        var total = 0
        while let line = nextLine {
            let isCorrect = line.indices.allSatisfy { index in
                let prefix = line.prefix(upTo: index)
                let suffix = line.suffix(from: index + 1)
                
                return before[line[index], default: []].isSuperset(of: prefix) && after[line[index], default: []].isSuperset(of: suffix)
            }
            
            if isCorrect {
                total += line[line.count / 2]
            }
            nextLine = lines.next()
        }
        
        return total.description
    }
}
