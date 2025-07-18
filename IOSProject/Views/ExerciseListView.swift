//
//  ExerciseListView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 19/05/22.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var workoutViewModel: WorkoutViewModel
    @State var exercises: [Exercise]
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @State var finish: Bool = false
    @State var currentExercise = 0
    var body: some View {
        ScrollView {
            Text("Exercise list")
                .font(.title)
                .frame(alignment: .trailing)
            VStack {
                ForEach(exercises, id: \.self) {exercise in
                    HStack() {
                        ImageByURL(imageURL: exercise.imageUrl, width: 80, height: 80)
                        VStack {
                            Text(exercise.name)
                            Text("sets \(exercise.currentSet)/\(exercise.sets)")
                        }.font(.system(size: 12))
                        VStack() {
                            Spacer()

                            Text(exercise.currentSet < exercise.sets ? "Incomplete" : "Complete")
                                .foregroundColor(exercise.currentSet < exercise.sets ? .red : .green)
                                .font(.system(size: 13))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("SecondaryBlue"))
                    .cornerRadius(10)
                }
                
                VStack {
                    if(!finish) {
                        PrimaryNavigationLink(destination: ExerciseView(exercise: $exercises, finish: $finish, currentExercise: $currentExercise, workoutViewModel: workoutViewModel), label: "Start Workout", fullWidth: true)
                    }
                    
                    
                    SecondaryButton(label: "Return", fullWidth: true) {
                        self.mode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color("PrimaryColorBackground"))
        .navigationBarHidden(true)
    }
}

//struct ExerciseListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseListView(exericses: [Exercise(id: "3", name: "Chest press", imageUrl: "https://i.blogs.es/b86c79/1366_2000-1-/840_560.jpeg", videoUrl: "", reps: 12, sets: 4, currentSet: 0, dayNumber: 0), Exercise(id: "2", name: "Military press", imageUrl:"https://i.blogs.es/b86c79/1366_2000-1-/840_560.jpeg" , videoUrl: "", reps: 10, sets: 4, currentSet: 0, dayNumber: 1)], authenticationViewModel: WorkoutViewModel(), workoutViewModel: WorkoutViewModel()).preferredColorScheme(.dark)
//    }
//}
