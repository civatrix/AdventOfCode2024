//
//  Day15.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day15: Day {
    func run(input: String) -> String {
        let lines = input.allLines
        var robot = Point.zero
        var walls = Set<Point>()
        var boxes = Set<Point>()
        for (y, line) in lines.split(separator: "")[0].enumerated() {
            for (x, cell) in line.enumerated() {
                switch cell {
                case "#":
                    walls.insert([x, y])
                case "O":
                    boxes.insert([x, y])
                case "@":
                    robot = [x, y]
                case ".":
                    break
                default:
                    fatalError("Unknown map tile \(cell)")
                }
            }
        }
        
        let instructions = lines.split(separator: "")[1].flatMap { $0 }.map { cell -> Point in
            switch cell {
            case "^": .up
            case "v": .down
            case "<": .left
            case ">": .right
            default:
                fatalError("Unknown instruction \(cell)")
            }
        }
        
        for instruction in instructions {
            let next = robot + instruction
            if walls.contains(next) {
                continue
            } else if boxes.contains(next) {
                var probe: Point? = next + instruction
                while let subprobe = probe {
                    if walls.contains(subprobe) {
                        probe = nil
                    } else if boxes.contains(subprobe) {
                        probe = subprobe + instruction
                    } else {
                        break
                    }
                }
                if let probe {
                    robot = next
                    boxes.remove(next)
                    boxes.insert(probe)
                }
            } else {
                robot = next
            }
        }
        return boxes.map { $0.x + $0.y * 100 }.sum.description
    }
}
