//
//  NftCardCellBackView.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/31.
//

import UIKit

class NftCardCellBackView: UIView {
    
    //MARK: - Temporary: Utility TableView Dummy Data
    let utilitesList: [UtilityModel] = [
        UtilityModel(companyName: "롯데멤버스", benefit: "L. POINT 5천 포인트 교환권", valid: IsValid.valid),
        UtilityModel(companyName: "롯데멤버스", benefit: "롯데 GRS(식음료) 5천원 모바일 쿠폰", valid: IsValid.valid),
        UtilityModel(companyName: "롯데 시그니엘", benefit: "롯데 시그니엘 플래티넘 패키지 -1", valid: IsValid.valid),
        UtilityModel(companyName: "롯데멤버스", benefit: "L. POINT 5천 포인트 교환권", valid: IsValid.valid),
        UtilityModel(companyName: "롯데멤버스", benefit: "롯데 GRS(식음료) 5천원 모바일 쿠폰", valid: IsValid.valid),
        UtilityModel(companyName: "롯데 시그니엘", benefit: "롯데 시그니엘 플래티넘 패키지 -1", valid: IsValid.valid)
    ]
    
    
    //MARK: - UIElements

    lazy var utilPropertySegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Utilities", "Properties"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = .white
        control.backgroundColor = .white
        control.setBackgroundImage(UIImage(named: "white_bg"), for: .normal, barMetrics: .default)
        control.setDividerImage(UIImage(named: "white_bg")!.aspectFitImage(inRect: CGRect(x: 0, y: 0, width: 1, height: 10)), forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)
        
        control.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        
        let font = BellyGomFont.header04!
        
        let selectedColor = AftermintColor.bellyTitleGrey
        let unselectedColor = AftermintColor.traitGrey
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        control.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let buttonBar: UIView = {
        let view = UIView()
        view.backgroundColor = AftermintColor.bellyTitleGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let utilityView: UITableView = {
        let tableView = UITableView()
        tableView.register(NftCardUtilityCell.self, forCellReuseIdentifier: NftCardUtilityCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
        
    let propertyView: PropertyView = {
        let view = PropertyView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        dynamicCellHeight()
        
        setUI()
        setLayout() 
        
        utilityView.delegate = self
        utilityView.dataSource = self
        self.didChangeValue(segment: self.utilPropertySegmentedControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var shouldHideUtilityView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideUtilityView else { return }
            self.utilityView.isHidden = shouldHideFirstView
            self.propertyView.isHidden = !self.utilityView.isHidden
        }
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideUtilityView = segment.selectedSegmentIndex != 0
        
        segmentedControlValueChanged(segment)
    }
    
    private func dynamicCellHeight() {
        self.utilityView.rowHeight = UITableView.automaticDimension
        self.utilityView.estimatedRowHeight = 100
    }
    
    private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.utilPropertySegmentedControl.frame.width / CGFloat(self.utilPropertySegmentedControl.numberOfSegments)) * CGFloat(self.utilPropertySegmentedControl.selectedSegmentIndex) + self.utilPropertySegmentedControl.frame.origin.x
        }
    }
    
    private func setUI() {
        self.addSubview(utilPropertySegmentedControl)
        self.addSubview(buttonBar)
        self.addSubview(utilityView)
        self.addSubview(propertyView)
        
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            utilPropertySegmentedControl.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            utilPropertySegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            utilPropertySegmentedControl.heightAnchor.constraint(equalToConstant: 30),
            utilPropertySegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            
            buttonBar.topAnchor.constraint(equalTo: utilPropertySegmentedControl.bottomAnchor),
            buttonBar.heightAnchor.constraint(equalToConstant: 2),
            buttonBar.leadingAnchor.constraint(equalTo: utilPropertySegmentedControl.leadingAnchor),
            buttonBar.widthAnchor.constraint(equalTo: utilPropertySegmentedControl.widthAnchor, multiplier: 1 / CGFloat(utilPropertySegmentedControl.numberOfSegments)),
            
            utilityView.topAnchor.constraint(equalTo: buttonBar.bottomAnchor, constant: 10),
            utilityView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            utilityView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            utilityView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            propertyView.topAnchor.constraint(equalTo: utilityView.topAnchor),
            propertyView.leadingAnchor.constraint(equalTo: utilityView.leadingAnchor),
            propertyView.trailingAnchor.constraint(equalTo: utilityView.trailingAnchor),
            propertyView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        utilPropertySegmentedControl.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
}
//MARK: - TableView Delegate & DataSource
extension NftCardCellBackView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilitesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NftCardUtilityCell.identifier, for: indexPath) as? NftCardUtilityCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(companyName: utilitesList[indexPath.row].companyName,
                       benefit: utilitesList[indexPath.row].benefit,
                       valid: utilitesList[indexPath.row].valid)
        
        cell.selectionStyle = .none
        
        return cell
    }
    


    
}
