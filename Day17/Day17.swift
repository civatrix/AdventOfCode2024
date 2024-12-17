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
        var a = numbers[0]
        var b = numbers[1]
        var c = numbers[2]
        var instructionPointer = 0
        
        let instructions = numbers.dropFirst(3)
        var output = [Int]()
        while instructionPointer + 1 < instructions.count {
            let opCode = instructions[n: instructionPointer]
            let operand = instructions[n: instructionPointer + 1]
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
        return output.map { String($0) }.joined(separator: ",")
    }
}
