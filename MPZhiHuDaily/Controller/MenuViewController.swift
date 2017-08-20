//
//  MenuViewController.swift
//  MPZhiHuDaily
//
//  Created by Maple on 2017/8/18.
//  Copyright © 2017年 Maple. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    static let shareInstance = createMenuVC()
    
    var showView = false {
        didSet {
            showView ? showMenuView() : hideMenuView()
        }
    }
    
    fileprivate static func createMenuVC() -> MenuViewController{
        let menuVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        menuVC?.view.frame = CGRect(x: -225, y: 0, width: 225, height: screenH)
        return menuVC!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action
    /// 显示菜单栏
    func showMenuView() {
        let view = UIApplication.shared.keyWindow?.subviews.first
        let menuView = UIApplication.shared.keyWindow?.subviews.last
        UIApplication.shared.keyWindow?.bringSubview(toFront: (menuView)!)

        UIView.animate(withDuration: 0.5, animations: {
            view?.transform = CGAffineTransform.init(translationX: 225, y: 0)
            menuView?.transform = (view?.transform)!
        })
    }
    
    /// 隐藏菜单栏
    func hideMenuView() {
        let view = UIApplication.shared.keyWindow?.subviews.first
        let menuView = UIApplication.shared.keyWindow?.subviews.last

        UIApplication.shared.keyWindow?.bringSubview(toFront: (menuView)!)
        UIView.animate(withDuration: 0.5, animations: {
            view?.transform = CGAffineTransform.init(translationX: 0, y: 0)
            menuView?.transform = (view?.transform)!
        })

    }

}
