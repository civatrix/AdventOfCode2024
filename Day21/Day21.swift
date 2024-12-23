//
//  Day21.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day21: Day {
    func run(input: String) -> String {
        return input.lines.map { line in
            let number = line.allDigits[0]
            let strokes = strokes(for: line.map { $0 }, keypadDepth: 2)
            
            return number * strokes.count
        }
        .sum
        .description
    }
    
    let numericKeypad: [Character: Point] = [
        "7": [0,0],
        "8": [1,0],
        "9": [2,0],
        "4": [0,1],
        "5": [1,1],
        "6": [2,1],
        "1": [0,2],
        "2": [1,2],
        "3": [2,2],
        "0": [1,3],
        "A": [2,3],
    ]
    let numericDeadKey = Point(x: 0, y: 3)
    let directionalKeypad: [Character: Point] = [
        "^": [1,0],
        "A": [2,0],
        "<": [0,1],
        "v": [1,1],
        ">": [2,1],
    ]
    let directionalDeadKey = Point(x: 0, y: 0)
    func strokes(for code: [Character], keypadDepth: Int) -> [Character] {
        var totalStrokes = [Character]()
        let keypad = keypadDepth == 2 ? numericKeypad : directionalKeypad
        let deadKey = keypadDepth == 2 ? numericDeadKey : directionalDeadKey
        var currentPosition = keypad["A"]!
        for character in code {
            let nextPosition = keypad[character]!
            var nextHorizontalStrokes = [Character]()
            var nextVerticalStrokes = [Character]()
            if currentPosition.x < nextPosition.x {
                nextHorizontalStrokes.append(contentsOf: [Character](repeating: ">", count: nextPosition.x - currentPosition.x))
            } else if currentPosition.x > nextPosition.x {
                nextHorizontalStrokes.append(contentsOf: [Character](repeating: "<", count: currentPosition.x - nextPosition.x))
            }
            if currentPosition.y > nextPosition.y {
                nextVerticalStrokes.append(contentsOf: [Character](repeating: "^", count: currentPosition.y - nextPosition.y))
            } else if currentPosition.y < nextPosition.y {
                nextVerticalStrokes.append(contentsOf: [Character](repeating: "v", count: nextPosition.y - currentPosition.y))
            }
            if keypadDepth > 0 {
                let possiblePaths = [
                    nextHorizontalStrokes + nextVerticalStrokes + ["A"],
                    nextVerticalStrokes + nextHorizontalStrokes + ["A"]
                ]
                let bestStrokes = possiblePaths
                    .filter { path -> Bool in
                        var tempPosition = currentPosition
                        for char in path {
                            switch char {
                            case "<": tempPosition += .left
                            case ">": tempPosition += .right
                            case "^": tempPosition += .up
                            case "v": tempPosition += .down
                            default: break
                            }
                            if tempPosition == deadKey {
                                return false
                            }
                        }
                        return true
                    }
                    .map { strokes(for: $0, keypadDepth: keypadDepth - 1) }
                    .min { $0.count < $1.count }
                totalStrokes.append(contentsOf: bestStrokes!)
            } else {
                totalStrokes.append(contentsOf: nextVerticalStrokes + nextHorizontalStrokes + ["A"])
            }
            
            currentPosition = nextPosition
        }
        
        return totalStrokes
    }
}
