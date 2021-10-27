//
//  CameraControls.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

struct CameraControls: View {
    var body: some View {
        VStack {
            Spacer()
            Button(
                action: {
                    print("picture taken")
                }, label: {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .overlay(
                            Circle()
                                .stroke(Color.black.opacity(0.8), lineWidth: 2)
                                .frame(width: 65, height: 65, alignment: .center)
                        )
                })
            Spacer()
        }
        .frame(height: 100)
    }
}

struct CameraControls_Previews: PreviewProvider {
    static var previews: some View {
        CameraControls()
    }
}
