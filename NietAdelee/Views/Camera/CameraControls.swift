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
            HStack {
                Button(
                    action: {
                        CameraView.controller.rotateCamera()
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                    })
                Button(
                    action: {
                        CameraView.controller.takePicture()
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
                Button(
                    action: {
                        CameraView.controller.retakePicture()
                    }, label: {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                    })
            }
        }
        .frame(height: 100)
    }
}

struct CameraControls_Previews: PreviewProvider {
    static var previews: some View {
        CameraControls()
    }
}
