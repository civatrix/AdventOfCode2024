//
//  Day14.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day14: Day {
    var bottomCorner = Point(x: 101, y: 103)
    func run(input: String) -> String {
        var bots = input.lines.map {
            let numbers = $0.allDigits
            return Vector(position: [numbers[0], numbers[1]], direction: [numbers[2], numbers[3]])
        }
        
        var minDanger = Int.max
        var minDangerStep = 0
        for step in 1 ... bottomCorner.x * bottomCorner.y {
            for index in bots.indices {
                bots[index].position = bots[index].nextStep()
                if bots[index].position.x < 0 {
                    bots[index].position.x += bottomCorner.x
                } else if bots[index].position.x >= bottomCorner.x {
                    bots[index].position.x -= bottomCorner.x
                }
                if bots[index].position.y < 0 {
                    bots[index].position.y += bottomCorner.y
                } else if bots[index].position.y >= bottomCorner.y {
                    bots[index].position.y -= bottomCorner.y
                }
            }
            
            let center = Point(x: bottomCorner.x / 2, y: bottomCorner.y / 2)
            var topLeft = 0
            var bottomLeft = 0
            var topRight = 0
            var bottomRight = 0
            for bot in bots {
                if bot.position.x < center.x && bot.position.y < center.y {
                    topLeft += 1
                } else if bot.position.x < center.x && bot.position.y > center.y {
                    bottomLeft += 1
                } else if bot.position.x > center.x && bot.position.y < center.y {
                    topRight += 1
                } else if bot.position.x > center.x && bot.position.y > center.y {
                    bottomRight += 1
                }
            }
            let danger = (topLeft * topRight * bottomLeft * bottomRight)
            if danger < minDanger {
                minDanger = danger
                minDangerStep = step
                print(step)
                Set(bots.map { $0.position }).printPoints()
            }
        }
        return minDangerStep.description
    }
}
