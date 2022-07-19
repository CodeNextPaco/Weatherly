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
    @IBOutlet weak var actualTempLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentWeatherAnimationView: UIView!
    @IBOutlet weak var tempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
    @IBOutlet var dayViewCollection: [UIView]!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsOnTap = true
        searchController.searchBar.placeholder = "Enter City..."
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
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
        lottieView.insertSubview(animationView!, at: 0)
        animationView?.animationSpeed = 0.8
        animationView?.play()
    }
    
    func updateUI() {

        let currentWeather = weatherManager.currentWeather
        
        DispatchQueue.main.async {
            self.setLottie(on: self.currentWeatherAnimationView, from: currentWeather.weather.first!.icon)
            self.actualTempLabel.text = "\(Int(currentWeather.main.temp))°F"
            self.locationLabel.text = "\(self.weatherManager.currentLocation.name)"
            self.descriptionLabel.text = currentWeather.weather.first!.description
            self.tempLowLabel.text = "\(Int(currentWeather.main.tempMax))°"
            self.tempHighLabel.text = "\(Int(currentWeather.main.tempMin))°"
            
            let dailyHighLowForecast =  self.weatherManager.weatherForecast.dailyHighLowForecast()
            
            for (idx, (day, (highTemp, lowTemp))) in dailyHighLowForecast.enumerated() {
                let dayCardView = self.dayViewCollection[idx]
                guard let dayStackView = dayCardView.subviews.first,
                      let dayNameLabel = dayStackView.subviews[0] as? UILabel,
                      let dayTempLabel = dayStackView.subviews[2] as? UILabel
                else {
                    print("stackview reference error")
                    return
                }
                
                let dayAnimationView = dayStackView.subviews[1]
                self.setLottie(on: dayAnimationView, from: "01d") // TODO: get actual day icon
                self.precipitationLabel.text = String(currentWeather.main.humidity)
                dayNameLabel.text = day.rawValue
                dayTempLabel.text = "\(highTemp)°/\(lowTemp)°"
            }
            
            self.feelsLikeLabel.text = "\(currentWeather.main.feelsLike)°"
            self.sunriseLabel.text = currentWeather.formattedSunriseTime()
            self.sunsetLabel.text = currentWeather.formattedSunsetTime()
            self.windSpeedLabel.text = "\(currentWeather.wind.speed) mph"
            self.windDirectionLabel.text = "\(currentWeather.wind.deg)°"
            
            self.navigationController?.navigationBar.isHidden = true
        }
    }
}

extension WeatherViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
            print(text)
        
        if(!text.isEmpty){
            print("Search for location:")
            self.weatherManager.fetchCurrentWeatherAndForecast(from: text) {
                self.updateUI()
            }
        }
    }
}
