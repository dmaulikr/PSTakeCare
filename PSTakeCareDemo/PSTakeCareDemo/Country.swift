//
//  Country.swift
//  PSTakeCareAssignment
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 PSTakeCare. All rights reserved.
//

import UIKit

class Country: NSObject {
    
    var name: String?
    var area: NSInteger?
    
    init(jsonDict: Dictionary<String,AnyObject>) {
        
        self.name = jsonDict["name"] as? String
        self.area = jsonDict["area"] as? NSInteger
    }

}

class CountryDetails: NSObject {
    
    var countryDetail: [Country]? = []
    
    init(jsonArray: Array<Dictionary<String,AnyObject>>) {
        for country in jsonArray {
            let detail = Country.init(jsonDict: country)
            self.countryDetail?.append(detail)
        }
    }
}
