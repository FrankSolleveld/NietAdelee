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
    case left
}

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

struct Home: View {

    @State var activeView = currentView.center
    @State var viewState = CGSize.zero

    var body: some View {
        ZStack {
            MainScreen(activeView: self.activeView)
                .cornerRadius(3)
                .animation(.easeInOut)
            PicturesView(activeView: self.activeView)
                .offset(x: self.activeView == currentView.right ? 0 : screenWidth)
                .offset(x: activeView != .center ? viewState.width : 0)
                .animation(.easeInOut)

        }
        .gesture(
            (self.activeView == currentView.center) ?
            DragGesture().onChanged { value in
                self.viewState = value.translation
            }
                .onEnded { value in
                    if value.predictedEndTranslation.width > screenWidth / 2 {
                        self.activeView = currentView.left
                        self.viewState = .zero
                    }
                    else if value.predictedEndTranslation.width < -screenWidth / 2 {
                        self.activeView = currentView.right
                        self.viewState = .zero
                    }
                    else {
                        self.viewState = .zero
                    }
                }
            :
                DragGesture()
                .onChanged { value in
                    switch self.activeView {
                    case .left:
                        guard value.translation.width < 1 else { return }
                        self.viewState = value.translation
                    case .right:
                        guard value.translation.width > 1 else { return }
                        self.viewState = value.translation
                    case .center:
                        self.viewState = value.translation
                    }
                }
                .onEnded { value in
                    switch self.activeView {
                    case .left:
                        if value.predictedEndTranslation.width < -screenWidth / 2 {
                            self.activeView = .center
                            self.viewState = .zero
                        }
                        else {
                            self.viewState = .zero
                        }
                    case .right:
                        if value.predictedEndTranslation.width > screenWidth / 2 {
                            self.activeView = .center
                            self.viewState = .zero
                        }
                        else {
                            self.viewState = .zero
                        }
                    case .center:
                        self.viewState = .zero
                    }
                }

        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
