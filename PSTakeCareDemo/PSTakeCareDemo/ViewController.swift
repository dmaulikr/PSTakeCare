//
//  ViewController.swift
//  PSTakeCareAssignment
//
//  Created by Prerna on 21/03/17.
//  Copyright © 2017 PSTakeCare. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var countryDetails: [Country]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.getCountryData()
    }
    
    
    func getCountryData() {
        self.fetchDataFromCache(){
            (errorinFetchingDataFromCache) -> Void in
            
            if(errorinFetchingDataFromCache) {
                self.fetchDataFromApi()
            }
        }
    }
    
    func fetchDataFromApi(){
        RequestManager.sharedInstance.getCountryDetailsFromUrl() {
            (error) -> Void in
            
            if (error != nil) {
                NSLog("Error in getting response from API")
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.makeToast("No data to be displayed", duration: 2.0, position: ToastPosition.Bottom)})

            }
                
            else {
                self.countryDetails = RequestManager.sharedInstance.countryDetails?.countryDetail
                NSLog("Fetched response from API")
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.sortDataOnArea()
                    self.tableView.reloadData()
                    self.saveDataToCache()
                })
            }
        }
    }
    
    func saveDataToCache(){
        NSLog("Data saved to cache")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        for country in self.countryDetails! {
            let entity = NSEntityDescription.entityForName("Country", inManagedObjectContext: managedContext)
            let countryData = NSManagedObject.init(entity: entity!, insertIntoManagedObjectContext: managedContext)
            countryData.setValue(country.name, forKey: "name")
            countryData.setValue(country.area, forKey: "area")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
    func fetchDataFromCache(error: (Bool) -> Void){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        var eror = false
        
        let fetchRequest = NSFetchRequest(entityName: "Country")
        
        do {
            let countryData = try managedContext.executeFetchRequest(fetchRequest)
            if(countryData.count == 0) {
                eror = true
            }
            var dict: Dictionary<String, AnyObject> = [:]
            for i in countryData {
                dict["name"] = i.valueForKey("name")
                dict["area"] = i.valueForKey("area")
                let country = Country.init(jsonDict: dict)
                self.countryDetails?.append(country)
            }
            self.tableView.reloadData()
        }
        catch let err as NSError {
            eror = true
            print("Could not fetch. \(err), \(err.userInfo)")
        }
        
        error(eror)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func registerCell(){
        self.tableView.registerNib(UINib(nibName: "CountryInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryInfoCell")
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let countryData = self.countryDetails {
            return countryData.count
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CountryInfoCell", forIndexPath: indexPath) as? CountryInfoTableViewCell
        
        let countryData = self.countryDetails![indexPath.row]
        cell?.countryName.text = countryData.name
        cell?.countryArea.text = ""
        if let area = countryData.area {
            cell?.countryArea.text = "\(area)"
        }
        cell?.selectionStyle = .None
        return cell!
    }
    
    func sortDataOnArea() {
        self.countryDetails!.sortInPlace({ $0.area < $1.area })
    }

}

