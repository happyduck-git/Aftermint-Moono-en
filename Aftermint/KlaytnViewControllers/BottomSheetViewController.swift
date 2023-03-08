//
//  BottomSheetViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/06.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    let defaultHeight: CGFloat = 300
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(gesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "claim_nft_select")
        imageView.contentMode = .scaleAspectFit
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showNextView))
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var popUpImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "popup")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    func setUI() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(contentImage)
        
        view.addSubview(popUpImage)
    }
    
    func setLayout() {
        
        NSLayoutConstraint.activate([
        
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            contentImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            contentImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            contentImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
        // Set container to default height
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    @objc private func dismissView() {

        self.dismiss(animated: true)

    }
    
    var numberOfTouches: Int = 0
    
    @objc private func showNextView() {
    
        switch numberOfTouches {
        case 0:
            contentImage.image = UIImage(named: "utility_select")
        case 1:
            contentImage.image = UIImage(named: "agreement")
        case 2:
            changeModalView()
        default:
            contentImage.image = UIImage(named: "agreement")
            
        }
        numberOfTouches += 1
    }
    
    private func changeModalView() {
        containerView.isHidden = true
        popUpImage.isHidden = false
        NSLayoutConstraint.activate([

            popUpImage.topAnchor.constraint(equalTo: dimmedView.topAnchor, constant: 150.0),
            popUpImage.centerXAnchor.constraint(equalTo: dimmedView.centerXAnchor),
            popUpImage.leadingAnchor.constraint(equalTo: dimmedView.leadingAnchor, constant: 30.0),
            popUpImage.trailingAnchor.constraint(equalTo: dimmedView.trailingAnchor, constant: -30.0),
            popUpImage.bottomAnchor.constraint(equalTo: dimmedView.bottomAnchor, constant: -150.0)
        ])
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
