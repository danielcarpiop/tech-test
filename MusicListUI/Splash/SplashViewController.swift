//
//  SplashViewController.swift
//  MusicListUI
//
//  Created by Daniel Carpio on 23-06-24.
//

import UIKit

final class SplashViewController: UIViewController {
    private lazy var viewContainer: UIImageView = {
        let image = UIImageView()
        image.image = .itunesLogo
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(viewContainer)
        NSLayoutConstraint.activate([
            viewContainer.widthAnchor.constraint(equalToConstant: 150),
            viewContainer.heightAnchor.constraint(equalToConstant: 150),
            viewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}