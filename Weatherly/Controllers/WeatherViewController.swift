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
    @IBOutlet weak var currentWeatherAnimationView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
    @IBOutlet var dayViewCollection: [UIView]!
    
    @IBOutlet weak var feelsLikeLottieView: UIView!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var precipitationLottieView: UIView!
    @IBOutlet weak var precipitationLabel: UILabel!
    
    @IBOutlet weak var sunLabel: UILabel!
    
    @IBOutlet weak var windLottieView: UIView!
    @IBOutlet weak var windLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    func setBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Page1")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func setLottie(on lottieView: UIView, from icon: String){
        //clear the previous lottie
        for subview in lottieView.subviews{
            subview.removeFromSuperview()
        }
        var animationView : AnimationView?
        animationView = .init(name: Constants.getLottieAnimation(from: icon))
        animationView?.loopMode = .loop
        animationView?.frame = lottieView.bounds
//        animationView?.contentMode = .scaleToFill
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
        let main =  currentWeather.weather.first //current basic condition for lottie
        let desc = currentWeather.weather.first!.description
        let icon = currentWeather.weather.first!.icon
        let temp = "\(Int(currentWeather.main.temp))"
        let feelsLike = "\(currentWeather.main.feelsLike)°"
        let max = "\(Int(currentWeather.main.tempMax))°"
        let min = "\(Int(currentWeather.main.tempMin))°"
        let sunLabel = currentWeather.formattedSunsetSunrise()
        
        DispatchQueue.main.async {
            self.setLottie(on: self.currentWeatherAnimationView, from: icon)
            self.tempNowLabel.text = "\(temp)°F"
            self.locationLabel.text = "\(self.weatherManager.currentLocation.name)"
            self.outputLabel.text = desc
            self.tempLowLabel.text = min
            self.tempHighLabel.text = max
            
            let dailyHighLowForecast =  self.weatherManager.weatherForecast.dailyHighLowForecast()
            
            for (idx, (day, (highTemp, lowTemp))) in dailyHighLowForecast.enumerated() {
                let view = self.dayViewCollection[idx]
                view.layer.cornerRadius = 8
                print(day, highTemp, lowTemp)
                guard let stackView = view.subviews.first,
                      let dayLabel = stackView.subviews[0] as? UILabel,
                      let dayTempLabel = stackView.subviews[2] as? UILabel
                else {
                    print("stackview reference error")
                    return
                }
                
                let dayAnimationView = stackView.subviews[1]
                self.setLottie(on: dayAnimationView, from: "01d")
//                dayAnimationView.backgroundColor = .red
                dayLabel.text = day.rawValue
                dayTempLabel.text = "\(highTemp)°/\(lowTemp)°"
            }
            
            self.feelsLikeLabel.text = feelsLike
            self.sunLabel.text = sunLabel
        }
    }
}
