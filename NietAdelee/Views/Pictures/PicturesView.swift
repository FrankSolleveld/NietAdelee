//
//  PicturesView.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

struct PicturesView: View {

    @State var activeView: currentView
    @State var pictures = Pictures.exampleData

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            NavigationView {
                List(pictures) { picture in
                    NavigationLink(destination: DetailView(picture: picture)) {
                        PictureListView(picture: picture)
                    }
                }
                .navigationTitle(Text("Pictures"))
            }
        }
    }
}

