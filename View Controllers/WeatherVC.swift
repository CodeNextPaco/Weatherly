//
//  Weather.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import UIKit
import Lottie

class WeatherVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var lottieView: UIView!
    let manager = APIManager()
    var location = Location()
    @IBOutlet weak var searchField: UITextField!
    var animationView : AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //TESTING LOTTIE
        animationView = .init(name: "thunder")
        animationView?.loopMode = .loop
        animationView?.frame = lottieView.bounds
        lottieView.insertSubview(animationView!, at: 0)
        animationView?.animationSpeed = 0.8
        animationView?.play()
        
    }
   
    @IBAction func searchForLocation(_ sender: Any) {
    
        if(self.searchField.text !=
           ""){
            print("Search for location:")
            
            let locationToSearch = self.searchField.text
    
            print(locationToSearch!)
            
            Task {
                
                self.location = await self.manager.getLatLongFromTerm(term: locationToSearch!)
            
                self.outputLabel.text = """
                    Coordinates for: \( self.location.name )
                    Lat: \(self.location.lat ),
                    Lon: \(self.location.lon )

                    """
                
                fetchCurrentWeather(location: self.location)
               }
            
             
           // self.location.lon = location["lon"]
            
            
            
        } else {
            
            print("Enter a location")
        }
    } //end searchForLocation
    
    func fetchCurrentWeather(location: Location){
        print("Fetching Weather")
        print(location)
        
        Task{
            
            let currentWeather = await self.manager.fetchCurrentWeather(location: location)
            
            print()
            
             let desc = currentWeather.weather[0].description
            let temp = String(currentWeather.main.temp)
            
            self.outputLabel.text = desc + "\n" + temp + " degrees F"
            
        }
        
        
    }
    
    
    
    
}

