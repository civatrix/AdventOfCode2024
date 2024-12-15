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
        var linkedBoxes = [Point: Point]()
        for (y, line) in lines.split(separator: "")[0].enumerated() {
            for (x, cell) in line.enumerated() {
                switch cell {
                case "#":
                    walls.insert([2*x, y])
                    walls.insert([2*x + 1, y])
                case "O":
                    boxes.insert([2*x, y])
                    boxes.insert([2*x + 1, y])
                    linkedBoxes[[2*x, y]] = [2*x + 1, y]
                    linkedBoxes[[2*x + 1, y]] = [2*x, y]
                case "@":
                    robot = [2*x, y]
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
                var affectedBoxes: Set<Point> = [next]
                
                if instruction == .left || instruction == .right {
                    var probe = next + instruction
                    while true {
                        if walls.contains(probe) {
                            affectedBoxes = []
                            break
                        } else if boxes.contains(probe) {
                            affectedBoxes.insert(probe)
                            probe = probe + instruction
                        } else {
                            break
                        }
                    }
                } else {
                    let boxDelta = linkedBoxes[next]! - next
                    affectedBoxes.insert(linkedBoxes[next]!)
                    var probes: Set<Point> = [next + instruction, next + boxDelta + instruction]
                    while !affectedBoxes.isEmpty && !probes.isEmpty {
                        var nextProbes = Set<Point>()
                        for probe in probes {
                            if walls.contains(probe) {
                                affectedBoxes = []
                                break
                            } else if boxes.contains(probe) {
                                let boxDelta = linkedBoxes[probe]! - probe
                                affectedBoxes.insert(probe)
                                affectedBoxes.insert(linkedBoxes[probe]!)
                                nextProbes.insert(probe + instruction)
                                nextProbes.insert(probe + instruction + boxDelta)
                            } else {
                                continue
                            }
                        }
                        probes = nextProbes
                    }
                }
                
                if !affectedBoxes.isEmpty {
                    robot = next
                    boxes.subtract(affectedBoxes)
                    boxes.formUnion(affectedBoxes.map { $0 + instruction })
                    for box in affectedBoxes {
                        linkedBoxes.removeValue(forKey: box)
                    }
                    affectedBoxes.sorted()
                        .chunks(ofCount: 2)
                        .map { $0[n: 0] }
                        .forEach {
                            linkedBoxes[$0 + instruction] = $0 + instruction + .right
                            linkedBoxes[$0 + instruction + .right] = $0 + instruction
                        }
                }
            } else {
                robot = next
            }
        }
        
        return boxes.sorted()
            .chunks(ofCount: 2)
            .map { $0[n: 0] }
            .map { $0.x + $0.y * 100 }
            .sum
            .description
    }
}
