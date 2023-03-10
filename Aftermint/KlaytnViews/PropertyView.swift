//
//  PropertyView.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/25.
//

import UIKit

class PropertyView: UIView {
    
    //MARK: - UI Elements
    private let wholeViewStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let firstRowStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    private let accessories: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        return view
    }()
    
    private let background: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        return view
    }()
    
    private let secondRowStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    private let body: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        return view
    }()
    
    private let day: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        return view
    }()
    
    private let thirdRowStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    private let effect: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        return view
    }()
    
    private let expression: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        return view
    }()
    
    private let hair: TitleAndDescriptionView = {
        let view = TitleAndDescriptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
//        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set UI and Layout
    private func setUI() {
        self.addSubview(wholeViewStack)
        self.addSubview(hair)
        
        wholeViewStack.addArrangedSubview(firstRowStack)
        wholeViewStack.addArrangedSubview(secondRowStack)
        wholeViewStack.addArrangedSubview(thirdRowStack)
        
        firstRowStack.addArrangedSubview(accessories)
        firstRowStack.addArrangedSubview(background)
        secondRowStack.addArrangedSubview(body)
        secondRowStack.addArrangedSubview(day)
        thirdRowStack.addArrangedSubview(effect)
        thirdRowStack.addArrangedSubview(expression)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            wholeViewStack.topAnchor.constraint(equalTo: self.topAnchor),
            wholeViewStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            wholeViewStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            wholeViewStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            hair.topAnchor.constraint(equalTo: wholeViewStack.bottomAnchor),
            hair.leadingAnchor.constraint(equalTo: wholeViewStack.leadingAnchor),
            hair.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }
    
    //MARK: - Configure
    public func configure(
                          accDesc: String?,
                          backgroundDesc: String?,
                          bodyDesc: String?,
                          dayDesc: String?,
                          effectDesc: String?,
                          expressionDesc: String?,
                          hairDesc: String?
                          )
    {
        accessories.configure(title: "Accessories", desc: accDesc ?? "N/A")
        background.configure(title: "Background", desc: backgroundDesc ?? "N/A")
        body.configure(title: "Body", desc: bodyDesc ?? "N/A")
        day.configure(title: "Day", desc: dayDesc ?? "N/A")
        effect.configure(title: "Effect", desc: effectDesc ?? "N/A")
        expression.configure(title: "Expression", desc: expressionDesc ?? "N/A")
        hair.configure(title: "Hair", desc: hairDesc ?? "N/A")
    }
}


private class TitleAndDescriptionView: UIView {
    
    //MARK: - UI Elements
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AftermintColor.secondaryBackgroundNavy
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header06
        label.textColor = AftermintColor.lightGrey
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.font = BellyGomFont.header05
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set UI and Layout
    private func setUI() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(desc)
        
        cornerRadius()
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12),
            
        ])
        
        title.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func cornerRadius() {
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.cornerRadius = 8
    }
    
    //MARK: - Configure
    func configure(title: String, desc: String) {
        self.title.text = title
        self.desc.text = desc
    }
}
