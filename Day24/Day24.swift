//
//  Day24.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation
import RegexBuilder

final class Day24: Day {
    let wire = Regex {
        Capture { OneOrMore(.any) }
        ": "
        TryCapture {
            One(.digit)
        } transform: { str -> Bool? in
            if str == "1" {
                return true
            } else if str == "0" {
                return false
            } else {
                return nil
            }
        }
    }
    
    let gate = Regex {
        Capture { OneOrMore(.any) }
        " "
        TryCapture {
            ChoiceOf {
                "AND"
                "OR"
                "XOR"
            }
        } transform: {str -> Gate.Operation? in
            return switch str {
            case "AND": .and
            case "OR": .or
            case "XOR": .xor
            default: nil
            }
        }
        " "
        Capture { OneOrMore(.any) }
        " -> "
        Capture { OneOrMore(.any) }
    }
    
    struct Gate {
        enum Operation {
            case and, or, xor
        }
        
        let inputs: Set<String>
        let output: String
        let operation: Operation
    }
    
    func run(input: String) -> String {
        var wires = [String: Bool]()
        var gates = [Gate]()
        var mostSignificantBit = 0
        
        let swaps = [("z12", "vdc"), ("z21", "nhn"), ("khg", "tvb"), ("z33", "gst")].reduce(into: [String: String]()) {
            $0[$1.0] = $1.1
            $0[$1.1] = $1.0
        }
        for line in input.lines {
            if let wireInput = line.wholeMatch(of: wire)?.output {
                wires[String(wireInput.1)] = wireInput.2
            } else if let gateInput = line.wholeMatch(of: gate)?.output {
                var output = String(gateInput.4)
                if let swap = swaps[output] {
                    output = swap
                }
                let gate = Gate(inputs: [String(gateInput.1), String(gateInput.3)], output: output, operation: gateInput.2)
                gates.append(gate)
                if gate.output.hasPrefix("z") {
                    mostSignificantBit = max(mostSignificantBit, gate.output.allDigits[0])
                }
            } else {
                fatalError("Unable to parse line \(line)")
            }
        }
        
        var output = "Cin X   Y       X^Y X&Y Cin &   Sum Cout\n"
        var carryIn = gates.first { $0.inputs == ["x00", "y00"] && $0.operation == .and }!.output
        // Hand verified the x00, y00 case with no carry in
        for index in 1 ..< mostSignificantBit {
            let x = String(format: "x%02d", index)
            let y = String(format: "y%02d", index)
            
            let inputs = Set([x, y])
            let aXorB = gates.first { $0.operation == .xor && $0.inputs == inputs }!.output
            let aAndB = gates.first { $0.operation == .and && $0.inputs == inputs }!.output
            let cInAnd = gates.first { $0.operation == .and && $0.inputs == [aXorB, carryIn] }?.output ?? "   "
            let sum = gates.first { $0.operation == .xor && $0.inputs == [aXorB, carryIn] }?.output ?? "   "
            let carryOut = gates.first { $0.operation == .or && $0.inputs == [cInAnd, aAndB] }?.output ?? "   "
            
            output.append([carryIn, x, y, "   ", aXorB, aAndB, cInAnd, "   ", sum, carryOut].joined(separator: " "))
            output.append("\n")
            carryIn = carryOut
        }
        
        return output
    }
}
