//
//  LoginViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/25.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, View, Coordinating {
    
    var coordinator: Coordinator?
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Init
    init(reactor: LoginViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Elements
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            AftermintColor.backgroundBlue.cgColor,
            AftermintColor.backgroundPink.cgColor,
        ]
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.45)
        return layer
    }()
    
    private let bellygomImageLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bellygom_image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bellygomTextLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bellygom_title")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginDescription: UILabel = {
        let label = UILabel()
        label.text = "멤버십 서비스 이용을 위해 NFT 지갑을 연결해주세요."
        label.sizeToFit()
        label.font = BellyGomFont.header06
        label.textColor = AftermintColor.lightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let walletStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let favorletButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorletbutton"), for: .normal)
        return button
    }()
    
    private lazy var kaikasButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kaikasbutton"), for: .normal)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundGradient()
        
        setUI()
        setLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    // MARK: - Set UI & Layout
    private func setUI() {
        
        view.addSubview(bellygomImageLogo)
        view.addSubview(bellygomTextLogo)
        view.addSubview(loginDescription)
        view.addSubview(walletStackView)
        
        walletStackView.addArrangedSubview(favorletButton)
        walletStackView.addArrangedSubview(kaikasButton)
        
    }
    
    private func setLayout() {
        let viewHeight = UIScreen.main.bounds.size.height
        
        NSLayoutConstraint.activate([
            
            bellygomImageLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: viewHeight / 8.28),
            bellygomImageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            bellygomTextLogo.topAnchor.constraint(equalTo: bellygomImageLogo.bottomAnchor, constant: viewHeight / 25.37),
            bellygomTextLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginDescription.topAnchor.constraint(equalTo: bellygomTextLogo.bottomAnchor, constant: viewHeight / 5.1),
            loginDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            walletStackView.topAnchor.constraint(equalTo: loginDescription.bottomAnchor, constant: viewHeight / 67.66),
            walletStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            walletStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(viewHeight / 8.28))
            
        ])
    }
    
    private func connectKaikasWallet() {
        let reactor: StartViewReactor = StartViewReactor()
        let startVC = StartViewController(reactor: reactor)
        navigationController?.pushViewController(startVC, animated: true)
        
    }
    
    // MARK: - Gradient
    private func setBackgroundGradient() {
        self.gradientLayer.frame = view.bounds
        self.view.layer.addSublayer(gradientLayer)
    }
    
}

//MARK: - Bind Action and State

extension LoginViewController {
    
    func bind(reactor: LoginViewReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    private func bindState(with reactor: LoginViewReactor) {
        reactor.state.map { $0.connect }
            .bind{ [weak self] _ in self?.connectKaikasWallet()  }
            .disposed(by: disposeBag)
    }
    
    private func bindAction(with reactor: LoginViewReactor) {
        kaikasButton.rx.tap
            .map { Reactor.Action.connectWithKaikas }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
