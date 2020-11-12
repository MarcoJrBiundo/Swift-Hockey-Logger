//
//  Game.swift
//  Hockey Tracker
//
//  Created by Marco Biundo on 2020-11-12.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

class Game: Equatable, Codable {
    
    var opponent: String
    var goals: Int{
        didSet{
            if(self.goals < 0){
                self.goals = 0
            }
            
        }
    }
    var assists: Int{
        didSet{
            if(self.assists < 0){
                self.assists = 0
            }
            
        }    
    }
    var points: Int
    var plusMinus: Int
    var gameDate: Date
    
    init(){
        self.opponent = ""
        self.assists = 0
        self.goals = 0
        self.points = self.goals + self.assists
        self.plusMinus = 0
        self.gameDate = Date()
    }
    
    
    static func == (lhs: Game, rhs: Game)-> Bool{
        return lhs.opponent == rhs.opponent &&
         lhs.goals == rhs.goals &&
         lhs.assists == rhs.assists &&
         lhs.points == rhs.points &&
         lhs.plusMinus == rhs.plusMinus &&
         lhs.gameDate == rhs.gameDate
    }
    
    func setPoints(){
        self.points = self.assists + self.goals
    }


    

}
