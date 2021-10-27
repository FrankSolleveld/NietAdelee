//
//  PicturesView.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

struct PicturesView: View {

    @State var activeView: currentView

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            NavigationView {
                HStack {
                    Text("A list of pictures will be placed here.")
                }
                .navigationTitle(Text("Pictures"))
            }
        }
    }
}
