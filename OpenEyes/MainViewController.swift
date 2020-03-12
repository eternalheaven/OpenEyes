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
            (beginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)),
            (beginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)),
            (beginButton.heightAnchor.constraint(equalToConstant: 50)),
            (beginButton.widthAnchor.constraint(equalToConstant: 100)),
        ])
        self.beginButton = beginButton
    }
    
    @IBAction func beginButtonClicked (_ sender: UIButton) {
        let mainViewContoller = ViewController()
        navigationController?.pushViewController(mainViewContoller, animated: true)
    }
}

extension MainViewController {
    private func commonInit() {
        view.backgroundColor = .red
        addBeginButton()
    }
}
