//
//  ContentView.swift
//  Bullseye
//
//  Created by Michael Street on 8/24/20.
//  Copyright © 2020 Michael Street. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var restartIsVisible: Bool = false
    @State var infoIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    @State var score: Int = 0
    @State var round: Int = 1
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(self.target)")
            }
            Spacer()
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            Button(action: {
                self.alertIsVisible = true
                
            }){
                Text("Hit Me")
            }.alert(isPresented: $alertIsVisible){
                () -> Alert in
                let roundedValue: Int = Int(self.sliderValue.rounded())
                let currentScore = self.pointsForCurrentRound(value: roundedValue, target: self.target)
               
                return Alert(
                    title: Text("\(self.alertTitle(score: currentScore))"),
                    message: Text("The slider value is \(roundedValue).\n" +
                        "You scored \(currentScore) points this round."),
                    dismissButton: .default(Text("Thank You!")){
                        let scoreForRound = self.pointsForCurrentRound(value: Int(self.sliderValue.rounded()), target: self.target)
                        self.score += scoreForRound
                        self.target = Int.random(in: 1...100)
                        self.round += 1
                    })
            }
            Spacer()
            HStack {
                Button(action: {
                    self.restartIsVisible = true
                }){
                    Text("Start Over")
                }.alert(isPresented: $restartIsVisible){
                    () -> Alert in return Alert(
                        title: Text("Start Over"),
                        message: Text("Are you sure?"),
                        dismissButton: .default(Text("Start Over")){
                            self.score = 0
                            self.target = Int.random(in: 1...100)
                            self.round = 1
                        })
                }
                Spacer()
                Text("Score:")
                Text("\(self.score)")
                Spacer()
                Text("Round:")
                Text("\(self.round)")
                Spacer()
                Button(action: {
                    self.infoIsVisible = true
                }){
                    Text("Info")
                }.alert(isPresented: $infoIsVisible){
                    () -> Alert in return Alert(
                        title: Text("Information"),
                        message: Text("You suck."),
                        dismissButton: .default(Text("Thank You!")))
                }
            }.padding(.bottom, 20)
        }
    }
    func pointsForCurrentRound(value: Int, target: Int) -> Int {
        let points = 100 - abs(target - value)
        switch points {
        case 100:
            return 200
        case 99:
            return 150
        default:
            return points
        }
    }
    func alertTitle(score: Int) -> String {
        switch score {
        case 0...50:
            return "Terrible."
        case 51...75:
            return "Close!"
        case 75...98:
            return "Awesome!"
        case 100:
            return "Perfect!"
        default:
            return "Try again!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414
            ))
    }
}
