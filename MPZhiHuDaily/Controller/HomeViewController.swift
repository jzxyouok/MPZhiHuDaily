//
//  ViewController.swift
//  MPZhiHuDaily
//
//  Created by Maple on 2017/8/11.
//  Copyright © 2017年 Maple. All rights reserved.
//

import UIKit
import Then
import RxCocoa
import RxSwift
import SnapKit

class HomeViewController: UITabBarController {

    fileprivate lazy var menuBtn: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: nil, action: nil)
        return item
    }()
    fileprivate lazy var hudView: UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = UIColor.black
        view.alpha = 0.3
        view.isHidden = true
        return view
    }()
    let menuVC = MenuViewController.shareInstance
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        menuBtn.rx.tap.subscribe(onNext: {
            event in
            self.menuVC.showView = !self.menuVC.showView
            self.hudView.isHidden = !self.menuVC.showView
        }).addDisposableTo(disposeBag)
        
        hudView.rx.tap.subscribe(onNext: {
            UIView.animate(withDuration: 0.5, animations: { 
                self.hudView.alpha = 0
            }, completion: { (_) in
                self.hudView.isHidden = true
                self.hudView.alpha = 0.3
            })
            self.menuVC.showView = false
        }).addDisposableTo(disposeBag)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    

    
    fileprivate func setupUI() {
        self.view.backgroundColor = UIColor.white
        UIApplication.shared.keyWindow?.addSubview(menuVC.view)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = menuBtn
        
        self.view.addSubview(hudView)
        
        hudView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    
    
}

