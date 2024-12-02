//
//  Day2Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day2Tests: XCTestCase {
    let day = Day2()
    
    func testDay() throws {
        let input =
"""
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""
        XCTAssertEqual(day.run(input: input), "2")
    }
}
