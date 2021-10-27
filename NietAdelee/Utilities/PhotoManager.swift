//
//  FileManager.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

class PhotoManager {

    func store(image: UIImage, forKey key: String) {
        if let imageData = image.pngData() {
            if let filePath = filePath(forKey: key) {
                do {
                    try imageData.write(to: filePath, options: .atomic)
                }
                catch let error {
                    // TODO: Refactor this to be an Alert used before.
                    print("Saving file resulted in error: \(error).")
                }
            }
        }
    }

    func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL.appendingPathComponent(key + ".png")
    }

    func retrieveImage(forKey key: String) -> UIImage? {
        if let filePath = self.filePath(forKey: key),
           let fileData = FileManager.default.contents(atPath: filePath.path),
           let image = UIImage(data: fileData) {
            return image
        }
        return nil
    }
}
