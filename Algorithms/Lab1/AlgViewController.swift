//
//  AlgViewController.swift
//  labsAMO
//
//  Created by Viktory  on 20.02.2020.
//  Copyright © 2020 Viktory. All rights reserved.
//

import UIKit

class AlgViewController: UIViewController {

    var algImage: UIImage? = UIImage()
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = algImage {
            imageView.image = image
        }
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
