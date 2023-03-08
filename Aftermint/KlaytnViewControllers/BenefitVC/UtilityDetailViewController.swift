//
//  UtilityDetailViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/06.
//

import UIKit

class UtilityDetailViewController: UIViewController {
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let wholeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "utility_detail")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(false, animated: false)
        navigationBarSetup()
        
    }
    
    
    
    // MARK: - Set UI & Layout
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(wholeImageView)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            wholeImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30.0),
            wholeImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wholeImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wholeImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            wholeImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
    }
    
    private func navigationBarSetup() {

        /* Left bar item */
        let backButtonImage: UIImage? = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        let backButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backToPreviousVC))
        self.pulleyViewController?.navigationItem.leftBarButtonItem = backButtonItem

        /* Right bar item */
        let shareButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "share_default")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        self.pulleyViewController?.navigationItem.rightBarButtonItem = shareButton

    }
    
    @objc private func backToPreviousVC() {
      
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}


    
    
    

