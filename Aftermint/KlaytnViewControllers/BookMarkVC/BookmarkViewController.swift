//
//  BookmarkViewController.swift
//  Aftermint
//
//  Created by Platfarm on 2023/02/06.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Pulley

class BookmarkViewController: UIViewController {
    
    let bottomSheetVC: BenefitTabBottomViewController = BenefitTabBottomViewController()
    var disposeBag: DisposeBag = DisposeBag()
    
    //MARK: - UI Elements
    private let menuBar: BookmarkMenuBar = {
        let menuBar = BookmarkMenuBar()
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

        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true

        return collection

    }()
    
    //MARK: - Init
    init(reactor: BookmarkViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.navigationController?.setNavigationBarHidden(false, animated: false) //벨리곰 로고 나오는 bar
        self.navigationController?.setNavigationBarHidden(true, animated: false) //북마크 타이틀 & left button bar
        navigationBarSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.parent?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    //MARK: - Set UI & Layout
    private func setUI() {
        view.addSubview(menuBar)
        view.addSubview(collectionView)
        
        menuBar.delegate = self
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    private func setLayout() {
        
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 48.0),
            
            collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           
        ])
    }
    
    private func navigationBarSetup() {
        
        self.parent?.tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        
        /* Left bar item */
        let backButtonImage: UIImage? = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        let leftBar = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backToPreviousVC))
        self.parent?.tabBarController?.navigationItem.leftBarButtonItem = leftBar
        self.parent?.tabBarController?.navigationItem.title = "북마크"
        
        /* Right bar item */
        self.parent?.tabBarController?.navigationItem.rightBarButtonItems = nil
        
    }
    
    @objc private func backToPreviousVC() {
        self.navigationController?.popViewController(animated: true)
    }


}


extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        menuBar.selectItem(at: Int(index))
    }
    
    /* Erase didSelecteItemAt code if unnecessary */
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let bottomSheetVC: BenefitTabBottomViewController = BenefitTabBottomViewController()
//        var pulleyVC: PulleyViewController?
//        switch indexPath {
//        case IndexPath(item: 0, section: 0):
//            let eventDetailVC: EventDetailViewController = EventDetailViewController()
//            pulleyVC = PulleyViewController(contentViewController: eventDetailVC, drawerViewController: bottomSheetVC)
//            guard let pulleyVC = pulleyVC else { return }
//            self.tabBarController?.navigationController?.pushViewController(pulleyVC, animated: true)
//
//        case IndexPath(item: 1, section: 0):
//            let utilityDetailVC: UtilityDetailViewController = UtilityDetailViewController()
//            bottomSheetVC.configure(image: "claim")
//            pulleyVC = PulleyViewController(contentViewController: utilityDetailVC, drawerViewController: bottomSheetVC)
//            guard let pulleyVC = pulleyVC else { return }
//            self.tabBarController?.navigationController?.pushViewController(pulleyVC, animated: true)
//        default:
//            print("2nd cell touched")
//        }
//    }
    
    private func tapToBenefitVC() {
        
        let eventDetailVC: EventDetailViewController = EventDetailViewController()

        let pulleyVC = PulleyViewController(contentViewController: eventDetailVC, drawerViewController: bottomSheetVC)

        self.navigationController?.pushViewController(pulleyVC, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    private func tapToUtilityVC() {
        let utilityDetailVC: UtilityDetailViewController = UtilityDetailViewController()
        bottomSheetVC.configure(image: "claim")
        let pulleyVC = PulleyViewController(contentViewController: utilityDetailVC, drawerViewController: bottomSheetVC)

        self.navigationController?.pushViewController(pulleyVC, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
}

extension BookmarkViewController: View {
    
    func bind(reactor: BookmarkViewReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    private func bindState(with reactor: BookmarkViewReactor) {
        
        reactor.state.map { $0.cellItems }
            .bind(to: self.collectionView.rx.items) { collectionView, item, element in
                
                    switch item {
                    case 0:
                        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: IndexPath(item: item, section: 0)) as? EventCell else { return UICollectionViewCell() }
                        cell.configure(image: element)
                    return cell
                        
                    case 1:
                        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UtilityCell.identifier, for: IndexPath(item: item, section: 0)) as? UtilityCell else { return UICollectionViewCell() }
                        cell.configure(image: element)
                        return cell
                        
                    default:
                        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: IndexPath(item: item, section: 0)) as? EventCell else { return UICollectionViewCell() }
                        cell.configure(image: element)
                    return cell
                    
                    }
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isBenefitTapped }
            .subscribe { [weak self] isBenefitTapped in
                guard !isBenefitTapped else { return }
                guard let `self` = self else { return }
                self.tapToBenefitVC()
            }
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isUtilityTapped }
            .subscribe { [weak self] isUtilityTapped in
                guard !isUtilityTapped else { return }
                guard let `self` = self else { return }
                self.tapToUtilityVC()
            }
            .disposed(by: self.disposeBag)

        /*
        reactor.state.map { $0.isToggle }
            .distinctUntilChanged()
            .subscribe { [weak self] isToggle in
                guard let `self` = self else { return }
                if self.calendar.scope == .month {
                    self.calendar.setScope(.week, animated: true)
                    self.toggleButton.setImage(UIImage(named: "calendar_button_down"), for: .normal)
                } else {
                    self.calendar.setScope(.month, animated: true)
                    self.toggleButton.setImage(UIImage(named: "calendar_button_up"), for: .normal)
                }
            }
            .disposed(by: self.disposeBag)
        */
        
        
    }
    
    private func bindAction(with reactor: BookmarkViewReactor) {
        
        Observable.just(Reactor.Action.refresh)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.collectionView.rx.itemSelected
            .map { indexPath in
                print("Item selected tapped")
//                return Reactor.Action.tapEventImage
                if indexPath == IndexPath(item: 0, section: 0) {
                    return Reactor.Action.tapEventImage
                } else {
                    return Reactor.Action.tapUtilityImage
                }
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
/*
        self.toggleButton.rx.tap
            .map { Reactor.Action.tapToggleButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
  */
        
        
    }
}



extension BookmarkViewController: BookmarkMenuBarDelegate {
    func didSelectItemAt(index: Int) {
        let indexPath: IndexPath = IndexPath(item: index, section: 0)
        menuBar.selectItem(at: index)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    
}
