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
    var isTapedFemale = false
    var height = 150
    var weight:Int = 45
    var age = 20
    var bmi:Float = 0.0
    var timer:Timer!
    
    enum Action {
        case IncreaseWeight
        case DecreaseWeight
        case IncreaseAge
        case DecreaseAge
        case None
    }
    var action:Action = .None
    
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
            isTapedFemale = false
        }
        
    }
    
    @IBAction func tapFemale(_ sender: Any) {
        if !isTapedFemale {
            viewContainIconFemale.backgroundColor = UIColor(red: 0.60, green: 0.53, blue: 0.52, alpha: 1.00)
            viewContainIconMale.backgroundColor = UIColor(red: 0.21, green: 0.21, blue: 0.26, alpha: 1.00)
            isTapedMale = false
            isTapedFemale = true
        }
    }
    @IBAction func changeValueSlider(_ sender: UISlider) {
        height = Int(sender.value)
        txtValueHeight.text = "\(height) cm"
    }
    @IBAction func tapMinusWeight(_ sender: Any) {
        decreaseWeight()
    }
    @IBAction func tapPlusWeight(_ sender: Any) {
        increaseWeight()
    }
    @IBAction func tapMinusAge(_ sender: Any) {
        decreaseAge()
    }
    @IBAction func tapPlusAge(_ sender: Any) {
        increaseAge()
    }
    
    func decreaseWeight(){
        if weight > 10{
            weight -= 1
        }
        txtValueWeight.text = "\(weight)"
    }
    func decreaseAge(){
        if age > 1 {
            age -= 1
        }
        txtValueAge.text = "\(age)"
    }
    func increaseWeight(){
        if weight < 150{
            weight += 1
        }
        
        txtValueWeight.text = "\(weight)"
    }
    func increaseAge(){
        if age < 120 {
            age += 1
        }
        
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
        }else if bmi <= 24.9{
            resultView.state = "NORMAL"
            resultView.comment = "You have a normal body weight. Good job!"
        }else if bmi <= 29.9 {
            resultView.state = "CHUBBY"
            resultView.comment = "You have a slightly chubby body. Please exercise more diligently."
        }else if bmi <= 34.9 {
            resultView.state = "FAT"
            resultView.comment = "You have an obese body. Pay attention to nutrition and exercise."
        }else{
            resultView.state = "DANGEROUS OBESITY"
            resultView.comment = "Your body is dangerously obese. Pay attention to losing weight."
        }
        self.present(resultView, animated: true)
    }
    @IBAction func longPressMinusWeight(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began{
            action = .DecreaseWeight
            startTimer()
        }else if sender.state == .ended {
            action = .None
            stopTimer()
        }
    }
    
    @IBAction func longPressPlusWeight(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began{
            action = .IncreaseWeight
            startTimer()
        }else if sender.state == .ended {
            action = .None
            stopTimer()
        }
    }
    @IBAction func longPressMinusAge(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began{
            action = .DecreaseAge
            startTimer()
        }else if sender.state == .ended {
            action = .None
            stopTimer()
        }
    }
    @IBAction func longPressPlusAge(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began{
            action = .IncreaseAge
            startTimer()
        }else if sender.state == .ended {
            action = .None
            stopTimer()
        }
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func stopTimer(){
        timer.invalidate()
    }
    
    @objc func runTimer(){
        switch action {
        case .DecreaseWeight:
            decreaseWeight()
        case .IncreaseWeight:
            increaseWeight()
        case .DecreaseAge:
            decreaseAge()
        case .IncreaseAge:
            increaseAge()
        default:
            break
        }
    }
}

