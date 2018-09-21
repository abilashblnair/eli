//
//  BCHomeViewModel.swift
//   DeliV
//
//  Created by Abilash Cumulations on 01/07/18.
//  Copyright © 2018 Cumulations Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class DELHomeViewModel: NSObject {
    
    var items = [Item]()
    // number of items to be fetched each time (i.e., query LIMIT)
    let itemsPerBatch = 20
    
    // Where to start fetching items (query OFFSET)
    var offset = 0
    
    // a flag for when all database items have already been loaded
    var reachedEndOfItems = false
    
    typealias completionHandler = (Any)->Void
    
    var handler:completionHandler?
    
    func getItems(completions:@escaping (Any)->Void)
    {
        if handler == nil{
            handler = completions
        }

        let url = URL(string: "\(Constants.DeliVAPI)\(Constants.DeliveryEndpoint)?offset=\(offset)&limit=\(itemsPerBatch)")
        NetworkServices.SharedNetwork().get(withUrl: url!, withSuccess: { (response, output) in
            if let json = output as? [[String:Any]]
            {
                print(json)
                
                 let jsonObj = JSON(json)
                
                let items = jsonObj.arrayValue.map({Item.fromJson($0)})
                
                self.items.append(contentsOf: items)
                
                if items.count < self.itemsPerBatch
                {
                    self.reachedEndOfItems = true
                }
                self.offset = self.offset + items.count
                self.handler!(self.items)
                
                
            }
        }) { (error) in
            if let err = error{
                if err.localizedDescription.contains("correct format")
                {
                    self.getItems(completions: completions)
                    return
                }
            }
            self.handler!(error)
        }
    }
    
    ///load more if it is not end of items

    func loadMore()
    {
        guard !self.reachedEndOfItems else {
            return
        }
        guard handler != nil else {
            return
        }
        self.getItems(completions: handler!)
        
    }
    
    
}
