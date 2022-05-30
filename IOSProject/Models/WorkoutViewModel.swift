//
//  WorkoutViewModel.swift
//  IOSProject
//
//  Created by Erick Mendoza on 23/05/22.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class WorkoutViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var activeWorkout: Workout? = nil
    
    func getCurrentWorkout(workoutReference: DocumentReference) {
        var days = 0
        var name = ""
        var objective = ""
        var type = ""
        var exericses = [Exercise]()
        var id = ""
        workoutReference.getDocument { (document, error) in
            guard let document = document, document.exists else{
                return
            }
            let dataDescription = document.data()
            days = dataDescription?["days"] as? Int ?? 0
            name = dataDescription?["name"] as? String ?? ""
            objective = dataDescription?["objective"] as? String ?? ""
            type = dataDescription?["type"] as? String ?? ""
            id = document.documentID
            
            workoutReference.collection("exercises").getDocuments() {(querySnapshot, err) in
                if let err = err {
                    print("Error getting documents of exercises")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    return
                }
                exericses = documents.map{(queryDocumentSnapshot) -> Exercise in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let dayNumber = data["dayNumber"] as? Int ?? 0
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let reps = data["reps"] as? Int ?? 0
                    let sets = data["sets"] as? Int ?? 0
                    let videoUrl = data["videoUrl"] as? String ?? ""
                    return Exercise(id: id, name: name, imageUrl: imageUrl, videoUrl: videoUrl, reps: reps, sets: sets, currentSet: 0, dayNumber: dayNumber)
                }
                self.activeWorkout = Workout(id: id, name: name, objective: objective, type: type, days: days, exercises: exericses)
                print(self.activeWorkout ?? "there is no active workout")
            }
        }
    }
    
    
}
