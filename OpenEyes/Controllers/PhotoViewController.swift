
//  ViewController.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 11/03/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.


import UIKit

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var chosenImageView = UIImageView(image: UIImage(named: "ClearImage"))
    var chooseButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    
    @objc func buttonClicked(_ sender: UIButton) {
        pickerController()
    }

    func pickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing =  true
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            chosenImageView.image = selectedImage
        } else if let selectedImage = info[.originalImage] as? UIImage {
            chosenImageView.image = selectedImage
        }
//        chosenImageView.contentMode = .scaleAspectFit //3
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    private func addButton() {
        let chooseButton = UIButton(type: .system)
        self.view.addSubview(chooseButton)
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        chooseButton.setTitle("Pick image", for: .normal)
        chooseButton.backgroundColor = .blue

        NSLayoutConstraint.activate([
            (chooseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)),
            (chooseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
            (chooseButton.heightAnchor.constraint(equalToConstant: 50)),
            (chooseButton.widthAnchor.constraint(equalToConstant: 100)),
        ])
        chooseButton.layer.cornerRadius = 12.0
        chooseButton.tintColor = .white
        chooseButton.addTarget(self, action: #selector(buttonClicked(_:)),
                                for: .touchDragInside)
        self.chooseButton = chooseButton
    }

}

extension PhotoViewController {
    private func commonInit() {
        view.backgroundColor = .white
        addButton()
    }
}


