//
//  MainViewController.swift
//  OpenEyes
//
//  Created by Alexandr Khrutskiy on 12/03/2020.
//  Copyright © 2020 Alexandr Khrutskiy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    public var beginButton: UIButton!
    @IBOutlet var aboutButton: UIButton!
    var image: UIImage!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.layoutMarginsGuide.layoutFrame
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    public func addBeginButton() {
        let beginButton = UIButton(type: .system)
        self.view.addSubview(beginButton)
//        beginButton.isEnabled = false
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

    
    @objc func beginButtonClicked (_ sender: UIButton) {
        let mainViewContoller = PhotoViewController()
        navigationController?.pushViewController(mainViewContoller, animated: true)
    }
    
    func addLogo() {
        let logoName = "LogoDummy.png"
        let image = UIImage(named: logoName)
        let imageView = UIImageView(image: image!)
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            (imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: -100)),
            (imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
//            (imageView.heightAnchor.constraint(equalToConstant: 360)),
//            (imageView.widthAnchor.constraint(equalToConstant: 360)),
        ])
        self.imageView = imageView
    }
}

extension MainViewController {
    private func commonInit() {
        view.backgroundColor = .white
        addBeginButton()
        addLogo()
    }
}
