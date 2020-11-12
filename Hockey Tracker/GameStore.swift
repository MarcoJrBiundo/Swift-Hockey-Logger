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
    let itemArchiveUrl: URL = {
        let documentDirectories = FileManager.default.urls(for:
            .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("games.plist")
    }()
    
    init(){
        
        
        do{
            let data = try Data(contentsOf: itemArchiveUrl)
            let unarchiver = PropertyListDecoder()
            let games = try unarchiver.decode([Game].self, from: data)
            allGames = games
        }catch{
            print("Error reading in saved games")
            
        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
    
    
    
    
    
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
    
    @objc func saveChanges() -> Bool{
        print("Saving games to: \(itemArchiveUrl)")
        do{
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allGames)
            try data.write(to: itemArchiveUrl, options: [.atomic])
            print("Saved all games")
            return true
        }catch{
            print("Error encoding allGames: \(error)")
            return false
        }
    }
}
