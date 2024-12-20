//
//  Day17Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day17Tests: XCTestCase {
    let day = Day17()
    
    func testDay() throws {
        let input =
"""
Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0
"""
        XCTAssertEqual(day.run(input: input), "117440")
    }
}
