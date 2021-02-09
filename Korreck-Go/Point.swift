//
//  Point.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 1/24/21.
//

import Foundation

class Point: Equatable, Hashable {
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.col == rhs.col && lhs.row == rhs.row
    }
    
    var row: Int
    var col: Int
    
    init(r: Int, c: Int) {
        row = r
        col = c
    }
    
    func neighbors()->[Point] {
        return [Point(r:row - 1, c:col),
                Point(r:row + 1, c:col),
                Point(r:row, c:col - 1),
                Point(r:row, c:col + 1)]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
}
