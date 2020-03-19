//
//  MainViewController.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 12/03/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var beginButton: UIButton!
    @IBOutlet var aboutButton: UIButton!
    var image: UIImage!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func addBeginButton() {
        let beginButton = UIButton(type: .system)
        self.view.addSubview(beginButton)
        beginButton.translatesAutoresizingMaskIntoConstraints = false
        beginButton.setTitle("Create new photo", for: .normal)
        beginButton.backgroundColor = .blue
        beginButton.layer.cornerRadius = 12.0
        beginButton.tintColor = .white
        beginButton.addTarget(self, action: #selector(beginButtonClicked(_:)), for: .touchDragInside)
        
        NSLayoutConstraint.activate([
            (beginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)),
            (beginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
            (beginButton.heightAnchor.constraint(equalToConstant: 50)),
            (beginButton.widthAnchor.constraint(equalToConstant: 200)),
        ])
        self.beginButton = beginButton
    }
    
    func addFaceButton() {
        let faceButton = UIButton(type: .system)
        self.view.addSubview(faceButton)
        faceButton.translatesAutoresizingMaskIntoConstraints = false
        faceButton.setTitle("Save your face", for: .normal)
        faceButton.backgroundColor = UIColor.clear
        faceButton.layer.borderWidth = 1.0
        faceButton.layer.borderColor = UIColor.blue.cgColor
        faceButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        faceButton.layer.cornerRadius = 12.0
        faceButton.tintColor = .white
        faceButton.addTarget(self, action: #selector(aboutButtonClicked(_:)),
                                for: .touchDragInside)
        
        NSLayoutConstraint.activate([
            (faceButton.topAnchor.constraint(equalTo: beginButton.bottomAnchor, constant: 80)),
            (faceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
            (faceButton.heightAnchor.constraint(equalToConstant: 50)),
            (faceButton.widthAnchor.constraint(equalToConstant: 200)),
        ])
        self.aboutButton = faceButton
    }
    
    @IBAction func beginButtonClicked (_ sender: UIButton) {
        let mainViewContoller = PhotoViewController()
        navigationController?.pushViewController(mainViewContoller, animated: true)
    }
    
    @IBAction func aboutButtonClicked (_ sender: UIButton) {
        let mainViewContoller = FaceViewController()
        navigationController?.pushViewController(mainViewContoller, animated: true)
    }
    
    func addLogo() {
        let logoName = "LogoDummy.png"
        let image = UIImage(named: logoName)
        let imageView = UIImageView(image: image!)
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            (imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -380)),
            (imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
            (imageView.heightAnchor.constraint(equalToConstant: 360)),
            (imageView.widthAnchor.constraint(equalToConstant: 360)),
        ])
        self.imageView = imageView
    }
}

extension MainViewController {
    private func commonInit() {
        view.backgroundColor = .white
        addBeginButton()
        addFaceButton()
        addLogo()
    }
}
