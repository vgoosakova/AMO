//
//  Lab3+Extensions.swift
//  Algorithms
//
//  Created by Денис Данилюк on 14.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

// Енумерція з  можливими формулами для обчислення
enum AviableFormuls: String {
    case variant = "sin(x^2) * e^((-x/2)^2)"
    case sinx = "sin(x)"
}


extension UIViewController {
    
    // Формула схеми Ейткена
    func aitkenFormula(xArray: [Double], yArray: [Double], x0Point: Double) -> Double {
        let nCount = xArray.count
        var p = Array(repeating: 0.0, count: nCount)
        
        for k in 0..<nCount {
            let some = nCount - k
            for i in 0..<some {
                if k == 0 {
                    p[i] = yArray[i]
                } else {
                    p[i] = ((x0Point - xArray[i+k]) * p[i] + (xArray[i] - x0Point) * p[i+1]) / (xArray[i] - xArray[i+k])
                }
            }
        }
        return p[0]
    }
    
    
    // Отримання массиву значеннь за заданною формулою від a до b
    func formulaData(formula: AviableFormuls, a: Double, b: Double, countValues: Int = 10) -> (x: [Double], y: [Double]) {
        let h: Double = (b - a) / Double(countValues)
       
        var x: [Double] = []
        var y: [Double] = []

        for i in 0...countValues {
            x.append(a + (h * Double(i)))
            switch formula {
            case .variant:
                y.append(sin(pow(x[i], 2)) * exp(pow((-x[i] / 2), 2)))
            case .sinx:
                y.append(sin(x[i]))
            }
        }
        
        return (x, y)
    }
        
    
    // Отримання массиву інтерпольованих значеннь за заданною формулою від a до b
    func internolatedArray(formula: AviableFormuls, a: Double, b: Double, countOfInterpolation: Int, countOfArray: Int) -> (x: [Double], y: [Double]) {
        
        let (xTeoretical, yTeoretical) = formulaData(formula: formula, a: a, b: b, countValues: countOfInterpolation)
        
        let xInterpolated = formulaData(formula: formula, a: a, b: b, countValues: countOfArray).x
        
        var yInterpolated: [Double] = []
        for x in xInterpolated {
            yInterpolated.append(aitkenFormula(xArray: xTeoretical, yArray: yTeoretical, x0Point: x))
        }

        return (x: xInterpolated, y: yInterpolated)
    }
    

    // Отримання інтерпольвaного y за заданним x
    func internolatedYPoint(a: Double, b: Double, countOfInterpolation: Int, x: Double) -> Double {
        
        let (xTeoretical, yTeoretical) = formulaData(formula: .variant, a: a, b: b, countValues: countOfInterpolation)
        return aitkenFormula(xArray: xTeoretical, yArray: yTeoretical, x0Point: x)
    }
    
    
    // Отримання всіх массівів з данними (теоретичні, практичні,похибки)
    func getFullData(aviableFormula: AviableFormuls, a: Double, b: Double, count: Int, accurateCount: Int = 1000) ->
                (teoreticalValues: (x: [Double], y: [Double]),
                 testValues: (x: [Double], y: [Double]),
                 errorValues: (x: [Double], y: [Double])) {
        
        let (xTeoretical, yTeoretical) = formulaData(formula: aviableFormula, a: a, b: b, countValues: accurateCount)
        
        let (xTestLagrange, yTestLagrange) = internolatedArray(formula: aviableFormula, a: a, b: b, countOfInterpolation: count, countOfArray: accurateCount)
        
        let yTestLagrangeNext = internolatedArray(formula: aviableFormula, a: a, b: b, countOfInterpolation: count + 1, countOfArray: accurateCount).y
        
        var yErrors: [Double] = []
        for i in 0..<yTestLagrangeNext.count {
            yErrors.append((yTestLagrange[i] - yTestLagrangeNext[i]))
        }
              
        let teoreticalValues: (x: [Double], y: [Double]) = (xTeoretical, yTeoretical)
        let testValues: (x: [Double], y: [Double]) = (xTestLagrange, yTestLagrange)
        let errorValues: (x: [Double], y: [Double]) = (xTestLagrange, yErrors)

        return (teoreticalValues, testValues, errorValues)
    }
}
