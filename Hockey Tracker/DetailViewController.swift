//
//  DetailViewController.swift
//  Hockey Tracker
//
//  Created by Marco Biundo on 2020-11-12.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet var opponentField: UITextField!
    @IBOutlet var goalsField: UITextField!
    @IBOutlet var plusMinusField: UITextField!
    @IBOutlet var assistsField: UITextField!
    @IBOutlet var date: UIDatePicker!
    
    
    var game: Game!
    
   let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
     }()
    
    override func viewWillAppear(_ animated: Bool) {
        opponentField.text = game.opponent
        goalsField.text = numberFormatter.string(from: NSNumber(value: game.goals))
        plusMinusField.text = numberFormatter.string(from: NSNumber(value: game.plusMinus))
        assistsField.text = numberFormatter.string(from: NSNumber(value: game.assists))
        
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.opponent = opponentField.text ?? ""
        if let assistsText = assistsField.text,
            let value = numberFormatter.number(from: assistsText){
            game.assists = value.intValue
        }else{
            game.assists = 0
        }
        if let goalText = goalsField.text,
            let value = numberFormatter.number(from: goalText){
            game.goals = value.intValue
        }else{
            game.goals = 0
        }
        if let plusMinusText = plusMinusField.text,
            let value = numberFormatter.number(from: plusMinusText){
            game.plusMinus = value.intValue
        }else{
            game.plusMinus = 0
        }
        
        game.gameDate = date.date
        
        game.setPoints()
        
        
    }
    



}
