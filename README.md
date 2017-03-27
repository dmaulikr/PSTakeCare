# PSTakeCareDemo
It is a demo project to display list of countries and their area code from the URL provided. It takes care of displaying the data even in the case of no internet connection. 

### Tech
* Caching is achieved through NSManagedObject and       NSPersistentStoreCoordinator
* Http requests are served using NSURLSession
* Storyboards and auto layout is used to create adaptive interfaces.
* Separate Manager Class is created for http requests which currently serves only one request but can be used to serve all http requests.
* Country.swift is the model class.
* Singleton Design Pattern is used to provide access of Request Manager.
* Custom Table View Cell is added to display country name and area.

### Installation

It requires Xcode 7.3.1 and swift 2.0 to run. 
