//
//  TemplateCell.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/28.
//

import UIKit

import ReactorKit

final class LottieTemplateCell: UICollectionViewCell, View {

    var isOff: Bool = true
    
    private let templateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "fyi_off")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(templateImageView)
        templateImageView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage?) {
        templateImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.templateImageView.image = nil
    }
    
    var disposeBag: DisposeBag = .init()
    
    func bind(reactor: TemplateCellReactor) {
        bindState(reactor)
        bindAction(reactor)
    }
    
    private func bindState(_ reactor: TemplateCellReactor) {

    }
    
    private func bindAction(_ reactor: TemplateCellReactor) {
        
    }
}
