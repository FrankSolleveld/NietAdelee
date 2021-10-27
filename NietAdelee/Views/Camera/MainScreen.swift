//
//  ContentView.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

struct MainScreen: View {

    @StateObject var viewModel = CameraViewModel()
    @State var activeView: currentView

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                    .frame(height: 1)
                CameraView(alertItem: $viewModel.alertItem)
                    .cornerRadius(10)
                    .edgesIgnoringSafeArea(.vertical)
                CameraControls()
            }
        }
        .preferredColorScheme(.dark)
    }
}
