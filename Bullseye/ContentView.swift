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
    let midnightBlue = Color(red: 0.0, green: 51.0/255, blue: 110/255)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .modifier(ShadowStyle())
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
            
        }
        
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .modifier(ShadowStyle())
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
            
        }
        
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
        
    }
    
    struct ButtonLabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
        
    }
    
    struct ButtonSmallLabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
        
    }
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(self.target)").modifier(ValueStyle())
            }
            Spacer()
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                    .accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            Button(action: {
                self.alertIsVisible = true
                
            }){
                Text("Hit Me").modifier(ButtonLabelStyle())
            }
            .background(Image("Button"))
            .modifier(ShadowStyle())
            .alert(isPresented: $alertIsVisible){
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
                    HStack{
                        Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSmallLabelStyle())
                    }
                }
                .background(Image("Button"))
                .modifier(ShadowStyle())
                .alert(isPresented: $restartIsVisible){
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
                Text("Score:").modifier(LabelStyle())
                Text("\(self.score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(self.round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack{
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallLabelStyle())
                    }
                }
                .background(Image("Button"))
                .modifier(ShadowStyle())
                .alert(isPresented: $infoIsVisible){
                    () -> Alert in return Alert(
                        title: Text("Information"),
                        message: Text("You suck."),
                        dismissButton: .default(Text("Thank You!")))
                }
            }
            .padding(.all, 20)
            .accentColor(self.midnightBlue)
            .navigationBarTitle(Text("Bullseye"))
        }
        .background(Image(decorative: "Background"), alignment: .center
        )
        .padding(.all, 40)
        
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
