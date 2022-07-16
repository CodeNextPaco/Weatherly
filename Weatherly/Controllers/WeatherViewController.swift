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
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
    @IBOutlet var dayViewCollection: [UIView]!
    
    var animationView : AnimationView?
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
      super.viewDidLoad()
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
            
            let dailyHighLowForecast =  self.weatherManager.weatherForecast.dailyHighLowForecast()
            
            for (idx, (day, (highTemp, lowTemp))) in dailyHighLowForecast.enumerated() {
                let view = self.dayViewCollection[idx]
                view.layer.cornerRadius = 8
                guard let stackView = view.subviews.first,
                      let dayLabel = stackView.subviews[0] as? UILabel,
                      let dayTempLabel = stackView.subviews[2] as? UILabel
                else {
                    print("stackview reference error")
                    return
                }
                let dayAnimationView_ = stackView.subviews[1]
                dayLabel.text = day.rawValue
                dayTempLabel.text = "\(highTemp)°/\(lowTemp)°"
            }
        }
    }
}
