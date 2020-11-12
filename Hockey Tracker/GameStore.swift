//
//  GameStore.swift
//  Hockey Tracker
//
//  Created by Marco Biundo on 2020-11-12.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

class GameStore{
    var allGames = [Game]()
    
    
    
    
    
   @discardableResult func createGame() -> Game{
        let newGame = Game()
        allGames.append(newGame)
        return newGame
    
    }
    
    func removeItem(_ game: Game){
        if let index = allGames.firstIndex(of: game){
            allGames.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        
        let movedGame = allGames[fromIndex]
        allGames.remove(at: fromIndex)
        allGames.insert(movedGame, at: toIndex)
    }
}
