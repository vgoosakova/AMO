//
//  Lab2Task1ViewController.swift
//  labsAMO
//
//  Created by Viktory  on 26.02.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab2Task1ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var afterLabel: UILabel!
    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var nTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    @IBAction func didPressGraphic(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let vc = mainStoryBoard.instantiateViewController(identifier: GraphicViewController.identifier) as? GraphicViewController else { return }
    
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func didPressResult(_ sender: UIButton) {
        var arr = createArray(nTextField)
        let startArr = arr
        print(arr)
        let start = Date()
        radixSort1(&arr)
        let end = Date()
        let timeInterval: Double = end.timeIntervalSince(start)
        print(" ")
        print(arr)
        afterLabel.text = "Відстортований [n] : \(arr.description)"
        beforeLabel.text = "Початковий [n] : \(startArr.description)"
        timeLabel.text = "Елементів: \(startArr.count) Час: \(timeInterval.rounded(digits: 6))"
    }
    
    func createArray(_ textFied: UITextField) -> [Int] {
        let n = Int((textFied.text ?? "").replacingOccurrences(of: ",", with: ".")) ?? 0
        
        var array: [Int] = []
        
        for _ in 1...n {
            array.append(Int.random(in: 1..<100))
        }
        return array
    }
    func radixSort1(_ arr: inout [Int] ) {
      let radix = 10  //Here we define our radix to be 10
      var done = false
      var index: Int
      var digit = 1  //Which digit are we on?
      while !done {  //While our  sorting is not completed
        done = true  //Assume it is done for now
        var buckets: [[Int]] = []  //Our sorting subroutine is bucket sort, so let us predefine our buckets
        for _ in 1...radix {
          buckets.append([])
        }

        for number in arr {
          index = number / digit  //Which bucket will we access?
          buckets[index % radix].append(number)
          if done && index > 0 {  //If we arent done, continue to finish, otherwise we are done
            done = false
          }
        }

        var i = 0

        for j in 0..<radix {
          let bucket = buckets[j]
          for number in bucket {
            arr[i] = number
            i += 1
          }
        }

        digit *= radix  //Move to the next digit
      }
        
    }

    /*
    func radixSort1(_ arr: inout [Int]) {

        var temp = [[Int]](repeating: [], count: 10)

        for num in arr { temp[num % 10].append(num) }

        for i in 1...Int(arr.max()!.description.count) {

            for index in 0..<temp.count {

                for num in temp[index] {
                    temp[index].remove(at: temp[index].firstIndex(of: num)!)
                    temp[(num / Int(pow(10, Double(i)))) % 10].append(num)
                }
            }
        }

        arr = temp[0]
    } */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
