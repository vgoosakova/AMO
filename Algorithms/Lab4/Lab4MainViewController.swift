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
        hideKeyboard()
        getPossiblePoints()
        
        self.title = "Метод половинного ділення"
    }
    
    
    // Знаходження всіх можливих проміжків
    private func getPossiblePoints() {
        // Шаг
        let step = 0.5
        
        // Массив з можливими проміжками
        var arrayWithPoints: [(x: Double, y: Double)] = []
        
        // Початкова точка
        var startPoint = -10.0

        // Кінцева точка
        while startPoint < 10.0 {
            if (getYFromFormula(startPoint) * getYFromFormula(startPoint + step) < 0) || (getYFromFormula(startPoint) == 0) {
                // Якщо корінь на проміжку існує, додаємо його до массиву
                arrayWithPoints.append((x: startPoint.rounded(digits: 4), y: (startPoint + step).rounded(digits: 4)))
            }
            startPoint += step
        }
        
        possiblePointsLabel.text = arrayWithPoints.description
    }
    
    
    // Вивід результату
    @IBAction func didPressGetResult(_ sender: UIButton) {
        
        let a = Double(aTextField.text ?? "") ?? 0.0
        let b = Double(bTextField.text ?? "") ?? 3.0
        let epsilon = Double(epsilonTextField.text ?? "") ?? 0.001
        
        // Знаходження кореня
        let (x, y) = myVariantMethod(pointA: a, pointB: b, epsilon: epsilon)
        
        resultLabel.text = "x = \(x.rounded(digits: 4)), y = \(y)"
    }
    
}
