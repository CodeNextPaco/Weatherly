//
//  Weather.swift
//  Weatherly
//
//  Created by admin on 6/20/22.

//  openweather icons and description: https://openweathermap.org/weather-conditions
//

import UIKit
import Lottie
import Nuke

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempNowLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
    
    var animationView : AnimationView?
    var weatherManager = WeatherManager()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.delegate = self
      tableView.dataSource = self
    }
    
    func setLottie(from icon: String){

        //clear the previous lottie
        for subview in lottieView.subviews{
            subview.removeFromSuperview()
        }
        
        animationView = .init(name: Constants.getLottieAnimation(from: icon))
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
        let currentMain =  currentWeather.weather.first?.main //current basic condition for lottie
        let desc = currentWeather.weather.first?.description
        let icon = currentWeather.weather.first?.icon ?? ""
        let temp = String(format: "%.0f", currentWeather.main.temp)
        let feels_like = String(currentWeather.main.feels_like)
        let max = "\(Int(currentWeather.main.temp_max))°"
        let min = "\(Int(currentWeather.main.temp_min))°"
        let hum = String(currentWeather.main.humidity)
        
        DispatchQueue.main.async {
            self.setLottie(from: icon)
            self.tempNowLabel.text = "\(temp)°F"
            self.locationLabel.text = "\(self.weatherManager.currentLocation.name)"
            self.outputLabel.text = desc
            self.tempLowLabel.text = min
            self.tempHighLabel.text = max
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
        Nuke.loadImage(with: iconURL, into: cell.weatherIcon)
        return cell
   }
}
