//
//  Lab1Task1ViewController.swift
//  labsAMO
//
//  Created by Viktory  on 17.02.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab1Task1ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bTextField: UITextField!
    @IBOutlet weak var cTextField: UITextField!
    @IBOutlet weak var dTextField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var dLabel: UILabel!
    @IBOutlet weak var res1Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressButton(_ sender: UIButton) {
        res1Label.text = "Y1 = \(calculate(a: textField.text ?? "", b: bTextField.text ?? "", c: cTextField.text ?? "", d: dTextField.text ?? ""))"
    }
    
    func calculate(a: String, b: String, c: String, d: String) -> String {
        
    guard let doubleA = Double(a) else { return "Числа введені не корректно" }
    guard let doubleB = Double(b) else { return "Числа введені не корректно" }
    guard let doubleC = Double(c) else { return "Числа введені не корректно" }
    guard let doubleD = Double(d) else { return "Числа введені не корректно" }
    let part1 = pow((doubleD * doubleA), doubleB)
    let part2 = pow((doubleB * doubleC), 1/doubleD)
    let result = part1 + part2
        
    return String(round(1000 * result)/1000)
        
    }
   
    @IBAction func didPressWrite(_ sender: UIButton) {
    }
    
    
    
    
    @IBAction func didPressAlg(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let vc = mainStoryBoard.instantiateViewController(identifier: AlgViewController.identifier) as? AlgViewController else { return }
        
        vc.algImage = UIImage(named: "lab1Alg1") ?? UIImage()
        
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
