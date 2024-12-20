//
//  Day19Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day19Tests: XCTestCase {
    let day = Day19()
    
    func testDay() throws {
        let input =
"""
r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb
"""
        XCTAssertEqual(day.run(input: input), "16")
    }
}
