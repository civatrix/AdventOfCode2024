//
//  Day18Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day18Tests: XCTestCase {
    let day = Day18()
    
    func testDay() throws {
        let input =
"""
5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0
"""
        day.gridSize = 6
        XCTAssertEqual(day.run(input: input), "6,1")
    }
}
