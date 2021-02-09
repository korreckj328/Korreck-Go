//
//  GoString.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 1/24/21.
//

import Foundation

class GoString : Equatable{
    var color: PlayerColor
    var stones: Set<Point>
    var liberties: Set<Point>
    
    init(stringColor: PlayerColor, stringStones:Set<Point>, stringLiberties: Set<Point>) {
        color = stringColor
        stones = Set(stringStones)
        liberties = Set(stringLiberties)
    }
    
    func removeLiberty(lib: Point) {
        liberties.remove(lib)
    }
    
    func addLiberty(lib: Point) {
        liberties.insert(lib)
    }
    
    func merge(goString: GoString) -> GoString {
        assert(color == goString.color)
        var combinedStones = stones
        
        for stone in goString.stones {
            if !combinedStones.contains(stone) {
                combinedStones.insert(stone)
            }
        }
        
        var combinedLibs = liberties
        
        for lib in goString.liberties {
            if !combinedLibs.contains(lib) {
                combinedLibs.insert(lib)
            }
        }
        
        for stone in combinedStones {
            if combinedLibs.contains(stone) {
                combinedLibs.remove(stone)
            }
        }
        
        return GoString(stringColor: color, stringStones: combinedStones, stringLiberties: combinedLibs)
    }
    
    func numLiberties() -> Int {
        return liberties.count
    }
    
    static func ==(lhs: GoString, rhs: GoString) -> Bool{
        return lhs.color == rhs.color && lhs.stones == rhs.stones && lhs.liberties == rhs.liberties
        
    }
    
}
