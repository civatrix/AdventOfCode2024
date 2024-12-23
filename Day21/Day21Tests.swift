//
//  Day21Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day21Tests: XCTestCase {
    let day = Day21()
    
    func testDay() throws {
        let input =
"""
029A
980A
179A
456A
379A
"""
        XCTAssertEqual(day.run(input: input), "126384")
    }
}
