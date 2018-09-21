//
//  DELDeliveryDetailsViewController.swift
//  DeliV
//
//  Created by Abilash Cumulations on 17/09/18.
//  Copyright © 2018 Cumulations Technologies. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

class DELDeliveryDetailsViewController: UIViewController {

    var mapView:MKMapView!
    var item:Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(title: Constants.DeliveryTitle)
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //view setup
    func setupView()
    {
        let mp = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.6))
        self.view.addSubview(mp)
        self.mapView = mp
        let annotation = MKPointAnnotation()
        if item?.location != nil{
            let coordinate = CLLocationCoordinate2D(latitude: (item?.location?.lat)!, longitude: (item?.location?.long)!)
            annotation.coordinate = coordinate
            mp.addAnnotation(annotation)
            mp.setCenter(coordinate, animated: true)
        }
        self.configureBottomView(y: Double(mp.frame.size.height + 5))
        
    }
    ///configuring bottom view
    /// - parameter:
    /// - y : double value
    func configureBottomView(y:Double)
    {
        let baseView = UIView(frame: CGRect(x: 10.0, y: y, width: Double((UIApplication.shared.keyWindow?.frame.size.width)! - 20), height: 70.0))
        baseView.clipsToBounds  = false
       UIUtilities.addShadow(view: baseView)
        self.view.addSubview(baseView)
        //adding imageview
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: baseView.frame.size.height))
        baseView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        
        //adding description
        let label = UILabel(frame: CGRect(x: imageView.frame.size.width + 10, y: 5, width: baseView.frame.size.width - imageView.frame.size.width + 10, height: baseView.frame.size.height))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        baseView.addSubview(label)
        label.text = item?.description
        if let url = URL(string: (item?.imageUrl)!)
        {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "default"), options: SDWebImageOptions.forceTransition, completed: nil)
        }
        else{
            imageView.image = UIImage(named: "default")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
