//
//  MLProvider.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 29/05/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.
//

import UIKit
import CoreML

@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class MLModelConnector {
    var model: MLModel
    
    var inputName: String
    var outputName: String
    var pixelBufferSize: CGSize
    
    init(contentsOf url: URL,
         pixelBufferSize: CGSize,
         inputName: String,
         outputName: String) throws {
        self.model = try MLModel(contentsOf: url)
        self.pixelBufferSize = pixelBufferSize
        self.inputName = inputName
        self.outputName = outputName
    }
    
    func prediction(inputImage: UIImage) throws -> UIImage {
        
        // Изменяем размер изображения для нужного для модели
        guard let newImage = inputImage.resize(to: self.pixelBufferSize) else {
            throw ErrorList.resizeError
        }
        
        // Переводим UIImage в Pixelbuffer
        
        guard let buffer = newImage.pixelBuffer() else {
            throw ErrorList.pixelBufferError
        }
        
        // Передаем pixel buffer в модель
        
        let inputML = MLModelProviderInput(inputImage: buffer, inputName: inputName)
        let outputML = try self.prediction(input: inputML)
        
        // Переводим из PixelBuffer в UIImage
        guard let outputImg = UIImage(pixelBuffer: outputML.outputImage) else {
            throw ErrorList.pixelBufferError
        }
        
        //Переводим обратно в размер input
         
        guard let completeImage = outputImg.resize(to: inputImage.size) else {
            throw ErrorList.resizeError
        }
        
        return completeImage
    }
    
    func prediction(input: MLModelProviderInput) throws -> MLModelProviderOutput {
        let outFeatures = try model.prediction(from: input)
        let result = MLModelProviderOutput(outputImage: outFeatures.featureValue(for: outputName)!.imageBufferValue!, outputName: outputName)
        return result
    }
}
