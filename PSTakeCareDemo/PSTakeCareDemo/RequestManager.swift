//
//  RequestManager.swift
//  PSTakeCareAssignment
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 PSTakeCare. All rights reserved.
//

import UIKit



class RequestManager: NSObject {
    
    static var sharedInstance = RequestManager()
    var countryDetails: CountryDetails?
    
    
    func getCountryDetailsFromUrl(completionHandler: (NSError?) -> Void) {
        
        NSLog("Api call")
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let url = NSURL(string: "https://staging.pstakecare.com/mock/countries.json")
        
        session.dataTaskWithURL(url!) {
            (data, response, error) -> Void in
            
            if(error == nil){
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    self.countryDetails = CountryDetails.init(jsonArray: json as! Array<Dictionary<String, AnyObject>>)
                }
                catch {
                    print("Error in json Serialization")
                }
            }
                
            else {
                print("Error in getting response from API")
            }
            
            completionHandler(error)

        }.resume()
        
    }

}
