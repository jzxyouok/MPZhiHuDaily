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
import Moya

class HomeViewController: UITabBarController {

    fileprivate var barImg = UIView()
    let menuVC = MenuViewController.shareInstance
    let disposeBag = DisposeBag()
    let provider = RxMoyaProvider<ApiManager>()
    
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
        
        loadData()
    }
    

    
    fileprivate func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        barImg = (navigationController?.navigationBar.subviews.first)!
        barImg.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(menuVC.view)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.rgb(63, 141, 208)
        navigationController?.navigationBar.isTranslucent = false
        
        self.view.addSubview(tableView)
        self.view.addSubview(hudView)
        
        hudView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-64)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Action
    fileprivate func loadData() {
        provider.request(.getNewsList)
        .mapModel(listModel.self)
            .subscribe(onNext: {
                model in
                var arr = model.top_stories!
                arr.insert(arr.last!, at: 0)
                arr.append(arr[1])
                print(arr)
            })
        .addDisposableTo(disposeBag)
    }
    
    // MARK: - View
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
    fileprivate lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "NewsCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        barImg.alpha = scrollView.contentOffset.y / 200
    }
}











