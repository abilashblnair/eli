//
//  UIUtilities.swift
//  DeliV
//
//  Created by Abilash Cumulations on 18/09/18.
//  Copyright © 2018 Cumulations Technologies. All rights reserved.
//

import Foundation
import UIKit

class UIUtilities{
    
    class public func addBorder(view:UIView,width:Float,color:UIColor){
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = CGFloat(width)
    }
    
    static public func addShadow(view:UIView)
    {
        view.layer.cornerRadius = 2

        // border
        view.layer.borderWidth = 1.0
        
        view.layer.borderColor = UIColor.white.cgColor
        // shadow
        view.layer.shadowColor = UIColor.darkGray.cgColor
        
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        view.layer.shadowOpacity = 0.5
        
        view.layer.shadowRadius = 1.0
        
    }
}
