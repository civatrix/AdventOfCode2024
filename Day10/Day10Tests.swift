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
        XCTAssertEqual(day.run(input: input), "36")
    }
    
    func testSimple() throws {
        let input =
"""
...0...
...1...
...2...
6543456
7.....7
8.....8
9.....9
"""
        XCTAssertEqual(day.run(input: input), "2")
    }
    
    func test2() throws {
        let input =
"""
..90..9
...1.98
...2..7
6543456
765.987
876....
987....
"""
        XCTAssertEqual(day.run(input: input), "4")
    }
}
