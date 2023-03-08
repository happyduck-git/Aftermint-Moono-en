//
//  EventViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/01/20.
//

import UIKit

class BenefitViewController: UIViewController {
    
    
    //MARK: - UI Elements
    private let menuBar: BenefitMenuBar = {
        let menuBar = BenefitMenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        collection.register(UtilityCell.self, forCellWithReuseIdentifier: UtilityCell.identifier)
        collection.register(VoteCell.self, forCellWithReuseIdentifier: VoteCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.dataSource = self
        collection.delegate = self
        
        return collection
        
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationBarSetup()
        setUI()
        setLayout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("BenefitVC viewWillDisappear")
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: - Set UI & Layout
    private func setUI() {
        view.addSubview(menuBar)
        view.addSubview(collectionView)
        
        menuBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func setLayout() {
        let tabBarHeight = view.frame.size.height / 8.2
        
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 48.0),
            
            collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBarHeight))
            
        ])
    }
    
    private func navigationBarSetup() {
        
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        
        /* Left bar item */
        let logo = UIImage(named: "benefit_logo")
        let myImageView = UIImageView(image: logo)
        let leftBar: UIBarButtonItem = UIBarButtonItem(customView: myImageView)
        self.tabBarController?.navigationItem.leftBarButtonItem = leftBar
        
        /* Right bar item */
        let rightBarBookmark: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "bookmark_black_empty_24")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        
        let rightBarCalendar: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "calendar_badgeon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        
        self.tabBarController?.navigationItem.rightBarButtonItems = [rightBarCalendar, rightBarBookmark]
        
    }
}

extension BenefitViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath {
        case IndexPath(item: 0, section: 0):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }
            cell.backgroundColor = AftermintColor.backgroundGrey
            return cell
            
        case IndexPath(item: 1, section: 0):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UtilityCell.identifier, for: indexPath) as? UtilityCell else { return UICollectionViewCell() }
            cell.backgroundColor = AftermintColor.backgroundGrey
            return cell
            
        case IndexPath(item: 2, section: 0):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCell.identifier, for: indexPath) as? VoteCell else { return UICollectionViewCell() }
            cell.backgroundColor = AftermintColor.backgroundGrey
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }
            cell.backgroundColor = AftermintColor.backgroundGrey
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch indexPath {
        case IndexPath(item: 0, section: 0):
            let eventDetailVC: EventDetailViewController = EventDetailViewController()
            self.tabBarController?.navigationController?.pushViewController(eventDetailVC, animated: true)

        case IndexPath(item: 1, section: 0):
            let utilityDetailVC: UtilityDetailViewController = UtilityDetailViewController()
            self.tabBarController?.navigationController?.pushViewController(utilityDetailVC, animated: true)
        default:
            print("2nd cell touched")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        menuBar.selectItem(at: Int(index))
    }
}


extension BenefitViewController: BenefitMenuBarDelegate {
    
    func didSelectItemAt(index: Int) {
        let indexPath: IndexPath = IndexPath(item: index, section: 0)
        menuBar.selectItem(at: index)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    
}
