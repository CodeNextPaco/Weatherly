//
//  Weather.swift
//  Weatherly
//
//  Created by admin on 6/20/22.

//  openweather icons and description: https://openweathermap.org/weather-conditions
//

import UIKit
import Lottie

class WeatherViewController: UIViewController {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempNowLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var searchField: UITextField!
  
    var animationView : AnimationView?
    var weatherManager = WeatherManager()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.delegate = self
      tableView.dataSource = self
  
      //default location: SF
      
      var defaultLocation = Location()
      defaultLocation.name = "San Francisco"
      defaultLocation.country = "US"
      defaultLocation.lat = 37.7790262
      defaultLocation.lon = -122.419906
      weatherManager.fetchCurrentWeather(from: defaultLocation) {
          self.updateUI()
      }
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
    
        if(!searchField.text!.isEmpty){
            print("Search for location:")
            self.weatherManager.fetchCurrentWeatherAndForecast(from: searchField.text!) {
                    self.updateUI()
            }
        }
    }

    func updateUI() {

        let currentWeather = weatherManager.currentWeather
        let currentMain =  currentWeather.weather[0].main //current basic condition for lottie
        let desc = currentWeather.weather[0].description
        let temp = String(format: "%.0f", currentWeather.main.temp)
        let locName = currentWeather.name
        let feels_like = String(currentWeather.main.feels_like)
        let max = String(currentWeather.main.temp_max)
        let min = String(currentWeather.main.temp_min)
        let hum = String(currentWeather.main.humidity)
        
        DispatchQueue.main.async {
            self.setLottie(condition: desc)
            self.tempNowLabel.text = "\(temp)°F"
            self.locationLabel.text = "\(self.weatherManager.currentLocation.name) \(self.weatherManager.currentLocation.country)"

            self.outputLabel.text = """
            \(desc)
            Feels Like \(feels_like)
            Low: \(min)
            High: \(max)
            Humidity: \(hum)
            """
            self.tableView.reloadData()
        }
    }
}

//
// MARK: -Table View Delegate
//
extension WeatherViewController: UITableViewDelegate {}

//
// MARK: -Table View Data Source
//
extension WeatherViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return self.weatherManager.weatherForecast.list.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherCell
       
     let forecasts = self.weatherManager.weatherForecast.list
     let cellTemp = String(format: "%.0f", forecasts[indexPath.row].main.temp) + "°F"
     let dateTime = forecasts[indexPath.row].formattedDate()
       
     cell.cellTempLabel.text = cellTemp + " " + dateTime
     
     let iconString = forecasts[indexPath.row].weather[0].icon
     let iconURL = URL(string: "https://openweathermap.org/img/wn/\(iconString).png")!
     print("ICON: \(iconURL)" )
     cell.weatherIcon.loadurl(url: iconURL)
     
     return cell
   }
}
