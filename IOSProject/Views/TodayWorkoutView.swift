//
//  TodayWorkoutView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 17/05/22.
//

import SwiftUI
import FirebaseAuth

struct TodayWorkoutView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var workout: WorkoutViewModel = WorkoutViewModel()
    
    
    let layout = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 4))
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
               Text("Today's Workout")
                    .bold()
                    .font(.title)
                        
                if workout.activeWorkout != nil {
                    LazyVGrid(columns: layout, spacing: 10) {
                        Text("Exercise").bold()
                        Text("Reps").bold()
                        Text("Sets").bold()
                        ForEach(workout.activeWorkout!.exercises, id: \.self) { exercise in
                            Text(exercise.name)
                            Text("\(exercise.reps)")
                            Text("\(exercise.sets)")
                        }
                    }
                    .padding()
                    .background(Color("SecondaryColorBackground"))
                    .cornerRadius(10)
                    VStack {
                        PrimaryNavigationLink(destination: ExerciseListView(workoutViewModel: workout, exercises: workout.activeWorkout!.exercises), label: "Start now", fullWidth: true)
                        SecondaryNavigationLink(destination: MyWorkoutsView(workoutViewModel: workout), label: "See more workouts", fullWidth: true)
                    }
                }
                else {
                    Text("You don't have any active workout")
                    Image("NoWorkoutImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    SecondaryNavigationLink(destination: MyWorkoutsView(workoutViewModel: workout), label: "See more workouts", fullWidth: true)
                }
            }
        }
        .padding()
        .background(Color("PrimaryColorBackground"))
        .onAppear() {
            Auth.auth().currentUser?.reload()
            guard let workoutRef = authenticationViewModel.user?.workout else {
                return
            }
            workout.getCurrentWorkout(workoutReference: workoutRef, day: authenticationViewModel.user?.currentDay ?? 0 )
        }
    }
    
}

struct TodayWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWorkoutView().preferredColorScheme(.dark).previewInterfaceOrientation(.portraitUpsideDown)
        TodayWorkoutView().preferredColorScheme(.light)
    }
}
