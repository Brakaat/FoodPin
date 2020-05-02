//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Kiri on 2020/4/28.
//  Copyright © 2020 bararaka. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]

    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        

        
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none // 三元運算子
        // 更新示圖
        
        return cell
    }
    
    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction) // 添加動作至菜單
        
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Unavailable", message: "We will soon to make it update", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call " + "0123 - 555 - \(indexPath.row)", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        
        
        let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.restaurantIsVisited[indexPath.row] = true
        })
        
        
        let checkUndoAction = UIAlertAction(title: "Check undo", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            self.restaurantIsVisited[indexPath.row] = false
        })
        
        let cellchack = tableView.cellForRow(at: indexPath)
        if cellchack?.accessoryType == .checkmark{
            optionMenu.addAction(checkUndoAction)
        } else {
            optionMenu.addAction(checkInAction)
        }
        
        // 添加取消訂購的選單
        
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
            // 修正ipad因無法使用.actionsheet而閃退，改使用彈跳視窗
        }
        
        present(optionMenu, animated: true, completion: nil) // 呈現菜單
        
        tableView.deselectRow(at: indexPath, animated: false) // 取消反選
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {(action, sourceView, completionHandler) in
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)

            self.tableView.deleteRows(at: [indexPath], with: .fade)

            completionHandler(true)
        }

        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
            //添加複製貼上時，會連同名稱及圖片一起
            let activityController : UIActivityViewController
            
            if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            //修正ipad會crash

            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)

            }
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")

        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "share")
        //添加delete share按鈕顏色

        
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        //向左滑時，建立上面的兩個按鈕 delete share
        return swipeConfiguration
        
        
        }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pinAction = UIContextualAction(style: .destructive, title: "Pin") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : true
            cell.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
            
            completionHandler(true)
        }
        
        let pinIcon = restaurantIsVisited[indexPath.row] ? "arrow.uturn.left" : "checkmark"
        pinAction.backgroundColor = UIColor(red: 36.0/255.0, green: 219.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        pinAction.image = UIImage(systemName: pinIcon)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [pinAction])
        return swipeConfiguration
    }
    
    }
    


