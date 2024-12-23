//
//  Day23.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day23: Day {
    func run(input: String) -> String {
        var network = [String: Set<String>]()
        
        for line in input.lines {
            let (lhs, rhs) = line.bifurcate(on: "-")
            network[lhs, default: []].insert(rhs)
            network[rhs, default: []].insert(lhs)
        }
        
        for key in network.keys {
            network[key, default: []].insert(key)
        }
        
        return network.keys.combinations(ofCount: 3)
            .filter { $0.contains(where: { $0.hasPrefix("t") }) }
            .filter { combination in
                for key in combination {
                    if !network[key, default: []].isSuperset(of: combination) {
                        return false
                    }
                }
                return true
            }
            .count
            .description
    }
}
