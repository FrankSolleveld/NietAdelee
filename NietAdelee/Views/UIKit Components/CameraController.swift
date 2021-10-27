//
//  CameraController.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import UIKit
import AVFoundation

enum CameraError {
    case invalidDeviceInput
}

protocol CameraControllerDelegate: AnyObject {
    func didSurface(error: CameraError)
}

final class CameraController: UIViewController {
    let captureSession = AVCaptureSession()
    var preview: AVCaptureVideoPreviewLayer?
    weak var cameraDelegate: CameraControllerDelegate?

    init(cameraDelegate: CameraControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.cameraDelegate = cameraDelegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = preview else {
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }

    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }

        let videoInput: AVCaptureDeviceInput
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }

        preview = AVCaptureVideoPreviewLayer(session: captureSession)
        guard let previewLayer = preview else { return }
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

}
