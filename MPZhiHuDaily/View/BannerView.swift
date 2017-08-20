//
//  BannerView.swift
//  MPZhiHuDaily
//
//  Created by Maple on 2017/8/20.
//  Copyright © 2017年 Maple. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
import Kingfisher

/// 录播图View
class BannerView: UIView {
    
    fileprivate let itemH: CGFloat = 200
    let imgUrlArr = Variable([storyModel]())
    let dispose = DisposeBag()
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    fileprivate func setupUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        let ID = "BannerCellID"
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: ID)
        
        imgUrlArr
        .asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: ID, cellType: BannerCell.self)) {
                row, model, cell in
                cell.model = model
        }.addDisposableTo(dispose)
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenW, height: self.itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.backgroundColor = UIColor.white
        view.showsHorizontalScrollIndicator = false
        return view
    }()
}

class BannerCell: UICollectionViewCell {
    
    var model: storyModel? {
        didSet {
            if let path = model?.image {
                imgView.kf.setImage(with: URL.init(string: path))
            }
            titleLabel.text = model?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    fileprivate func setupUI() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        
        imgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(100)
        }
    }
    
    fileprivate lazy var imgView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
}


