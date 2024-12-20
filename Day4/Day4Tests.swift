//
//  Day4Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day4Tests: XCTestCase {
    let day = Day4()
    
    func testDay() throws {
        let input =
"""
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""
        XCTAssertEqual(day.run(input: input), "9")
    }
}
