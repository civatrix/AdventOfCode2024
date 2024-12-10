//
//  Day10Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day10Tests: XCTestCase {
    let day = Day10()
    
    func testDay() throws {
        let input =
"""
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
"""
        XCTAssertEqual(day.run(input: input), "81")
    }
}
