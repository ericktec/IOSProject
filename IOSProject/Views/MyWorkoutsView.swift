//
//  TodayWorkoutView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 17/05/22.
//

import SwiftUI

struct MyWorkoutsView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var workout: WorkoutViewModel = WorkoutViewModel()
    
    let layout = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 4))
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Hello \(authenticationViewModel.user!.firstName)")
                Text("My Workouts")
                    .bold()
                    .font(.title)
                        
                if workout.allWorkouts.count > 0 {
                    ForEach(workout.allWorkouts) {workout in
                        VStack() {
                            Text(workout.name).bold()
                            Text("Type \(workout.type)")
                            Text("Days \(workout.days)")
                            Text("Objective")
                            Text(workout.objective)
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
                    SecondaryNavigationLink(destination: EmptyView(), label: "See more workouts", fullWidth: true)
                }
                
            }
        }
        .padding()
        .background(Color("PrimaryColorBackground"))
        .onAppear() {
            guard let workoutRef = authenticationViewModel.user?.workout else {
                return
            }
            workout.getCurrentWorkout(workoutReference: workoutRef)
        }
    }
}

struct MyWorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWorkoutView().preferredColorScheme(.dark).previewInterfaceOrientation(.portraitUpsideDown)
        TodayWorkoutView().preferredColorScheme(.light)
    }
}
