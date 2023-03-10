//
//  BookmarkMenuBar.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/06.
//

import UIKit

protocol BookmarkMenuBarDelegate: AnyObject {
    func didSelectItemAt(index: Int)
}

class BookmarkMenuBar: UIView {
    
    weak var delegate: BookmarkMenuBarDelegate?
    var indicatorLeading: NSLayoutConstraint?
    var indicatorTrailing: NSLayoutConstraint?
    
    //MARK: - UI Elements
    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var eventButton: UIButton = {
        let button = UIButton()
        button.setTitle("이벤트", for: .normal)
        //font 설정하기
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(eventButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var utilityButton: UIButton = {
        let button = UIButton()
        button.setTitle("유틸리티", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(utilityButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let indicator: UILabel = {
        let label = UILabel()
        label.backgroundColor = AftermintColor.moonoYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAlpha(for: eventButton)
        
        setUI()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Setup UI & Layout
    private func setUI() {
        self.addSubview(buttonStack)
        buttonStack.addArrangedSubview(eventButton)
        buttonStack.addArrangedSubview(utilityButton)
        self.addSubview(indicator)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            indicator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        indicatorLeading = indicator.leadingAnchor.constraint(equalTo: buttonStack.leadingAnchor)
        indicatorTrailing = indicator.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor)
        
        indicatorLeading?.isActive = true
        indicatorTrailing?.isActive = true
    }
    
    //MARK: - Button functions
    @objc private func eventButtonTapped() {
        delegate?.didSelectItemAt(index: 0)
    }
    
    @objc private func utilityButtonTapped() {
        delegate?.didSelectItemAt(index: 1)
    }

    
}

extension BookmarkMenuBar {
    
    func selectItem(at index: Int) {
        animateIndicator(to: index)
    }
    
    private func animateIndicator(to index: Int) {
        var button: UIButton
        switch index {
        case 0:
            button = eventButton
        case 1:
            button = utilityButton
        default:
            button = eventButton
        }
        
        setAlpha(for: button)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func setAlpha(for button: UIButton) {
        eventButton.alpha = 0.5
        utilityButton.alpha = 0.5
        button.alpha = 1.0
    }
}
