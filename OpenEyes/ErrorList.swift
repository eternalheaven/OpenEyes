//
//  Errors.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 29/05/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.
//

import Foundation

public enum ErrorList: Error {
    case unknown
    case assetPathError
    case modelError
    case resizeError
    case pixelBufferError
    case predictionError
}

extension ErrorList: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .assetPathError:
            return "Model not found"
        case .modelError:
            return "Model error"
        case .resizeError:
            return "Failure of resize"
        case .pixelBufferError:
            return "Pixel Buffer conversion failed"
        case .predictionError:
            return "CoreML failed to predict"
        }
    }
}
