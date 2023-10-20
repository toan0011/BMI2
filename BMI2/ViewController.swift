//
//  ViewController.swift
//  BMI2
//
//  Created by Minh Toan on 19/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let radius_10:CGFloat = 10
    let radius_15:CGFloat = 20
    
    @IBOutlet weak var btnCaculate: UIButton!
    @IBOutlet weak var viewContainAge: UIView!
    @IBOutlet weak var viewContainWeight: UIView!
    @IBOutlet weak var viewContainSlider: UIView!
    @IBOutlet weak var viewContainIconFemale: UIView!
    @IBOutlet weak var viewContainIconMale: UIView!
    
    @IBOutlet weak var txtValueAge: UILabel!
    @IBOutlet weak var txtValueWeight: UILabel!
    @IBOutlet weak var txtValueHeight: UILabel!
    @IBOutlet weak var sliderHeight: UISlider!
    @IBOutlet weak var imgPlusAge: UIImageView!
    @IBOutlet weak var imgMinusAge: UIImageView!
    @IBOutlet weak var imgPlusWeight: UIImageView!
    @IBOutlet weak var imgMinusWeight: UIImageView!
    
    var isTapedMale = false
    var height = 100
    var weight:Int = 45
    var age = 20
    var bmi:Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        btnCaculate.layer.cornerRadius = radius_10
        viewContainIconMale.layer.cornerRadius = radius_10
        viewContainIconFemale.layer.cornerRadius = radius_10
        viewContainSlider.layer.cornerRadius = radius_10
        viewContainWeight.layer.cornerRadius = radius_10
        viewContainAge.layer.cornerRadius = radius_10
        
        imgPlusAge.layer.cornerRadius = radius_15
        imgPlusWeight.layer.cornerRadius = radius_15
        imgMinusAge.layer.cornerRadius = radius_15
        imgMinusWeight.layer.cornerRadius = radius_15
    }
    
    @IBAction func tapMale(_ sender: Any) {
        if !isTapedMale {
            viewContainIconMale.backgroundColor = UIColor(red: 0.60, green: 0.53, blue: 0.52, alpha: 1.00)
            viewContainIconFemale.backgroundColor = UIColor(red: 0.21, green: 0.21, blue: 0.26, alpha: 1.00)
            isTapedMale = true
        }
        
    }
    
    @IBAction func tapFemale(_ sender: Any) {
        if isTapedMale {
            viewContainIconFemale.backgroundColor = UIColor(red: 0.60, green: 0.53, blue: 0.52, alpha: 1.00)
            viewContainIconMale.backgroundColor = UIColor(red: 0.21, green: 0.21, blue: 0.26, alpha: 1.00)
            isTapedMale = false
        }
    }
    @IBAction func changeValueSlider(_ sender: UISlider) {
        height = Int(sender.value)
        txtValueHeight.text = "\(height) cm"
    }
    @IBAction func tapMinusWeight(_ sender: Any) {
        if weight > 1 {
            weight -= 1
        }
        txtValueWeight.text = "\(weight)"
    }
    @IBAction func tapPlusWeight(_ sender: Any) {
        weight += 1
        txtValueWeight.text = "\(weight)"
    }
    @IBAction func tapMinusAge(_ sender: Any) {
        if age > 1 {
            age -= 1
        }
        txtValueAge.text = "\(age)"
    }
    @IBAction func tapPlusAge(_ sender: Any) {
        age += 1
        txtValueAge.text = "\(age)"
    }
    @IBAction func caculate(_ sender: Any) {
        bmi = Float(weight) / pow(Float(height) / 100, 2)
        print(bmi)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var resultView = mainStoryboard.instantiateViewController(identifier: "resultScreen") as! ResultViewController
        resultView.modalPresentationStyle = .fullScreen
        
        resultView.bmi = bmi
        
        if bmi < 18.5 {
            resultView.state = "THIN"
            resultView.comment = "You have a skinny body. Need nutritional supplements."
        }else if bmi >= 18.5 && bmi <= 24.9{
            resultView.state = "NORMAL"
            resultView.comment = "You have a normal body weight. Good job!"
        }else if bmi > 24.9 && bmi <= 29.9 {
            resultView.state = "CHUBBY"
            resultView.comment = "You have a slightly chubby body. Please exercise more diligently."
        }else if bmi > 29.9 && bmi <= 34.9 {
            resultView.state = "FAT"
            resultView.comment = "You have an obese body. Pay attention to nutrition and exercise."
        }else{
            resultView.state = "DANGEROUS OBESITY"
            resultView.comment = "Your body is dangerously obese. Pay attention to losing weight."
        }
        self.present(resultView, animated: true)
    }
}

