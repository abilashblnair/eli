
//  NetworkServices.swift
//   DeliV
//
//  Created by Abilash on 01/06/18.
//  Copyright © 2018 Cumulations Technologies. All rights reserved.
//

import UIKit
import MobileCoreServices




class NetworkServices: NSObject {
    //MARK: Completion handler
    typealias ServiceSuccessBlock = (_ dataTask:URLResponse, _ response: Any?) -> Void
    typealias ServiceFailureBlock = (_ error: Error?) -> Void
    
    private static var networkServices:NetworkServices?
    var session:URLSession?
    
    var uploadSession:URLSession?
    //MARK: Singleton function
    class func SharedNetwork() -> NetworkServices
    {
        if networkServices == nil
        {
            networkServices = NetworkServices()
            networkServices?.configurateSession()
        }
        return networkServices!;
    }
    ///    private function declerations
    /// -- configure session
    private func configurateSession()
    {
        let configure = URLSessionConfiguration.default//background(withIdentifier: "DAM services")
        configure.timeoutIntervalForRequest = 30
        configure.urlCache = nil;
        self.session = URLSession.init(configuration: configure)
      
    }
    /// - returns: get request for URL
    private func getRequest(url:URL) ->URLRequest
    {
        var request:URLRequest!;
        request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request;
    }
   
    /// - returns: error object from the string
     func getError(errorMessage:String) ->NSError?
    {
        let error = NSError(domain: errorMessage, code: 1110, userInfo: [NSLocalizedDescriptionKey : errorMessage]);
        return error
    }
   

    //MARK: GET FUNCTION
    /// - parameters: Url to process get API
    /// - parameters: Success completion handler
    /// - parameters: Failure completion Handler
    func get(withUrl url:URL, withSuccess successBlock:@escaping (ServiceSuccessBlock), andFailure failureBlock: @escaping (ServiceFailureBlock)) {
        let dataTask = self.session?.dataTask(with: getRequest(url: url), completionHandler: { (data, response, error) in
            //remove loader
            do
            {
                if error == nil
                {
                    let JSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    successBlock(response!,JSON)
                }else
                {
                    failureBlock(error)
                }
            } catch let error {
                print ("Error == %@",error.localizedDescription)
                failureBlock(error)
            }
        })
        dataTask?.resume()
        
    }
 
}



