//
//  Pictures.swift
//  NietAdelee
//
//  Created by Frank Solleveld on 27/10/2021.
//

import SwiftUI

struct Picture: Identifiable {
    let id = UUID()
    let name: String
}

struct Pictures {
    static let exampleData = [
        Picture(name: "haven"),
        Picture(name: "paella"),
        Picture(name: "erasmusbrug")
    ]
}
