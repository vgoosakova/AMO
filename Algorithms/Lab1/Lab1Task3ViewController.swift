//
//  Lab1Task3ViewController.swift
//  labsAMO
//
//  Created by Viktory  on 20.02.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class Lab1Task3ViewController: UIViewController {

    @IBOutlet weak var resLabel: UILabel!
    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var PLabel: UILabel!
    
    @IBOutlet weak var NTextField: UITextField!
    @IBOutlet weak var PTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressRead(_ sender: UIButton) {
        var array: [String] = []

        do {
            let text2 = try makeWritableCopy(named: "main.txt", ofResourceFile: "main.txt")
            let array = text2.components(separatedBy: ", ")

            NTextField.text = array[0].trimmingCharacters(in: .whitespacesAndNewlines)
            PTextField.text = array[1].trimmingCharacters(in: .whitespacesAndNewlines)
 
        } catch {
            
        }
    }
    
    func makeWritableCopy(named destFileName: String, ofResourceFile originalFileName: String) throws -> String {
            // Get Documents directory in app bundle
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("No document directory found in application bundle.")
            }

            // Get URL for dest file (in Documents directory)
            let writableFileURL = documentsDirectory.appendingPathComponent(destFileName)

            // If dest file doesn’t exist yet
            if (try? writableFileURL.checkResourceIsReachable()) == nil {
                // Get original (unwritable) file’s URL
                guard let originalFileURL = Bundle.main.url(forResource: originalFileName, withExtension: nil) else {
                    fatalError("Cannot find original file “\(originalFileName)” in application bundle’s resources.")
                }

                // Get original file’s contents
                let originalContents = try Data(contentsOf: originalFileURL)

                // Write original file’s contents to dest file
                try originalContents.write(to: writableFileURL, options: .atomic)
                print("Made a writable copy of file “\(originalFileName)” in “\(documentsDirectory)\\\(destFileName)”.")

            } else { // Dest file already exists
                // Print dest file contents
                return try String(contentsOf: writableFileURL, encoding: String.Encoding.utf8)
    //            print("File “\(destFileName)” already exists in “\(documentsDirectory)”.\nContents:\n\(contents)")
            }
            
            return ""

        }
    
    
    @IBAction func didPress(_ sender: UIButton) {
        let n = Int(NTextField.text ?? "") ?? 0
        let p = Int(PTextField.text ?? "") ?? 0
        
        var f = 0.0

        for a in 1...n {
            for b in 1...p {
                f += (pow(Double(a), Double(b)) + pow(Double(b), Double(a)))
            }
        }
        
        
        resLabel.text = "\(String(f))"
        
    }
    
    @IBAction func didPressAlgo(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let vc = mainStoryBoard.instantiateViewController(identifier: AlgViewController.identifier) as? AlgViewController else { return }
        
        vc.algImage = UIImage(named: "lab1Alg3") ?? UIImage()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
