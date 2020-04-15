//
//  Lab1Task2ViewController.swift
//  labsAMO
//
//  Created by Viktory  on 17.02.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab1Task2ViewController: UIViewController {
    
    @IBOutlet weak var nTextField: UITextField!
    @IBOutlet weak var xTextField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var resLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressButton(_ sender: UIButton) {
        resLabel.text = "y = \(calculate(r: nTextField.text ?? "", x: xTextField.text ?? ""))"
        
    }
    func calculate(r: String, x: String) -> String {
        guard let doubleR = Double(r) else { return "Числа введені не корректно" }
        guard let doubleX = Double(x) else { return "Числа введені не корректно" }

        if (doubleX) == 0 {
            let alert = UIAlertController(title: nil, message: "Ділення на нуль!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Змінити значення", style: .default, handler: { (_) in
            }))
            
            self.present(alert, animated: true, completion: {
            })
        
        }
        if (doubleR) == 4 {
            let alert = UIAlertController(title: nil, message: "Ділення на нуль!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Змінити значення", style: .default, handler: { (_) in
            }))
            
            self.present(alert, animated: true, completion: {
            })
        }
        
        let part1 = (4*doubleR-doubleR*doubleX)
        let part2 = (4*doubleX-doubleR*doubleX)
        let result = part1 / part2
                
    
        return String(round(1000 * result)/1000)
    }
    
    @IBAction func didPressAlg(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let vc = mainStoryBoard.instantiateViewController(identifier: AlgViewController.identifier) as? AlgViewController else { return }
        
        vc.algImage = UIImage(named: "lab1Alg2") ?? UIImage()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
