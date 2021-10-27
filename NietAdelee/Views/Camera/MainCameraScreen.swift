//
//  ContentView.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

struct MainCameraScreen: View {

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
                    .edgesIgnoringSafeArea(.vertical)
                Spacer()
                CameraControls()
            }
        }
        .preferredColorScheme(.dark)
    }
}
