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
        
        while let nextEmptyIndex = disk.firstIndex(where: { $0.state == .empty }) {
            let nextEmpty = disk[nextEmptyIndex]
            let nextFull = disk.last!
            if nextEmpty.size > nextFull.size {
                disk[nextEmptyIndex].size -= nextFull.size
                disk.insert(nextFull, at: nextEmptyIndex)
                disk.removeLast()
            } else if nextEmpty.size < nextFull.size{
                disk.remove(at: nextEmptyIndex)
                disk.insert(.init(state: .disk, size: nextEmpty.size, id: nextFull.id), at: nextEmptyIndex)
                disk[disk.endIndex - 1].size -= nextEmpty.size
            } else {
                disk.remove(at: nextEmptyIndex)
                disk.insert(nextFull, at: nextEmptyIndex)
                disk.removeLast()
            }
            
            disk.trimSuffix(while: { $0.state == .empty })
        }
        
        return disk.flatMap { $0.array }.enumerated().map { $0.offset * $0.element }.sum.description
    }
}
