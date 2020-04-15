//
//  Lab3+Extensions.swift
//  Algorithms
//
//  Created by Денис Данилюк on 14.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

enum AviableFormuls: String {
    case variant = "sin(x^2) * e^((-x/2)^2)"
    case sinx = "sin(x)"
}

extension UIViewController {
    
    func aitkenFormula(x: [Double], y: [Double], x0: Double) -> Double {
        
        let n = x.count
        var p: [Double] = []
        
        for _ in 0..<n {
            p.append(contentsOf: [0])
        }
        
        for k in 0..<n {
            let some = n - k
            for i in 0..<some {
                if k == 0 {
                    p[i] = y[i]
                } else {
                    p[i] = ((x0-x[i+k])*p[i]+(x[i]-x0)*p[i+1])/(x[i]-x[i+k])
                }
            }
        }
        return p[0]
    }
    

    func getFormulaData(formula: AviableFormuls, a: Double, b: Double, count: Int = 10) -> (x: [Double], y: [Double]) {
        let h: Double = (b - a) / Double(count)
       
        var x: [Double] = []
        var y: [Double] = []

        for i in 0...count {
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
    
    
    func getInternolatedArray(formula: AviableFormuls, a: Double, b: Double, countOfInterpolation: Int, countOfArray: Int) -> (x: [Double], y: [Double]) {
        
        let (xTeoretical, yTeoretical) = getFormulaData(formula: formula, a: a, b: b, count: countOfInterpolation)
        
        let xTest = getFormulaData(formula: formula, a: a, b: b, count: countOfArray).x
        
        var yResult: [Double] = []
        
        for x in xTest {
            yResult.append(aitkenFormula(x: xTeoretical, y: yTeoretical, x0: x))
        }

        return (x: xTest, y: yResult)
    }
    
    
    func getInternolatedYPoint(a: Double, b: Double, countOfInterpolation: Int, x: Double) -> Double {
        
        let (xTeoretical, yTeoretical) = getFormulaData(formula: .variant, a: a, b: b, count: countOfInterpolation)

        let y = aitkenFormula(x: xTeoretical, y: yTeoretical, x0: x)
        
        return y
    }
    
    
    func getData(formula: AviableFormuls, a: Double, b: Double, count: Int) ->
                (teoretical: (x: [Double], y: [Double]),
                 test: (x: [Double], y: [Double]),
                 error: (x: [Double], y: [Double])) {
                                        
        let (xTeoretical, yTeoretical) = getFormulaData(formula: formula, a: a, b: b, count: 1000)
        
        let (xTestLagrange, yTestLagrange) = getInternolatedArray(formula: formula, a: a, b: b, countOfInterpolation: count, countOfArray: 1000)
        
        let yTestLagrangeP1 = getInternolatedArray(formula: formula, a: a, b: b, countOfInterpolation: count + 1, countOfArray: 1000).y
        
        var yErrors: [Double] = []
        for i in 0..<yTestLagrangeP1.count {
            yErrors.append((yTestLagrange[i] - yTestLagrangeP1[i]))

        }
              
        let teoretical: (x: [Double], y: [Double]) = (xTeoretical, yTeoretical)
                        
        let test: (x: [Double], y: [Double]) = (xTestLagrange, yTestLagrange)
                        
        let error: (x: [Double], y: [Double]) = (xTestLagrange, yErrors)

        return (teoretical, test, error)
    }
}
