//
//  Vector.swift
//  AdventOfCode
//
//  Created by Daniel Johns on 2024-12-05.
//

import Foundation

struct Vector: Hashable, ExpressibleByArrayLiteral {
    var position: Point
    var direction: Point
    
    init(position: Point, direction: Point) {
        self.position = position
        self.direction = direction
    }
    
    public init(arrayLiteral elements: Point...) {
        position = elements[0]
        direction = elements[1]
    }
    
    func rotate(clockwise: Bool) -> Vector {
        return [position, direction.rotate(clockwise: clockwise)]
    }
    
    func nextStep() -> Point {
        position + direction
    }
    
    func allPointsBoundedBy(x: Range<Int>, y: Range<Int>) -> Set<Vector> {
        var set = Set<Vector>()
        var current = position
        while x.contains(current.x) && y.contains(current.y) {
            set.insert([current, direction])
            current += direction
        }
        
        return set
    }
}
