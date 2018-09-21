//
//  BCHomeViewController.swift
//   DeliV
//
//  Created by Abilash Cumulations on 01/07/18.
//  Copyright © 2018 Cumulations Technologies. All rights reserved.
//

import UIKit


class DELHomeViewController: UIViewController {
    
    var reloadButton: UIButton!
    var tableVW: UITableView!
    
    private var viewModel = DELHomeViewModel()
    private var items:[Item]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(title: Constants.HomeTitle)
        self.setupTableView()
        self.loadData()
    }
    
    func setupTableView()
    {
        let tv = UITableView(frame:  CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .grouped)
        tv.separatorStyle = .none
        if #available(iOS 11, *) {
            tv.contentInsetAdjustmentBehavior = .never
        }else{
        automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(tv)
        //register cell
        tv.register(DELItemTableViewCell.self, forCellReuseIdentifier: Constants.ItemCell)
        tv.delegate = self
        tv.dataSource = self
        self.tableVW = tv
        
    }
    /// Initilize view
    func loadData()
    {
        self.tableVW.isHidden = false
        self.showTableViewLoader()
        viewModel.getItems { (response) in
            
            if response is [Item]
            {
                self.items = response as? [Item]
            }else if response is Error{
                let error = response as? Error
                self.showAlert("Alert!!!", (error?.localizedDescription)!)
                DispatchQueue.main.async {
                    self.tableVW.isHidden = true
                }
            }else{
                DispatchQueue.main.async {
                    self.tableVW.isHidden = true
                }
                
            }
            self.hideTableViewLoader(tableView: self.tableVW)
        }
    }
    
    @IBAction func clickOnReload(_ sender: Any)
    {
        self.loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.DeliveryDetailsSegue {
            let vc = segue.destination as? DELDeliveryDetailsViewController
            if let item = sender as? Item{
                vc?.item = item
            }
            
        }
    }
}
extension DELHomeViewController:UITableViewDelegate,UITableViewDataSource
{
    /// tableview datasource
    // number of section
    // first section for category
    // second section for items list
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    // number of rows returns for both category and items
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items != nil ? items!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = DELItemTableViewCell(style: .default, reuseIdentifier: Constants.ItemCell)
        cell.selectionStyle = .none
        cell.setupCell()
        let item = items![indexPath.row]
            //configure cell with item object
        cell.configureCell(item: item, index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Check if the last row number is the same as the last current data element
        if indexPath.row == (self.items?.count)! - 1 {
            self.viewModel.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items![indexPath.row]
        self.performSegue(withIdentifier: Constants.DeliveryDetailsSegue, sender: item)
    }
}


