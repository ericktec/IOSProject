//
//  ExerciseView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 29/05/22.
//

import SwiftUI

struct ExerciseView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State var selectedItem:String = "Image"
    @State var isBreak: Bool = false
    @Binding var exercise: [Exercise]
    @Binding var finish: Bool
    @Binding var currentExercise: Int
    
    var body: some View {
        if(!isBreak) {
            ScrollView {
                
                VStack {
                    //Tabs
                    Group {
                        VStack(alignment: .leading) {
                            HStack() {
                                Button("Image") {
                                    selectedItem = "Image"
                                }
                                .foregroundColor(.primary)
                                .padding([.horizontal, .vertical], 10)
                                .background(selectedItem == "Image" ? Color("PrimaryOrange") : .black.opacity(0.0))
                                Button("Video") {
                                    selectedItem = "Video"
                                }
                                .foregroundColor(.primary)
                                .padding([.horizontal, .vertical], 10)
                                .background(selectedItem == "Video" ? Color("PrimaryOrange") : .black.opacity(0.0))
                            }
                            if(selectedItem == "Image") {
                                ImageByURL(imageURL: exercise[currentExercise].imageUrl, width: .infinity, height: .infinity)
                            }
                            else {
                                VideoView(videoID: exercise[currentExercise].videoUrl)
                                    .aspectRatio(contentMode: .fit)
                            }
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text(exercise[currentExercise].name)
                            .bold()
                        Text("\(exercise[currentExercise].currentSet) / \(exercise[currentExercise].sets) sets")
                        Text("\(exercise[currentExercise].reps) reps")
                    }
                    
                    VStack {
                        PrimaryButton(label: "Complete", fullWidth: true) {
                            isBreak = true
                        }
                        
                        SecondaryButton(label: "Cancel workout", fullWidth: true) {
                            self.mode.wrappedValue.dismiss()
                        }
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color("PrimaryColorBackground"))
            .navigationBarHidden(true)
        } // end if
        else {
            TimerExcercise(timeToCount: 2) {
                
                exercise[currentExercise].currentSet += 1
                if(exercise[currentExercise].currentSet >= exercise[currentExercise].sets) {
                    if(currentExercise + 1 >= exercise.count) {
                        self.mode.wrappedValue.dismiss()
                        finish = true
                    } else {
                        currentExercise+=1
                    }
                }
                isBreak = false
            }
        }
        
        
    }
}

//struct ExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseView(exercise: .constant([Exercise(id: "3", name: "Chest press", imageUrl: "https://i.blogs.es/b86c79/1366_2000-1-/840_560.jpeg", videoUrl: "ptpmRrzRtWQ", reps: 12, sets: 4, currentSet: 0, dayNumber: 0)])).preferredColorScheme(.dark)
//    }
//}
