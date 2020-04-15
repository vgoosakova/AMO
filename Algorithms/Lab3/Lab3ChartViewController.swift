//
//  Lab3ChartViewController.swift
//  Algorithms
//
//  Created by Денис Данилюк on 14.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit
import Charts

class Lab3ChartViewController: UIViewController, ChartViewDelegate{

    @IBOutlet weak var chartView: LineChartView!
    
    @IBOutlet weak var chartAndErrorSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var chartsSegmentControl: UISegmentedControl!
    
    var aFromSegue: Double = 0.0
    
    var bFromSegue: Double = 3.0

    var nFromSegue: Int = 10

    var selectedFormula: AviableFormuls = .variant
    
    var allPointsData: (teoretical: (x: [Double], y: [Double]), test: (x: [Double], y: [Double]), error: (x: [Double], y: [Double]))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChartView()
        allPointsData = getData(formula: selectedFormula, a: aFromSegue, b: bFromSegue, count: nFromSegue)
        setupFunctionData()
    }
    
    
    private func setupChartView() {
        /// Main setup
        chartView.delegate = self
        chartView.chartDescription?.enabled = true
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        /// Y axis
        let leftAxis = chartView.leftAxis
        leftAxis.gridLineDashLengths = [5, 5]

        /// X axis
        let bottomAxis = chartView.xAxis
        bottomAxis.labelPosition = .bottom
        bottomAxis.gridLineDashLengths = [10, 10]
        bottomAxis.gridLineDashPhase = 0
        
        // chartView.rightAxis.enabled = false
        /// Legend
        chartView.legend.form = .square
        chartView.legend.font = NSUIFont(name: "Helvetica", size: 15) ?? NSUIFont()
        
        /// Animation
        chartView.animate(xAxisDuration: 2)
    }
    
    
    private func recalculate() {
        allPointsData = getData(formula: selectedFormula, a: aFromSegue, b: bFromSegue, count: nFromSegue)
        
        if chartAndErrorSegmentControl.selectedSegmentIndex == 0 {
            setupFunctionData()
        } else {
            setupErrorData()
        }
    }
    
    
    private func setupFunctionData() {
        var teoreticalValues: [ChartDataEntry] = []
        var testValues: [ChartDataEntry] = []
        
        guard let allPointsData = allPointsData else { return }
        
        for i in 0..<allPointsData.teoretical.x.count {
            teoreticalValues.append(ChartDataEntry(x: allPointsData.teoretical.x[i], y: allPointsData.teoretical.y[i]))
        }
        
        for i in 0..<allPointsData.test.x.count {
            testValues.append(ChartDataEntry(x: allPointsData.test.x[i], y: allPointsData.test.y[i]))
        }

        let teoreticalLine = LineChartDataSet(entries: teoreticalValues, label: "Теоретичні")
        
        teoreticalLine.setColor(.blue)
        teoreticalLine.setCircleColor(.gray)
        teoreticalLine.lineWidth = 1.5
        teoreticalLine.circleRadius = 0
        teoreticalLine.valueFont = .systemFont(ofSize: 10)
        teoreticalLine.formLineDashLengths = [5, 5]
        teoreticalLine.formLineWidth = 6
        
        teoreticalLine.drawCirclesEnabled = false
        teoreticalLine.drawValuesEnabled = false
        teoreticalLine.drawIconsEnabled = false
        teoreticalLine.drawCircleHoleEnabled = false

        
        let testLine = LineChartDataSet(entries: testValues, label: "Інтерпольовані")
    
        testLine.setColor(.black)
        testLine.setCircleColor(.gray)
        testLine.lineWidth = 1.5
        testLine.circleRadius = 3
        testLine.valueFont = .systemFont(ofSize: 10)
        testLine.formLineDashLengths = [5, 5]
        testLine.formLineWidth = 6
        
        testLine.drawIconsEnabled = false
        testLine.drawCircleHoleEnabled = false
        testLine.drawCirclesEnabled = false
        testLine.drawValuesEnabled = false
        
        
        // Setting this lines to data
        let dataChart = LineChartData(dataSets: [testLine, teoreticalLine])
        chartView.data = dataChart
    }
    
    
    private func setupErrorData() {
        guard let allPointsData = allPointsData else { return }
            
        var errorValues: [ChartDataEntry] = []
        
        for i in 0..<allPointsData.error.x.count {
            let yPoint = -1 * log10(abs(allPointsData.error.y[i]))
            if yPoint.isFinite && !yPoint.isNaN {
                errorValues.append(ChartDataEntry(x: allPointsData.error.x[i], y: yPoint))
            }
        }
        let errorLine = LineChartDataSet(entries: errorValues, label: "Оцінка похибки (Δn)")
    
        errorLine.setColor(.red)
        errorLine.setCircleColor(.gray)
        errorLine.lineWidth = 1.5
        errorLine.circleRadius = 0
        errorLine.valueFont = .systemFont(ofSize: 10)
        errorLine.formLineDashLengths = [5, 5]
        errorLine.formLineWidth = 6
        errorLine.mode = .linear
        
        errorLine.drawCirclesEnabled = false
        errorLine.drawValuesEnabled = false
        errorLine.drawIconsEnabled = false
        errorLine.drawCircleHoleEnabled = false

        
        // Setting this line to data
        let dataChart = LineChartData(dataSets: [errorLine])
        chartView.data = dataChart
    }
    
    
    @IBAction func didChangeTypeChart(_ sender: UISegmentedControl) {
        switch chartAndErrorSegmentControl.selectedSegmentIndex {
        case 0:
            setupFunctionData()
        case 1:
            setupErrorData()
        default:
            break
        }
    }
    
    
    @IBAction func didChangeChart(_ sender: UISegmentedControl) {
        switch chartsSegmentControl.selectedSegmentIndex {
        case 0:
            /// Normal graph case
            selectedFormula = .variant
            recalculate()
        case 1:
            /// Error graph case
            selectedFormula = .sinx
            recalculate()

        default:
            break
        }
    }
    

}

