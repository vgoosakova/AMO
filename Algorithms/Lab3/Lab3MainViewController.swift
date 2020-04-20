//
//  Lab3MainViewController.swift
//  Algorithms
//
//  Created by Денис Данилюк on 14.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab3MainViewController: UIViewController {
    
    @IBOutlet weak var aEnteredTextField: UITextField!
    
    @IBOutlet weak var bEnteredTextField: UITextField!
    
    @IBOutlet weak var nEnteredTextField: UITextField!
    
    @IBOutlet weak var pointTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        self.title = "Схема Ейткена"
    }
    
    
    @IBAction func didPressGetGraphic(_ sender: UIButton) {
        guard let chartVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Lab3ChartViewController.identifier) as? Lab3ChartViewController else { return }
        let a = Double(aEnteredTextField.text ?? "") ?? 0.0
        let b = Double(bEnteredTextField.text ?? "") ?? 3.0
        let n = Int(nEnteredTextField.text ?? "") ?? 10

        chartVC.aFromSegue = a
        chartVC.bFromSegue = b
        chartVC.nFromSegue = n
        
        self.navigationController?.pushViewController(chartVC, animated: true)
    }
    
    
    @IBAction func didPressGetTableWithPohubki(_ sender: UIButton) {
        guard let errorVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Lab3ErrorViewController.identifier) as? Lab3ErrorViewController else { return }
        
        let point = Double(pointTextField.text ?? "") ?? 0.0
        
        errorVC.pointFromSegue = point
        
        self.navigationController?.pushViewController(errorVC, animated: true)
    }
}
