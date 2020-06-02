//
//  Model.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 29/05/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.
//

import Foundation
import UIKit

public enum Model: String, CaseIterable {
    
    case pointillism = "Pointillism"
    case starryNight = "StarryNight"
    
    func modelProvider() throws -> MLModelConnector {
        guard let url = Bundle.main.url(forResource: self.rawValue, withExtension: "mlmodelc") else {
            throw ErrorList.assetPathError
        }
        
        switch self {
        case .starryNight:
            return try MLModelConnector(contentsOf: url,
                                        pixelBufferSize: CGSize(width: 720, height: 720),
                                        inputName: "inputImage",
                                        outputName: "outputImage")
        case .pointillism:
            return try MLModelConnector(contentsOf: url,
                                pixelBufferSize: CGSize(width: 720, height: 720),
                                inputName: "myInput",
                                outputName: "myOutput")
        }
    }
}
