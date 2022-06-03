//
//  TodayWorkoutView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 17/05/22.
//

import SwiftUI
import FirebaseAuth

struct MyWorkoutsView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var workoutModel: WorkoutViewModel = WorkoutViewModel()
    
    let layout = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 4))
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("My Workouts")
                    .bold()
                    .font(.title)
                        
                if workoutModel.allWorkouts.count > 0 {
                    ForEach(workoutModel.allWorkouts) {workout in
                        VStack() {
                            Text(workout.name).bold()
                            Text("Type \(workout.type)")
                            Text("Days \(workout.days)")
                            Text("Objective")
                            Text(workout.objective)
                            Button(
                                action: {
                                    authenticationViewModel.user?.workout = workoutModel.db.collection("workouts").document(workout.id)
                                    workoutModel.updateUserActiveWorkout(userReference: authenticationViewModel.user!.id, workoutReference: workout.id)
                                    //repull user data
                                }
                            ) { Text("Activate") }
                            // Button con onClick workout.activeWorkout = workout
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("SecondaryBlue"))
                        .cornerRadius(10)
                    }
                }
                else {
                    Text("There arent any workouts yet")
                    Image("NoWorkoutImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
            }
        }
        .padding()
        .background(Color("PrimaryColorBackground"))
        .onAppear() {
            guard let workoutRef = authenticationViewModel.user?.workout else {
                return
            }
            workoutModel.getAllWorkouts(workoutReference: workoutRef)
        }
    }
}

struct MyWorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWorkoutView().preferredColorScheme(.dark).previewInterfaceOrientation(.portraitUpsideDown)
        TodayWorkoutView().preferredColorScheme(.light)
    }
}
