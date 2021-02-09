//
//  Board.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 1/24/21.
//

import Foundation

class Board: Equatable {
    
    static func == (lhs: Board, rhs: Board) -> Bool {
        return lhs.numberRows == rhs.numberRows && lhs.numberColumns == rhs.numberColumns && lhs.grid == rhs.grid
    }
    
    var numberRows: Int
    var numberColumns: Int
    var grid: [Point:GoString] = [:]
    
    init(numRows: Int, numCol: Int ) {
        numberRows = numRows
        numberColumns = numCol
    }
    
    func onGrid(point: Point) -> Bool {
        return point.row <= numberRows && point.col <= numberColumns
    }
    
    func get(point: Point) -> PlayerColor? {
        guard let color = grid[point]?.color else {
            return nil
        }
        
        return color
    }
    
    func getGoString(point: Point) -> GoString? {
        guard let goString = grid[point] else {
            return nil
        }
        return goString
    }
    
    func removeGoString(string: GoString) {
        for point in string.stones {
            for neighbor in point.neighbors() {
                guard let neighborString = grid[neighbor] else {
                    continue
                }
                neighborString.addLiberty(lib: point)
            }
            grid.remove(at: grid.index(forKey: point)!)
        }
    }
    
    func placeStone(player: Player, point: Point) {
        var adjacentSameColor: [Point] = []
        var adjacentOppositeColor: [Point] = []
        var liberties: [Point] = []
        
        for neighbor in point.neighbors() {
            if !onGrid(point: neighbor) {
                continue
            }
            
            guard let neighborString = grid[neighbor] else {
                liberties.append(neighbor)
                continue
            }
            
            if neighborString.color == player.playerColor {
                if !adjacentSameColor.contains(neighbor) {
                    adjacentSameColor.append(neighbor)
                }
            } else {
                if !adjacentOppositeColor.contains(neighbor) {
                    adjacentOppositeColor.append(neighbor)
                }
            }
        }
        var newGoString = GoString(stringColor: player.playerColor, stringStones: Set([point]), stringLiberties: Set(liberties))
        
        for stringPoint in adjacentSameColor {
            guard let adjGString = getGoString(point: stringPoint) else {
                exit(-1)
            }
            
            newGoString = newGoString.merge(goString: adjGString)
            for newP in newGoString.stones {
                grid[newP] = newGoString
            }
        }
        
        for stringPoint in adjacentOppositeColor {
            guard let oppColorGS = getGoString(point: stringPoint) else {
                exit(-1)
            }
            oppColorGS.removeLiberty(lib: point)
            if oppColorGS.numLiberties() == 0 {
                removeGoString(string: oppColorGS)
            }
            
        }
    }
}
