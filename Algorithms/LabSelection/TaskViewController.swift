//
//  TaskViewController.swift
//  labsAMO
//
//  Created by Viktory  on 17.02.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var labName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if labName == "1" {
            return 3
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseID")

        if labName == "1" {
            let taskNames = ["Завдання 1", "Завдання 2", "Завдання 3"]
            cell.textLabel?.text = taskNames[indexPath.row]
            
            cell.accessoryType = .disclosureIndicator
            return cell
        } else if labName == "2" {
            let taskNames = ["Порозрядне сортування"]
            cell.textLabel?.text = taskNames[indexPath.row]
            return cell
        } else if labName == "3" {
            let taskNames = ["Схема Ейткена"]
            cell.textLabel?.text = taskNames[indexPath.row]
            return cell
        } else if labName == "4" {
            let taskNames = ["Метод половинного ділення"]
            cell.textLabel?.text = taskNames[indexPath.row]
            return cell
        } else if labName == "5" {
            let taskNames = ["Метод Гауса з вибором головного елемента"]
            cell.textLabel?.text = taskNames[indexPath.row]
            return cell
        } else {
            return cell
        }
    }
    
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        if labName == "1" {
            if indexPath.row == 0 {
                guard let vc = mainStoryBoard.instantiateViewController(identifier: Lab1Task1ViewController.identifier) as? Lab1Task1ViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                guard let vc = mainStoryBoard.instantiateViewController(identifier: Lab1Task2ViewController.identifier) as? Lab1Task2ViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 2{
                guard let vc = mainStoryBoard.instantiateViewController(identifier: Lab1Task3ViewController.identifier) as? Lab1Task3ViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if labName == "2" {
            if indexPath.row == 0 {
                guard let vc = mainStoryBoard.instantiateViewController(identifier: Lab2Task1ViewController.identifier) as? Lab2Task1ViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if labName == "3" {
           if indexPath.row == 0 {
               guard let vc = mainStoryBoard.instantiateViewController(identifier: Lab3MainViewController.identifier) as? Lab3MainViewController else { return }
               self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if labName == "4" {
            if indexPath.row == 0 {
               guard let vc = mainStoryBoard.instantiateViewController(identifier: Lab4MainViewController.identifier) as? Lab4MainViewController else { return }
               self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if labName == "5" {
            if indexPath.row == 0 {
               guard let vc = mainStoryBoard.instantiateViewController(identifier: Lab5MainViewController.identifier) as? Lab5MainViewController else { return }
               self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
