//
//  GamesViewController.swift
//  Hockey Tracker
//
//  Created by Marco Biundo on 2020-11-12.
//  Copyright © 2020 Mohawk College. All rights reserved.
//
//I, Marco Biundo , student number 000299457, certify that this material is my original work.
//No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.

import UIKit

class GamesViewController: UITableViewController{
    var gameStore: GameStore!
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
     }()
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameStore.allGames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let game = gameStore.allGames[indexPath.row]
        
        
        var formattedDate: String
        let dateValue = dateFormatter.string(from: game.gameDate)
        formattedDate = dateValue
 

        if(game.opponent == ""){
            cell.textLabel?.text = "New game, detailed required"
        }else{
            cell.textLabel?.text = game.opponent + " - " + formattedDate + " - " + String(game.points)
        }
        if(game.plusMinus == 0 && game.opponent != ""){
            cell.imageView?.image = UIImage(named: "yellow")
        }else if(game.plusMinus < 0 && game.opponent != ""){
            cell.imageView?.image = UIImage(named: "red")
        }else if(game.plusMinus > 0 && game.opponent != "") {
            cell.imageView?.image = UIImage(named: "green")
        }
        

        return cell
    }
    
    
    @IBAction func addNewGame(_ sender: UIButton){
        
        let newGame = gameStore.createGame()
        if let index = gameStore.allGames.firstIndex(of: newGame){
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton){
        if isEditing{
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }else{
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let game = gameStore.allGames[indexPath.row]
            gameStore.removeItem(game)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        gameStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showGame"?:
            if let row = tableView.indexPathForSelectedRow?.row{
                let game = gameStore.allGames[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.game = game
            }
        default:
            preconditionFailure("Unidentified  segue")
        }
        

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
