//
//  Lab4+Extenisons.swift
//  Algorithms
//
//  Created by Денис Данилюк on 15.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit


extension UIViewController {
    
    //Отримання y за формулою
    func getYFromFormula(_ x: Double) -> Double{
        return pow(2, x) - 4 * x
    }

    // Метод половинного ділення
    func myVariantMethod(pointA: Double, pointB: Double, epsilon: Double) -> (Double, Double) {
        var a = pointA
        var b = pointB
        var c = 0.0

        if getYFromFormula(a) * getYFromFormula(b) > 0 {
            return (0, 0)
        } else if getYFromFormula(a) == 0 {
            return (a, getYFromFormula(a))
        } else if getYFromFormula(b) == 0 {
            return (b, getYFromFormula(b))
        } else {
            c = (a + b) / 2

            while !(abs(b - a) < epsilon || getYFromFormula(c) == 0) {

                if getYFromFormula(a) * getYFromFormula(c) < 0 {
                    b = c
                } else {
                    a = c
                }
                c = (a + b) / 2

            }
            return (c, getYFromFormula(c))
        }
    }

}
