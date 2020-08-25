//
//  AboutView.swift
//  Bullseye
//
//  Created by Michael Street on 8/25/20.
//  Copyright © 2020 Michael Street. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack{
            Text("Bullseye")
            Text("This is a bogus tutorial game.")
        }
    .navigationBarTitle(Text("About"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414
            ))
    }
}
