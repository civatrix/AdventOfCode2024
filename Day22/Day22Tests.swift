//
//  Day22Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day22Tests: XCTestCase {
    let day = Day22()
    
    func testDay() throws {
        let input =
"""
1
2
3
2024
"""
        XCTAssertEqual(day.run(input: input), "23")
    }
}
