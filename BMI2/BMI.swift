//
//  BMI.swift
//  BMI2
//
//  Created by Minh Toan on 20/10/2023.
//

import Foundation

struct BMI {
    var name:String?
    var gender:Gender
    var height:Float
    var weight:Int
    var age:Int
}

enum Gender{
    case Female
    case Male
}
