//
//  Home.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

enum currentView {
    case center
    case right
}

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

struct Home: View {

    @State var activeView = currentView.center
    @State var viewState = CGSize.zero

    var body: some View {
        ZStack {
            MainCameraScreen(activeView: self.activeView)
                .animation(.easeInOut)
            PicturesView(activeView: self.activeView)
                .offset(x: self.activeView == currentView.right ? 0 : screenWidth)
                .offset(x: activeView != .center ? viewState.width : 0)
                .animation(.easeInOut)

        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
