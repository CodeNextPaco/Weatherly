//
//  Weather.swift
//  Weatherly
//
//  Created by admin on 6/20/22.

//  openweather icons and description: https://openweathermap.org/weather-conditions
//

import UIKit
import Lottie

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempNowLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lottieView: UIView!
    let manager = APIManager()
    var location = Location()
    @IBOutlet weak var searchField: UITextField!
    var animationView : AnimationView?
    
    var forecasts = WeatherForecast()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    
        //default location: SF
        
        var defaultLocation = Location()
        defaultLocation.lat = 37.7790262
        defaultLocation.lon = -122.419906
        fetchCurrentWeather(location: defaultLocation)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.forecasts.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "weatherCell") as? WeatherCell)!
        
        let cellTemp = String(self.forecasts.list[indexPath.row].main.temp)
        let dateTime = self.forecasts.list[indexPath.row].dt_txt!
        
        cell.cellTempLabel.text = cellTemp + " " + dateTime
        return cell
    }
    
    
    
    
    func setLottie(condition: String){

        //clear the previous lottie
        for subview in lottieView.subviews{
            subview.removeFromSuperview()
        }
        
        switch condition {
            
            case "overcast clouds":  animationView = .init(name: "cloudy")
            case "broken clouds": animationView = .init(name: "partly_cloudy")
            case "scattered clouds": animationView = .init(name: "partly_cloudy")
            case "few clouds": animationView = .init(name: "partly_cloudy")
            case "clear sky": animationView = .init(name: "sunny")
            case "snow": animationView = .init(name: "light_snow")
            case "rain": animationView = .init(name: "heavy_rain")
            
        
            default: animationView = .init(name: "sunny")
        }
        

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
            
            
            Task {
                var locationToSearch = self.searchField.text
        
                self.location = await self.manager.getLatLongFromTerm(term: locationToSearch!)
                
                fetchCurrentWeather(location: self.location)
                fetchForecast(location: self.location)
               }

        } else {
            
            print("Enter a location")
        }
    } //end searchForLocation
    
    func fetchCurrentWeather(location: Location){
        print("Fetching Weather")
        
        Task{
            
            let currentWeather = await self.manager.fetchCurrentWeather(location: location)
            
            print(currentWeather)
             
            let currentMain =  currentWeather.weather[0].main //current basic condition for lottie
            let desc = currentWeather.weather[0].description
            let temp = String(format: "%.0f", currentWeather.main.temp)
            let locName = currentWeather.name
            let feels_like = String(currentWeather.main.feels_like)
            let max = String(currentWeather.main.temp_max)
            let min = String(currentWeather.main.temp_min)
            let hum = String(currentWeather.main.humidity)
            
            setLottie(condition: desc)
            
            self.tempNowLabel.text = "\(temp)°F"
            self.locationLabel.text = "\(self.location.name) \(self.location.country)"
            
            self.outputLabel.text = """
                
                \(desc)
                Feels Like \(feels_like)
                Low: \(min)
                High: \(max)
                Humidity: \(hum)
                """

            
        }
    
    }
    
    func fetchForecast(location: Location){
        
        Task{
            
            
            self.forecasts = await manager.getForecastFromLocation(location: location)
        
            
           
            
            //print(self.forecasts)
            //print(self.forecasts.list)
            
            for forecast in self.forecasts.list{
                print("<<<<<<<< forecast >>>>>>>")
                print(forecast.dt_txt)
                print(forecast.weather)
                print(forecast.pop)
                print(forecast.main.temp)
                
                
                
            }
            
            tableView.reloadData()
     
//              for forecast in forecasts{
//                  print("Forecast datetime: ")
//                  //print(forecast["main"] as Any)
//
//                  let mainForecasts = forecast["main"] as Any?
//
//                  for main in mainForecasts {
//
//                      print(main["temp"])
//                  }
                  
  
              
            
        }
    }

}

