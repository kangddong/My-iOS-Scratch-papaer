//
//  ViewController.swift
//  testCollectionViewHeader
//
//  Created by dongyeongkang on 2023/06/27.
//

import UIKit

class CustomCollectionHeaderView: UICollectionReusableView {
    static let identifier = "CustomCollectionHeaderView"
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Header".uppercased()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    
    func configure() {
        backgroundColor = .systemGreen
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}

class CustomCollectionFooterView: UICollectionReusableView {
    static let identifier = "CustomCollectionFooterView"
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Footer".uppercased()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    
    func configure() {
        backgroundColor = .systemPink
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}

class ViewController: UIViewController {
    
    enum SectionType {
        case none
        case header
        case footer
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.register(CustomCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionHeaderView.identifier)
        collectionView.register(CustomCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CustomCollectionFooterView.identifier)
        return collectionView
    }()

    var sectionList: [SectionType] = [.none, .header, .footer]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.frame = view.bounds
    }
    
    private func setUI() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch sectionList[section] {
        case .none:
            return 1
        case .header:
            return 2
        case .footer:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch sectionList[indexPath.section] {
        case .none:
            cell.backgroundColor = .systemBlue
            return cell
        case .header:
            cell.backgroundColor = .systemRed
            return cell
        case .footer:
            cell.backgroundColor = .systemYellow
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch sectionList[indexPath.section] {

        case .none:
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionHeaderView.identifier, for: indexPath) as? CustomCollectionHeaderView else {
                    return CustomCollectionHeaderView()
                }
                header.configure()
                return header
            } else {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CustomCollectionFooterView.identifier, for: indexPath) as? CustomCollectionFooterView else {
                    return CustomCollectionFooterView()
                }
                footer.configure()
                return footer
            }
        case .header:
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionHeaderView.identifier, for: indexPath) as? CustomCollectionHeaderView else {
                    return CustomCollectionHeaderView()
                }
                header.configure()
                return header
            } else {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CustomCollectionFooterView.identifier, for: indexPath) as? CustomCollectionFooterView else {
                    return CustomCollectionFooterView()
                }
                footer.configure()
                return footer
            }
        case .footer:
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomCollectionHeaderView.identifier, for: indexPath) as? CustomCollectionHeaderView else {
                    return CustomCollectionHeaderView()
                }
                header.configure()
                return header
            } else {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CustomCollectionFooterView.identifier, for: indexPath) as? CustomCollectionFooterView else {
                    return CustomCollectionFooterView()
                }
                footer.configure()
                return footer
            }
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch sectionList[section] {
            
        case .none:
            return CGSize(width: 0, height: 0)
        case .header:
            return CGSize(width: view.frame.size.width, height: 200)
        case .footer:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch sectionList[section] {
            
        case .none:
            return CGSize(width: 0, height: 0)
        case .header:
            return CGSize(width: 0, height: 0)
        case .footer:
            return CGSize(width: view.frame.size.width, height: 200)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionList.count
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.2, height: view.frame.width / 2.2)
    }
}

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
