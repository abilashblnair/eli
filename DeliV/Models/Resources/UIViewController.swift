//
//  UIViewController.swift
//   DeliV
//
//  Created by Abilash Cumulations on 01/07/18.
//  Copyright © 2018 Cumulations Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController{

    func setTitle(title:String)
    {
        self.title = title
        if #available(iOS 11, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        }
    }
    func showTableViewLoader()
   {
    DispatchQueue.main.async {
        UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show()
    }
   }
    
    func hideTableViewLoader(tableView:UITableView)
    {
        DispatchQueue.main.async {
        UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
            tableView.reloadData()
        }
    }
    
    /**
     Displays alert with specified title & message
     
     - parameter title:      the title
     - parameter message:    the message
     - parameter completion: the completion callback
     */
    func showAlert(_ title: String, _ message: String, completion: (()->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.default,
                                      handler: { (_) -> Void in
                                        alert.dismiss(animated: true, completion: nil)
                                        DispatchQueue.main.async {
                                            completion?()
                                        }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    

}
