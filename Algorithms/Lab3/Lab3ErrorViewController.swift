//
//  Lab3ErrorViewController.swift
//  Algorithms
//
//  Created by Денис Данилюк on 14.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab3ErrorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pointFromSegue: Double = 0.0
    
    var errorData: [(n: Int, deltaN: Double, deltaExactN: Double, k: Double)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "x = \(pointFromSegue), a = 0, b = 3, n = 10"

        setupTableView()
        
        errorData = getDeltaN(x: pointFromSegue, n: 10)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: Lab3ErrorTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: Lab3ErrorTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    private func getDeltaN(x: Double, n: Int) -> [(n: Int, deltaN: Double, deltaExactN: Double, k: Double)] {
        var resultDelta: [(n: Int, deltaN: Double, deltaExactN: Double, k: Double)] = []
        
        for n in 1...n {
            let inteerpolatedN = getInternolatedYPoint(a: 0, b: 3, countOfInterpolation: n, x: x)
            
            let inteerpolatedNPlus1 = getInternolatedYPoint(a: 0, b: 3, countOfInterpolation: n + 1, x: x)
            
            let valueFormula = sin(pow(pointFromSegue, 2)) * exp(pow((pointFromSegue / 2), 2))

            let deltaN = (inteerpolatedN - inteerpolatedNPlus1)
            let deltaExactN = (inteerpolatedN - valueFormula)
            let k = (1 - (deltaExactN / deltaN))
            
            resultDelta.append((n: n, deltaN: deltaN, deltaExactN: deltaExactN, k: k))
        }
        
        return resultDelta
    }

}


extension Lab3ErrorViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return errorData.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Lab3ErrorTableViewCell.identifier)  as? Lab3ErrorTableViewCell else { return UITableViewCell() }
        
        
        if indexPath.row ==  0 {
            cell.nLabel.text = "N"
            cell.deltaNLabel.text = "deltaN"
            cell.deltaExactNLabel.text = "exactN"
            cell.kLabel.text = "k"
            return cell
        } else {
            
            let row = errorData[indexPath.row - 1]

            cell.nLabel.text = "\(row.n)"
            cell.deltaNLabel.text = "\(row.deltaN.rounded(digits: 6))"
            cell.deltaExactNLabel.text = "\(row.deltaExactN.rounded(digits: 6))"
            cell.kLabel.text = "\(row.k.rounded(digits: 6))"
        }
        
        return cell
    }
    
    
    
}
