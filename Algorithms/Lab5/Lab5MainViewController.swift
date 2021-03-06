//
//  Lab5MainViewController.swift
//  Algorithms
//
//  Created by Денис Данилюк on 17.04.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab5MainViewController: UIViewController {
    
    @IBOutlet weak var x11TextField: UITextField!
    @IBOutlet weak var x12TextField: UITextField!
    @IBOutlet weak var x13TextField: UITextField!
    @IBOutlet weak var x14TextField: UITextField!
    @IBOutlet weak var x1AnswerTextField: UITextField!
    
    
    @IBOutlet weak var x21TextField: UITextField!
    @IBOutlet weak var x22TextField: UITextField!
    @IBOutlet weak var x23TextField: UITextField!
    @IBOutlet weak var x24TextField: UITextField!
    @IBOutlet weak var x2AnswerTextField: UITextField!
    
    
    @IBOutlet weak var x31TextField: UITextField!
    @IBOutlet weak var x32TextField: UITextField!
    @IBOutlet weak var x33TextField: UITextField!
    @IBOutlet weak var x34TextField: UITextField!
    @IBOutlet weak var x3AnswerTextField: UITextField!
    
    
    @IBOutlet weak var x41TextField: UITextField!
    @IBOutlet weak var x42TextField: UITextField!
    @IBOutlet weak var x43TextField: UITextField!
    @IBOutlet weak var x44TextField: UITextField!
    @IBOutlet weak var x4AnswerTextField: UITextField!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    var data: (main: [[Double]], answer: [Double])?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "М. Г ауса з вибором головного елемента"
        hideKeyboard()
        data = makeMatrix()
    }
    
    
    // Отримання введеної матріці
    private func makeMatrix() -> (main: [[Double]], answer: [Double]) {
        
        let textFieldArrayMain: [[UITextField]] = [[x11TextField, x12TextField, x13TextField, x14TextField],
                                                   [x21TextField, x22TextField, x23TextField, x24TextField],
                                                   [x31TextField, x32TextField, x33TextField, x34TextField],
                                                   [x41TextField, x42TextField, x43TextField, x44TextField]]
        
        let textFieldArrayAnwer: [UITextField] = [x1AnswerTextField, x2AnswerTextField, x3AnswerTextField, x4AnswerTextField]
        
        var mainMatrix: [[Double]] = []
        var answerMatrix: [Double] = []

        for i in 0..<textFieldArrayMain.count {
            let rowTextField = textFieldArrayMain[i]
            var row: [Double] = []
            for j in 0..<rowTextField.count {
                let element = getValueFromTextField(rowTextField[j])
                row.append(element)
            }
            mainMatrix.append(row)
        }
        
        for textField in textFieldArrayAnwer {
            answerMatrix.append(getValueFromTextField(textField))
        }
        
        return (main: mainMatrix, answer: answerMatrix)
    }
    

    // Отримання результату
    @IBAction func didPressGetResult(_ sender: UIButton) {
        data = makeMatrix()
        
        guard let dataMain = data?.main, let dataAnswer = data?.answer else { return }
        let result = gaussForward(array: dataMain, arrayAnswers: dataAnswer)
        
        var resultText = String()
        for i in 0..<result.count {
            let x = result[i]
            resultText += "x\(i + 1) = \(x.rounded(digits: 5)) \n"
        }
        
        resultLabel.text = resultText
    }
    
    
    // Перевід значення з текстового поля у Double
    func getValueFromTextField(_ textField: UITextField) -> Double {
        let stringValue = textField.text ?? ""
        return Double(stringValue) ?? 0.0
    }
    
    
    // Метод Гауса з вибором головного елемента
    // Прямий хід
    func gaussForward(array: [[Double]], arrayAnswers: [Double], startLine: Int = 0) -> [Double] {
        
        if startLine == array.count - 1 {
            // Початок зворотнього ходу
            return gaussReverse(array: array, arrayAnswers: arrayAnswers)
        }
        
        // Массив основними значеннями
        var arrayToEdit: [[Double]] = array
        
        // Массив вільними коефіціентами
        var arrayAnswersToEdit: [Double] = arrayAnswers
        
        // Дільник
        let valueDivider = arrayToEdit[startLine][startLine]
        
        if valueDivider == 0 {
            // Перестановка рядків
            let rowNumberToInsert = findAbsMaxInColumn(arrayToEdit, column: startLine, startRow: startLine).rowNumber
            
            let lineToRemove = arrayToEdit.remove(at: rowNumberToInsert)
            arrayToEdit.insert(lineToRemove, at: startLine)
            
            let answerToRemove = arrayAnswersToEdit.remove(at: rowNumberToInsert)
            arrayAnswersToEdit.insert(answerToRemove, at: startLine)
            
            return gaussForward(array: arrayToEdit, arrayAnswers: arrayAnswersToEdit, startLine: startLine + 1)
        }
        
        for i in startLine + 1..<array.count {
            
            // Значення M
            let M = arrayToEdit[i][startLine] / valueDivider
            
            // Видалення рядків та відповідей
            arrayToEdit.remove(at: i)
            arrayAnswersToEdit.remove(at: i)
            
            // Вставлення рядків та відповідей обчисленних за формулою
            arrayToEdit.insert(countNextLine(line: array[startLine], nextLine: array[i], M: M), at: i)
            arrayAnswersToEdit.insert((arrayAnswers[i] - M * arrayAnswers[startLine]).rounded(digits: 8), at: i)
        }
        
        return gaussForward(array: arrayToEdit, arrayAnswers: arrayAnswersToEdit, startLine: startLine + 1)
    }
    
    
    // Метод Гауса з вибором головного елемента
    // Зворотній хід
    func gaussReverse(array: [[Double]], arrayAnswers: [Double]) -> [Double] {
        var resultArray: [Double] = Array(repeating: 0.0, count: array.count)
        
        for i in stride(from: array.count - 1, to: -1, by: -1) {
            var sum = 0.0
            for j in 0..<array.count {
                if i != j {
                    sum += array[i][j] * resultArray[j]
                }
            }
            resultArray.remove(at: 0)
            resultArray.insert((arrayAnswers[i] - sum) / array[i][i], at: i)
        }
        
        return resultArray
    }
    
    
    // Обчислення наступного рядка за формулою
    func countNextLine(line: [Double], nextLine: [Double], M: Double) -> [Double] {
        var result: [Double] = []
        
        for i in 0..<nextLine.count {
            result.append((nextLine[i] - M * line[i]).rounded(digits: 8))
        }
        return result
    }
    
    
    // Функція знаходження максимального абсолютного значення
    func findAbsMaxInColumn(_ dataArray: [[Double]], column: Int, startRow: Int = 0) -> (rowNumber: Int, maxValue: Double) {

        var rowNumber: Int = 0
        var maxValue: Double = abs(dataArray[startRow][column])
                
        for actualRowNumber in startRow + 1..<dataArray.count {
            let element = dataArray[actualRowNumber][column]
            if abs(maxValue) < abs(element) {
                maxValue = element
                rowNumber = actualRowNumber
            }
        }
        
        return (rowNumber: rowNumber, maxValue: maxValue)
    }
}
