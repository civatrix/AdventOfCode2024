//
//  Day11Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day11Tests: XCTestCase {
    let day = Day11()
    
    func testDay() throws {
        let input =
"""
125 17
"""
        XCTAssertEqual(day.run(input: input), "65601038650482")
    }
}
