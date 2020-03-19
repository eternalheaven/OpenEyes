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
    var chosenImageView : UIImageView!
    var chooseButton : UIButton!
    var forwardButton : UIButton!
    var label : UILabel!
    
    
    func pickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing =  true
        self.present(imagePicker, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    
    @objc func buttonClicked(_ sender: UIButton) {
        pickerController()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImageView.contentMode = .scaleAspectFit
            chosenImageView.image = selectedImage
            enableForwardButton()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func addButton() {
        let chooseButton = UIButton(type: .system)
        self.view.addSubview(chooseButton)
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        chooseButton.setTitle("Pick image", for: .normal)
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
        self.chooseButton = chooseButton
    }
    
    private func addForwardButton() {
        let forwardButton = UIButton(type: .system)
        self.view.addSubview(forwardButton)
        forwardButton.isEnabled = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.setTitle("Confirm", for: .normal)
        forwardButton.backgroundColor = .blue
        
        NSLayoutConstraint.activate([
            (forwardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)),
            (forwardButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)),
            (forwardButton.heightAnchor.constraint(equalToConstant: 50)),
            (forwardButton.widthAnchor.constraint(equalToConstant: 150)),
        ])
        forwardButton.layer.cornerRadius = 12.0
        forwardButton.tintColor = .white
        //        forwardButton.addTarget(self, action: #selector(buttonClicked(_:)),
        //                                for: .touchDragInside)
        self.forwardButton = forwardButton
        
    }
    
    private func enableForwardButton() {
        forwardButton.isEnabled = true
    }
    
    func addLabel() {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 401))
        self.view.addSubview(label)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = label.font.withSize(30)
        label.textAlignment = .center;
        label.text = "Choose a photo where your eyes are closed "
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            (label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50)),
            (label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)),
            (label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor))
        ])
        
    }
    
    func addView() {
        chosenImageView = UIImageView(frame: CGRect(x: 100, y: 200, width: 200, height: 150))
        self.view.addSubview(chosenImageView)
        chosenImageView.layer.cornerRadius = 10
        chosenImageView.clipsToBounds = true
        chosenImageView.layer.borderWidth = 2.0
        chosenImageView.layer.borderColor = UIColor.red.cgColor
        chosenImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   (chosenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)),
                   (chosenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
                   (chosenImageView.heightAnchor.constraint(equalToConstant: 150)),
                   (chosenImageView.widthAnchor.constraint(equalToConstant: 200)),
               ])

    }
   
}
extension PhotoViewController {
    private func commonInit() {
        view.backgroundColor = .white
        addButton()
        addLabel()
        addView()
        addForwardButton()
    }
}


