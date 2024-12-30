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
        
        let lhs: Substring
        let rhs: Substring
        let output: Substring
        let operation: Operation
        
        func generateResult(from wires: [Substring: Bool]) -> Bool? {
            guard let lhsValue = wires[lhs], let rhsValue = wires[rhs] else {
                return nil
            }
            
            return switch operation {
            case .and:
                lhsValue && rhsValue
            case .or:
                rhsValue || lhsValue
            case .xor:
                lhsValue != rhsValue
            }
        }
    }
    
    func run(input: String) -> String {
        var wires = [Substring: Bool]()
        var gates = [Gate]()
        for line in input.lines {
            if let wireInput = line.wholeMatch(of: wire)?.output {
                wires[wireInput.1] = wireInput.2
            } else if let gateInput = line.wholeMatch(of: gate)?.output {
                gates.append(Gate(lhs: gateInput.1, rhs: gateInput.3, output: gateInput.4, operation: gateInput.2))
            } else {
                fatalError("Unable to parse line \(line)")
            }
        }
        
        var outputs = [Int: Bool]()
        while !gates.isEmpty {
            var nextGates = [Gate]()
            for gate in gates {
                guard let result = gate.generateResult(from: wires) else {
                    nextGates.append(gate)
                    continue
                }
                
                if gate.output.starts(with: "z") {
                    let index = gate.output.allDigits[0]
                    outputs[index] = result
                } else {
                    wires[gate.output] = result
                }
            }
            gates = nextGates
        }
        
        return outputs.reduce(0) { partialResult, next in
            guard next.value else { return partialResult }
            return partialResult + (1 << next.key)
        }
        .description
    }
}
