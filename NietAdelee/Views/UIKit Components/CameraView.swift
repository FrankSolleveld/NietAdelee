//
//  CameraScreen.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {

    @Binding var alertItem: AlertItem?
    static let controller = CameraController()

    func makeUIViewController(context: Context) -> CameraController {
        CameraView.controller.cameraDelegate = context.coordinator
        return CameraView.controller
    }

    func updateUIViewController(_ uiViewController: CameraController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(cameraView: self)
    }

    final class Coordinator: NSObject, CameraControllerDelegate {
        private let cameraView: CameraView

        init(cameraView: CameraView) {
            self.cameraView = cameraView
        }

        func didSurface(error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                cameraView.alertItem = AlertContext.invalidDeviceInput
            case .badAccess:
                cameraView.alertItem = AlertContext.badAccess
            }
        }
    }

}
