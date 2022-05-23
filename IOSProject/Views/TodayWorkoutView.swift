//
//  TodayWorkoutView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 17/05/22.
//

import SwiftUI

struct TodayWorkoutView: View {
    let workout: Workout? = Workout(id: "1", name: "Mass gainer", objective: "", type: "", days: 5, exercises: [Exercise(id: "3", name: "Chest press", imageUrl: "", videoUrl: "", reps: 12, sets: 4, currentSet: 0), Exercise(id: "2", name: "Military press", imageUrl: "", videoUrl: "", reps: 10, sets: 4, currentSet: 0)])
    let layout = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 4))
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
               Text("Today's Workout")
                    .bold()
                    .font(.title)
                        
                if workout != nil {
                    LazyVGrid(columns: layout, spacing: 10) {
                        Text("Exercise").bold()
                        Text("Reps").bold()
                        Text("Sets").bold()
                        ForEach(workout!.exercises, id: \.self) { exercise in
                            Text(exercise.name)
                            Text("\(exercise.reps)")
                            Text("\(exercise.sets)")
                        }
                    }
                    .padding()
                    .background(Color("SecondaryColorBackground"))
                    .cornerRadius(10)
                    VStack {
                        PrimaryNavigationLink(destination: ExerciseListView(exercises: workout!.exercises), label: "Start now", fullWidth: true)
                        SecondaryNavigationLink(destination: EmptyView(), label: "See more workouts", fullWidth: true)
                    }
                } else {
                    Text("You don't have any active workout")
                    Image("NoWorkoutImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    SecondaryNavigationLink(destination: EmptyView(), label: "See more workouts", fullWidth: true)
                }
                
                
            }
        }
        .padding()
        .background(Color("PrimaryColorBackground"))

        
    }
}

struct TodayWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWorkoutView().preferredColorScheme(.dark).previewInterfaceOrientation(.portraitUpsideDown)
        TodayWorkoutView().preferredColorScheme(.light)
    }
}
