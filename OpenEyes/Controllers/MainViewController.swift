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
    @IBOutlet var libraryButton: UIButton!
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
    
    func addLibraryButton() {
        let libraryButton = UIButton(type: .system)
        self.view.addSubview(libraryButton)
        libraryButton.translatesAutoresizingMaskIntoConstraints = false
        libraryButton.setTitle("Your Library", for: .normal)
        libraryButton.backgroundColor = .blue
        libraryButton.layer.cornerRadius = 12.0
        libraryButton.tintColor = .white
        libraryButton.addTarget(self, action: #selector(libraryButtonClicked(_:)),
                                for: .touchDragInside)
        
        NSLayoutConstraint.activate([
            (libraryButton.topAnchor.constraint(equalTo: beginButton.bottomAnchor, constant: 30)),
            (libraryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
            (libraryButton.heightAnchor.constraint(equalToConstant: 50)),
            (libraryButton.widthAnchor.constraint(equalToConstant: 200)),
        ])
        self.libraryButton = libraryButton
    }
    
    @IBAction func beginButtonClicked (_ sender: UIButton) {
        let mainViewContoller = PhotoViewController()
        navigationController?.pushViewController(mainViewContoller, animated: true)
    }
    
    @IBAction func libraryButtonClicked (_ sender: UIButton) {
        let mainViewContoller = LibViewController()
        navigationController?.pushViewController(mainViewContoller, animated: true)
    }
    
    func addLogo() {
        let logoName = "FakeLogo.png"
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
        addLibraryButton()
        addLogo()
    }
}
