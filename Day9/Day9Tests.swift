//
//  Day9Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day9Tests: XCTestCase {
    let day = Day9()
    
    func testDay() throws {
        let input =
"""
2333133121414131402
"""
        XCTAssertEqual(day.run(input: input), "1928")
    }
}
