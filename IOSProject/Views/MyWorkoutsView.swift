//
//  TodayWorkoutView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 17/05/22.
//

import SwiftUI

struct MyWorkoutsView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var workoutViewModel: WorkoutViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
       
        
        ScrollView {
            if workoutViewModel.allWorkouts.count > 0 {
                ForEach(workoutViewModel.allWorkouts) { workout in
                    VStack(alignment: .leading, spacing: 5) {
                        Group {
                            HStack {
                                Text(workout.name)
                                    .font(.headline)
                                Spacer()
                                Button(action: {
                                    workoutViewModel.updateUserActiveWorkout(userReference: authenticationViewModel.user!.id, workoutReference: workout.id)
                                    authenticationViewModel.user?.workout = workoutViewModel.db.collection("workouts").document(workout.id)
                                    self.mode.wrappedValue.dismiss()
                                    
                                },
                                       label: {
                                    Image(systemName:  "power.circle")
                                        .foregroundColor(
                                            (workoutViewModel.activeWorkout != nil) && (workoutViewModel.activeWorkout!.id == workout.id ) ? .green : .primary
                                        )
                                })
                                    .disabled(workoutViewModel.activeWorkout != nil && workoutViewModel.activeWorkout!.id == workout.id )
                                
                            }
                            HStack {
                                Text("Type")
                                Text(workout.type)
                            }
                            
                            HStack {
                                Text("Days")
                                Text("\(workout.days)")
                            }
                            
                            Text("Objective").bold()
                            Text(workout.objective)
                        }
                        .padding(.horizontal)
                        Spacer()
                        HStack {
                            Spacer()
                            Text(
                                (workoutViewModel.activeWorkout != nil) && (workoutViewModel.activeWorkout!.id == workout.id )
                                ? "Activated" : "Disabled"
                            )
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .background(
                                    (workoutViewModel.activeWorkout != nil) && (workoutViewModel.activeWorkout!.id == workout.id ) ?
                                        Color("PrimaryOrange")
                                    :
                                        .clear
                                )
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("PrimaryOrange"))
                                )
                                .foregroundColor(.primary)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.top])
                    .background(Color("SecondaryColorBackground"))
                    .cornerRadius(10)
                }
                
            }
            else {
                Group {
                    Text("There arent any workouts yet")
                    Image("NoWorkoutImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    SecondaryButton(label: "Return", fullWidth: true) {
                        self.mode.wrappedValue.dismiss()
                    }
                }
                .onAppear() {
                    workoutViewModel.getAllWorkouts()
                }
                
            }
            
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("PrimaryColorBackground"))
    }
}

struct MyWorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        MyWorkoutsView(workoutViewModel: WorkoutViewModel()).preferredColorScheme(.dark)
            .environmentObject(AuthenticationViewModel())
        MyWorkoutsView(workoutViewModel: WorkoutViewModel()).preferredColorScheme(.light)
            .environmentObject(AuthenticationViewModel())

        
    }
}
