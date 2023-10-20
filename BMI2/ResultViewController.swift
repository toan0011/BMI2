//
//  ResultViewController.swift
//  BMI2
//
//  Created by Minh Toan on 20/10/2023.
//

import UIKit

class ResultViewController: UIViewController {
    var bmi:Float?
    var state:String?
    var comment:String?
    
    @IBOutlet weak var labelState: UILabel!
    @IBOutlet weak var labelBMI: UILabel!
    @IBOutlet weak var labelComment: UILabel!
    @IBOutlet weak var btnReCatulate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnReCatulate.layer.cornerRadius = 10
        labelState.text = state ?? ""
        labelBMI.text = String(format: "%.2f", bmi ?? 0)
        labelComment.text = comment ?? ""
    }
    
    @IBAction func reCaculate(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    
}
