//
//  Timer.swift
//  IOSProject
//
//  Created by Erick Mendoza on 16/05/22.
//

import SwiftUI

struct TimerExcercise: View {
    
    let timerPublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    private var counter: CGFloat
    @State private var timeRemaining: CGFloat
    @State private var WavePercentage: CGFloat
    
    init(timeToCount counter: CGFloat) {
        self.timeRemaining = counter
        self.counter = counter
        self.WavePercentage = 1
    }
    
    var body: some View {
        ZStack {
            WaveForm(color: Color("PrimaryOrange"), amplify: 150, wavePercentage: $WavePercentage)
            Text("\(Int(timeRemaining))")
                .onReceive(timerPublisher) { time in
                    if(self.timeRemaining == 1 ) {
                        timerPublisher.upstream.connect().cancel()
                    }
                    timeRemaining -= 1
                    WavePercentage = timeRemaining / counter
                    
                }
                .foregroundColor(.white)
                .font(.system(size: 100, weight: .bold))
                
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .frame(width: .infinity, height: .infinity, alignment: .center)
    }
}

struct TimerExcercise_Previews: PreviewProvider {
    static var previews: some View {
        TimerExcercise(timeToCount: 60).preferredColorScheme(.dark)
    }
}


struct WaveForm: View {
    var color: Color
    var amplify: CGFloat
    @Binding var wavePercentage: CGFloat
    
    var body: some View {
        // Periodic updates
        TimelineView(.animation) {timeline in
            Canvas {context, size in
                
                let timeNow = timeline.date.timeIntervalSinceReferenceDate
                let angle = timeNow.remainder(dividingBy: 2)
                let offset = angle * size.width
                context.translateBy(x: offset, y: 0)
                
                context.fill(getPath(size: size), with: .color(color))
                
                context.translateBy(x: -size.width, y: 0)
                
                context.fill(getPath(size: size), with: .color(color))
                
                context.translateBy(x: size.width*2, y: 0)
                
                context.fill(getPath(size: size), with: .color(color))
                
            }
        }
    }
    
    func getPath(size: CGSize) -> Path {
        return Path{path in
            let height = (size.height - size.height * 0.1) * (1-wavePercentage)
            let width = size.width
            
            // move the wave to center
            path.move(to: CGPoint(x: 0, y: height))
            
            //draw one curve
            path.addCurve(to: CGPoint(x:width, y:height), control1: CGPoint(x:width*0.5, y:height + amplify), control2: CGPoint(x: width*0.5, y: height - amplify))
            
            path.addLine(to: CGPoint(x: width, y:size.height))
            path.addLine(to: CGPoint(x:0, y: size.height))
            
        }
    }
}
