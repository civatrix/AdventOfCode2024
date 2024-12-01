//
//  Day1Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day1Tests: XCTestCase {
    let day = Day1()
    
    func testDay() throws {
        let input =
"""
3   4
4   3
2   5
1   3
3   9
3   3
"""
        XCTAssertEqual(day.run(input: input), "11")
    }
}
