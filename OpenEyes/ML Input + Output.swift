//
//  ML Input + Output.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 30/05/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.
//

import UIKit
import CoreML

@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class MLModelProviderInput : MLFeatureProvider {
    
    var inputImage: CVPixelBuffer
    var inputName: String
    var featureNames: Set<String> {
        get { return [inputName] }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == inputName) {
            return MLFeatureValue(pixelBuffer: inputImage)
        }
        return nil
    }
    
    init(inputImage: CVPixelBuffer, inputName: String) {
        self.inputName = inputName
        self.inputImage = inputImage
    }
}

@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class MLModelProviderOutput : MLFeatureProvider {
    
    let outputImage: CVPixelBuffer
    var outputName: String
    var featureNames: Set<String> {
        get { return [outputName] }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == outputName) {
            return MLFeatureValue(pixelBuffer: outputImage)
        }
        return nil
    }
    
    init(outputImage: CVPixelBuffer, outputName: String) {
        self.outputName = outputName
        self.outputImage = outputImage
    }
}
