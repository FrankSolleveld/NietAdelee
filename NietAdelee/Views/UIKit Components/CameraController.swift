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
    case badAccess
}

protocol CameraControllerDelegate: AnyObject {
    func didSurface(error: CameraError)
}

final class CameraController: UIViewController {
    let captureSession = AVCaptureSession()
    var preview: AVCaptureVideoPreviewLayer?
    weak var cameraDelegate: CameraControllerDelegate?
    var output = AVCapturePhotoOutput()

    init(cameraDelegate: CameraControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.cameraDelegate = cameraDelegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForPermissions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = preview else {
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }

    func checkForPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status {
                    self.setupCaptureSession()
                }
            }
        case .restricted:
            cameraDelegate?.didSurface(error: .badAccess)
        case .denied:
            cameraDelegate?.didSurface(error: .badAccess)
        case .authorized:
            setupCaptureSession()
            return
        @unknown default:
            cameraDelegate?.didSurface(error: .badAccess)
        }
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

        if self.captureSession.canAddOutput(self.output) {
            self.captureSession.addOutput(self.output)
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
