//
//  FileManager.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

class PhotoManager {

    let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

    func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL.appendingPathComponent(key + ".png")
    }

    func store(image: UIImage, forKey key: String) {
        if let imageData = image.pngData() {
            if let filePath = filePath(forKey: key) {
                do {
                    try imageData.write(to: filePath, options: .atomic)
                    // This is just here for you devs to see that it indeed saves. Normally this won't be here.
                    print("Save succes.")
                    getDocumentContents()
                }
                catch let error {
                    // TODO: Refactor this to be an Alert used before.
                    print("Saving file resulted in error: \(error).")
                }
            }
        }
    }

    func getDocumentContents() {
        // TODO: Alert the user when this fails because if there is nothing to read from there are bigger issues going on
        guard let url = documentsUrl else { return }
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            print(directoryContents)
        }
        catch {
            print(error)
        }
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
