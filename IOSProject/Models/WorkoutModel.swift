//
//  WorkoutModel.swift
//  IOSProject
//
//  Created by Erick Mendoza on 17/05/22.
//

import Foundation

struct Workout: Identifiable {
    var id : String
    var name: String
    var objective: String
    var type: String
    var days: Int
    var exercises: [Exercise]
    
}
