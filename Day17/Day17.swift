//
//  Day17.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day17: Day {
    func run(input: String) -> String {
        let numbers = input.allDigits
        let instructions = Array(numbers.dropFirst(3))
        return search(digit: 0, result: 0, instructions: instructions, numbers: numbers)?.description ?? ""
    }
    
    func search(digit: Int, result: Int, instructions: [Int], numbers: [Int]) -> Int? {
        guard digit < instructions.count else {
            return result >> 3
        }
        for aSeed in 0 ..< 8 {
            let candidate = result + aSeed
            let output = run(instructions: instructions, aSeed: candidate, bSeed: numbers[1], cSeed: numbers[2])
            if output == instructions.suffix(digit + 1) {
                if let fullResult = search(digit: digit + 1, result: candidate << 3, instructions: instructions, numbers: numbers) {
                    return fullResult
                }
            }
        }
        return nil
    }
        
    func run(instructions: [Int], aSeed: Int, bSeed: Int, cSeed: Int) -> [Int] {
        var a = aSeed
        var b = bSeed
        var c = cSeed
        var instructionPointer = 0
        var output = [Int]()
        while instructionPointer + 1 < instructions.count {
            let opCode = instructions[instructionPointer]
            let operand = instructions[instructionPointer + 1]
            let comboOperand =  {
                switch operand {
                case 0: 0
                case 1: 1
                case 2: 2
                case 3: 3
                case 4: a
                case 5: b
                case 6: c
                default:
                    fatalError("Unknown opcode \(operand) at \(instructionPointer)")
                }
            }
            switch opCode {
            case 0:
                a = a >> comboOperand()
            case 1:
                b = b ^ operand
            case 2:
                b = comboOperand() % 8
            case 3:
                if a != 0 {
                    instructionPointer = operand - 2
                }
            case 4:
                b = b ^ c
            case 5:
                output.append(comboOperand() % 8)
            case 6:
                b = a >> comboOperand()
            case 7:
                c = a >> comboOperand()
            default:
                fatalError("Unknown opcode \(opCode) at \(instructionPointer)")
            }
            instructionPointer += 2
        }
        return output
    }
}
