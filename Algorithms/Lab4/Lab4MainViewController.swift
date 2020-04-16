//
//  Lab4MainViewController.swift
//  Algorithms
//
//  Created by Денис Данилюк on 15.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab4MainViewController: UIViewController {

    @IBOutlet weak var aTextField: UITextField!
    
    @IBOutlet weak var bTextField: UITextField!
    
    @IBOutlet weak var epsilonTextField: UITextField!
    
    @IBOutlet weak var possiblePointsLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPossiblePonits()
        
        self.title = "Лабораторна №4"
    }
    
    
    private func getPossiblePonits() {
        let step = 0.5
        var arrayWithPoints: [[Double]] = []
        var startPoint = -10.0

        while startPoint < 10.0 {
            if (getYFromFormula(startPoint) * getYFromFormula(startPoint + step) < 0) || (getYFromFormula(startPoint) == 0) {
                arrayWithPoints.append([startPoint.rounded(digits: 4), (startPoint + step).rounded(digits: 4)])
            }
            startPoint += step
        }
        
        possiblePointsLabel.text = arrayWithPoints.description
    }
    
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        
        let a = Double(aTextField.text ?? "") ?? 0.0
        
        let b = Double(bTextField.text ?? "") ?? 3.0
        
        let epsilon = Double(epsilonTextField.text ?? "") ?? 0.001
        
        let (x, y) = myVariantMethod(pointA: a, pointB: b, epsilon: epsilon)
        
        resultLabel.text = "x = \(x.rounded(digits: 4)), y = \(y)"
    }
    
}
