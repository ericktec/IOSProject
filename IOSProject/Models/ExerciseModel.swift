//
//  ExerciseModel.swift
//  IOSProject
//
//  Created by Erick Mendoza on 17/05/22.
//

import Foundation

struct Exercise: Identifiable, Hashable {
    var id: String
    var name: String
    var imageUrl: String
    var videoUrl: String
    var reps: Int
    var sets: Int
    var currentSet: Int
    var dayNumber: Int
}


class CurrentExercise: ObservableObject {
    var exercise: Exercise
    init(exercise: Exercise) {
        self.exercise = exercise
    }
}
