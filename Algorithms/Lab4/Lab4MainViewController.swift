//
//  Lab4MainViewController.swift
//  Algorithms
//
//  Created by Денис Данилюк on 15.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab4MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Метод половинного ділення"
        // Do any additional setup after loading the view.
    }
    
    
    
//    func myVariantLabel(pointA: Double, pointB: Double, epsilon: Double) -> (Double, Double) {
//        var a = pointA
//        var b = pointB
//        var c = 0.0
//
//        if findY(a) * findY(b) > 0 {
//            return (0, 0)
//
//        } else if findY(a) == 0 {
//            return (a, findY(a))
//
//        } else if findY(b) == 0 {
//            return (b, findY(b))
//
//        } else {
//            c = (a + b) / 2
//
//            while !(abs(b - a) < epsilon || findY(c) == 0) {
//
//                if findY(a) * findY(c) < 0 {
//                    b = c
//                } else {
//                    a = c
//                }
//                c = (a + b) / 2
//
//            }
//            return (c, findY(c))
//        }
//    }

}
