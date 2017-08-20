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

class HomeViewController: UITabBarController {

    fileprivate lazy var menuBtn: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: nil, action: nil)
        return item
    }()
    let menuVC = MenuViewController.shareInstance
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        menuBtn.rx.tap.subscribe(onNext: {
            event in
            self.menuVC.showView = !self.menuVC.showView
        }).addDisposableTo(disposeBag)
    }
    
    fileprivate func setupUI() {
        UIApplication.shared.keyWindow?.addSubview(menuVC.view)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = menuBtn
    }
    
    
    
}

