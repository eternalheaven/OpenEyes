
//  ViewController.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 11/03/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.


import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate,
                          UIImagePickerControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var chooseButton : UIButton!
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        commonInit()
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print ("Button capture")
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing =  false

            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!,
                               editingInfo: NSDictionary!) {
        self.dismiss(animated: true, completion: { () -> Void in

        })
        imageView.image = image
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

extension ViewController {
    private func commonInit() {
        view.backgroundColor = .lightGray
        addButton()
    }
}


