//
//  ContentView.swift
//  Bullseye
//
//  Created by Michael Street on 8/24/20.
//  Copyright © 2020 Michael Street. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var restartIsVisible: Bool = false
    @State var infoIsVisible: Bool = false
    
    
    var body: some View {
        VStack{
            
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("100")
            }
            
            HStack {
                Text("1")
                Slider(value: .constant(10))
                Text("100")
            }
            
            HStack {
                Button(action: {
                    self.restartIsVisible = true
                }){
                    Text("Start Over")
                }.alert(isPresented: $restartIsVisible){
                    () -> Alert in return Alert(
                        title: Text("Start Over"),
                        message: Text("Are you sure?"),
                        dismissButton: .default(Text("Start Over")))
                }
                Text("Score:")
                Text("999999")
                Text("Round:")
                Text("999")
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
            }
            
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414
            ))
    }
}
