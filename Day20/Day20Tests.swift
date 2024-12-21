//
//  Day20Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day20Tests: XCTestCase {
    let day = Day20()
    
    func testDay() throws {
        let input =
"""
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
"""
        day.cheatThreshold = 50
        XCTAssertEqual(day.run(input: input), "285")
    }
}
