//
//  PictureListView.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

struct PictureListView: View {

    @State var picture: Picture

    var body: some View {
        HStack {
            Image(picture.name)
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .frame(width: 50, height: 50)

            Text("A Picture")
        }
    }
}

struct PictureListView_Previews: PreviewProvider {
    static var previews: some View {
        PictureListView(picture: Pictures.exampleData.first!)
    }
}
