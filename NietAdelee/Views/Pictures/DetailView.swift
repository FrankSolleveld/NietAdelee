//
//  DetailView.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

struct DetailView: View {

    @State var picture: Picture

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image(picture.name)
                        .resizable()
                    // TODO: Size is not right when picture was taken in landscpae orientation.
                        .frame(width: geometry.size.width)
                    Spacer()
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(picture: Picture(name: "erasmusbrug"))
    }
}
