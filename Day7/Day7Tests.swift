//
//  Day7Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day7Tests: XCTestCase {
    let day = Day7()
    
    func testDay() throws {
        let input =
"""
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
"""
        XCTAssertEqual(day.run(input: input), "3749")
    }
}
