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
    var db = Firestore.firestore()
    private var exericses = [Exercise]()
    @Published var activeWorkout: Workout? = nil
    @Published var allWorkouts = [Workout]()
    
    func getCurrentWorkout(workoutReference: DocumentReference, day: Int) {
        var days = 0
        var name = ""
        var objective = ""
        var type = ""
        var id = ""
        
        workoutReference.addSnapshotListener { (document, error) in
            guard let document = document, document.exists else {
                return
            }
            let dataDescription = document.data()
            days = dataDescription?["days"] as? Int ?? 0
            name = dataDescription?["name"] as? String ?? ""
            objective = dataDescription?["objective"] as? String ?? ""
            type = dataDescription?["type"] as? String ?? ""
            id = document.documentID
            
            workoutReference.collection("exercises").whereField("dayNumber", isEqualTo: day).getDocuments() {(querySnapshot, err) in
                if err != nil {
                    print("Error getting documents of exercises")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    return
                }
                self.exericses = documents.map{(queryDocumentSnapshot) -> Exercise in
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
                self.activeWorkout = Workout(id: id, name: name, objective: objective, type: type, days: days, exercises: self.exericses)
            }
        }
    }
    
    func getAllWorkouts(){
        
        self.db.collection("workouts").getDocuments() { (querySnapshot, err) in
            if err != nil {
                print("Error getting documents")
            }
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            self.allWorkouts = documents.map{(queryDocumentSnapshot) -> Workout in
                let allWorkoutsDoc = queryDocumentSnapshot.data()
                let days = allWorkoutsDoc["days"] as? Int ?? 0
                let name = allWorkoutsDoc["name"] as? String ?? ""
                let objetiveWork = allWorkoutsDoc["objective"] as? String ?? ""
                let type = allWorkoutsDoc["type"] as? String ?? ""
                let id = queryDocumentSnapshot.documentID
                
                return Workout(id: id, name: name, objective: objetiveWork, type: type, days: days, exercises: self.exericses)
            }
        }
    }

    func updateUserActiveWorkout(userReference: String, workoutReference: String) {
        
        let workoutDocReference = self.db.collection("workouts").document(workoutReference)
        
        self.db.collection("users").document(userReference).setData(["workout": workoutDocReference, "currentDay": 0], merge: true){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            self.getCurrentWorkout(workoutReference: workoutDocReference, day: 0)
        }
    }
    
    func updateCurrentDay(userReference: String, day: Int) {
        self.db.collection("users").document(userReference).setData(["currentDay": day], merge: true)
    }
    
}
