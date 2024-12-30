//
//  Day23.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day23: Day {
    func run(input: String) -> String {
        var connections = [String: Set<String>]()
        
        for line in input.lines {
            let (lhs, rhs) = line.bifurcate(on: "-")
            connections[lhs, default: []].insert(rhs)
            connections[rhs, default: []].insert(lhs)
        }
        
        for key in connections.keys {
            connections[key, default: []].insert(key)
        }
        let keys = Set(connections.keys)
        var networks = Set(keys.map { Set([$0]) })
        
        for key in keys {
            var nextNetworks = Set<Set<String>>()
            for network in networks {
                let fits = network.allSatisfy { connections[key]!.contains($0) && connections[$0]!.contains(key) }
                if fits {
                    nextNetworks.insert(network.union([key]))
                } else {
                    nextNetworks.insert(network)
                }
            }
            networks = nextNetworks
        }
        
        return networks.max { $0.count < $1.count }!
            .sorted()
            .joined(separator: ",")
    }
}
