//
//  PhotosViewController.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 18/03/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    typealias FilteringCompletion = ((UIImage?, Error?) -> ())
    private var selectedImage = UIImage(named: "firewatch.jpg")
    
    var selectedModel: Model = .pointillism
    
    
    func pickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing =  true
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    var processing: Bool = false {
        didSet {
            self.beginButton.isEnabled = !processing
            self.processing ? self.loader.startAnimating() : self.loader.stopAnimating()
            UIView.animate(withDuration: 0.3) {
                self.processing ? self.beginButton.setTitle("Выполняем...", for: .normal) : self.beginButton.setTitle("Начнем", for: .normal)
                self.view.layoutIfNeeded()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        self.segmentedControl.removeAllSegments()
        for (index, model) in Model.allCases.enumerated() {
            self.segmentedControl.insertSegment(withTitle: model.rawValue, at: index, animated: false)
        }
        self.segmentedControl.selectedSegmentIndex = 0
        self.processing = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
//MARK: - Запускаем процесс CoreML
    func process(input: UIImage, completion: @escaping FilteringCompletion) {
        
        let startTime = CFAbsoluteTimeGetCurrent()
        var outputImage: UIImage?
        var nstError: Error?
        
        DispatchQueue.global().async {
            do {
                let modelProvider = try self.selectedModel.modelProvider()
                outputImage = try modelProvider.prediction(inputImage: input)
            } catch let error {
                nstError = error
            }
            
            // Hand result to main thread
            DispatchQueue.main.async {
                if let outputImage = outputImage {
                    completion(outputImage, nil)
                } else if let nstError = nstError{
                    completion(nil, nstError)
                } else {
                    completion(nil, ErrorList.unknown)
                }
                
                let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                print("Time elapsed for NST process: \(timeElapsed) s.")
            }
        }
    }
    
//MARK: - Действия
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.selectedModel = Model.allCases[self.segmentedControl.selectedSegmentIndex]
        self.chosenImageView.image = self.selectedImage
    }
    
    func applyModel() {
        guard let image = chosenImageView.image else {
            let alert = UIAlertController(title: "Сначала выберите изображение", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.processing = true
        self.process(input: image) { filteredImage, error in
            self.processing = false
            if let filteredImage = filteredImage {
                self.chosenImageView.image = filteredImage
            }
        }
    }

    
    @objc func buttonClicked(_ sender: UIButton) {
        pickerController()
    }
    
    @objc func forwardButtonClicked(_ sender: UIButton) {
        applyModel()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImageView.contentMode = .scaleAspectFit
            chosenImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveImage() {
        if let pickedImage = chosenImageView.image {
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
//MARK: - UI
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        self.view.addSubview(control)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        NSLayoutConstraint.activate([
            (control.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150)),
            (control.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)),
        ])
        return control
    }()
        
    lazy var chosenImageView: UIImageView = {
        let chosenImageView = UIImageView(frame: CGRect(x: 20, y: 135 , width: 335, height: 334))
        view.addSubview(chosenImageView)
        chosenImageView.image = selectedImage
        chosenImageView.isOpaque = true
        chosenImageView.clearsContextBeforeDrawing = true
        chosenImageView.clipsToBounds = true
        chosenImageView.autoresizesSubviews = true
        chosenImageView.alpha = 1
        chosenImageView.contentMode = .scaleAspectFit
        chosenImageView.isUserInteractionEnabled = true
        chosenImageView.layer.cornerRadius = 4
        chosenImageView.clipsToBounds = true
        chosenImageView.layer.borderWidth = 2.0
        chosenImageView.layer.borderColor = UIColor.red.cgColor
        chosenImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            (chosenImageView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 15)),
            (chosenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
            (chosenImageView.heightAnchor.constraint(equalToConstant: 335)),
            (chosenImageView.widthAnchor.constraint(equalToConstant: 334)),
        ])
        return chosenImageView
    }()
    
    lazy var chooseButton: UIButton = {
        let chooseButton = UIButton(type: .system)
        self.view.addSubview(chooseButton)
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        chooseButton.setTitle("Выбрать", for: .normal)
        chooseButton.backgroundColor = .blue
        NSLayoutConstraint.activate([
            (chooseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)),
            (chooseButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)),
            (chooseButton.heightAnchor.constraint(equalToConstant: 50)),
            (chooseButton.widthAnchor.constraint(equalToConstant: 150)),
        ])
        chooseButton.layer.cornerRadius = 12.0
        chooseButton.tintColor = .white
        chooseButton.addTarget(self, action: #selector(buttonClicked(_:)),
                                for: .touchDragInside)
        return chooseButton
    }()
    
    lazy var beginButton: UIButton = {
        let forwardButton = UIButton(type: .system)
        view.addSubview(forwardButton)
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.backgroundColor = .blue
        forwardButton.isEnabled = true
        
        NSLayoutConstraint.activate([
            (forwardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)),
            (forwardButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)),
            (forwardButton.heightAnchor.constraint(equalToConstant: 50)),
            (forwardButton.widthAnchor.constraint(equalToConstant: 150)),
        ])
        forwardButton.layer.cornerRadius = 12.0
        forwardButton.tintColor = .white
        forwardButton.addTarget(self, action: #selector(forwardButtonClicked(_:)),
                                        for: .touchDragInside)
        return forwardButton
        
        
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        view.addSubview(label)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = label.font.withSize(20)
        label.textAlignment = .center;
        label.text = "Выберите картинку, которую хотите обработать"
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            (label.topAnchor.constraint(equalTo: chosenImageView.bottomAnchor, constant: 5)),
            (label.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
            (label.widthAnchor.constraint(equalToConstant: 350)),
            (label.heightAnchor.constraint(equalToConstant: 401))
        ])
        return label
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        NSLayoutConstraint.activate([
            (loader.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)),
            (loader.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
        ])
        return loader
    }()
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.layoutMarginsGuide.layoutFrame
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension PhotoViewController {
    private func commonInit() {
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        view.addSubview(chosenImageView)
        view.addSubview(label)
        view.addSubview(beginButton)
        view.addSubview(chooseButton)
        view.addSubview(loader)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveImage))
    }
}


