//
//  Day12Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day12Tests: XCTestCase {
    let day = Day12()
    
    func testDay() throws {
        let input =
"""
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
"""
        XCTAssertEqual(day.run(input: input), "1206")
    }
    
    func testNested() throws {
        let input =
"""
AAAAAA
AAABBA
AAABBA
ABBAAA
ABBAAA
AAAAAA
"""
        XCTAssertEqual(day.run(input: input), "368")
    }
}
