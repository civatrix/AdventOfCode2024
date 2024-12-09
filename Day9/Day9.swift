//
//  Day9.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day9: Day {
    struct DiskBlock {
        let state: ParseState
        var size: Int
        let id: Int
        
        var string: String {
            switch state {
            case .disk:
                return String(repeating: "\(id)", count: size)
            case .empty:
                return String(repeating: ".", count: size)
            }
        }
        
        var array: [Int] {
            switch state {
            case .disk:
                return [Int](repeating: id, count: size)
            case .empty:
                return []
            }
        }
    }
    
    enum ParseState {
        case disk, empty
        
        mutating func toggle() {
            switch self {
            case .disk:
                self = .empty
            case .empty:
                self = .disk
            }
        }
    }
    
    func run(input: String) -> String {
        var disk = [DiskBlock]()
        var parseState = ParseState.disk
        var id = 0
        for character in input {
            disk.append(DiskBlock(state: parseState, size: character.wholeNumberValue!, id: id / 2))
            id += 1
            
            parseState.toggle()
        }
        
        let ids = disk.filter { $0.state == .disk }.map { $0.id }.reversed()
        for nextId in ids {
            let nextFullIndex = disk.firstIndex(where: { $0.id == nextId && $0.state == .disk })!
            let nextFull = disk[nextFullIndex]
            let nextEmptyIndex = disk.firstIndex { $0.state == .empty && $0.size >= nextFull.size }
            guard let nextEmptyIndex, nextEmptyIndex < nextFullIndex else { continue }
            let nextEmpty = disk[nextEmptyIndex]
            if nextEmpty.size > nextFull.size {
                disk[nextEmptyIndex].size -= nextFull.size
                disk.remove(at: nextFullIndex)
                disk.insert(.init(state: .empty, size: nextFull.size, id: 0), at: nextFullIndex)
                disk.insert(nextFull, at: nextEmptyIndex)
            } else {
                disk.remove(at: nextFullIndex)
                disk.insert(.init(state: .empty, size: nextFull.size, id: 0), at: nextFullIndex)
                disk.remove(at: nextEmptyIndex)
                disk.insert(nextFull, at: nextEmptyIndex)
            }
            
            disk.trimSuffix(while: { $0.state == .empty })
        }
        
        var total = 0
        var index = 0
        for segment in disk {
            if segment.state == .disk {
                for block in segment.array {
                    total += block * index
                    index += 1
                }
            } else {
                index += segment.size
            }
        }
        return total.description
    }
}
