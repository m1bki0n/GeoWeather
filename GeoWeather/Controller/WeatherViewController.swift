//
//  ViewController.swift
//  Clima
//
//  Created by Makwan BK on 3/18/20.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        //API key: b47e42e749179c4c0db79bf945d92daa
        
        searchTextField.textAlignment = .left
        searchTextField.delegate = self
        searchTextField.clearButtonMode = UITextField.ViewMode.whileEditing
    }
    
    @IBAction func currentLocationTapped(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        
        let lat = locationManager.location!.coordinate.latitude
        let lon = locationManager.location!.coordinate.longitude
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.weatherManager.fetchCurrentLocation(lat: lat, lon: lon)
        } else {
            print("User didn't let us to get it's location.")
        }
        
        
        
    }
}

//MARK: - Extensions


//Just to make the code simply and easy to understand.
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchTapped(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    //Do something when the user tapped the Return or Go button on keyboard:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    //Do something when the user try to tap Return button while typing:
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" || textField.text == " " || textField.text == "   " {
            let alert = UIAlertController(title: "Oops!", message: "Seems like you didn't enter any word on the text field.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            present(alert, animated: true)
            
            return false
        }
        
        return true
    }
    
    //Do something when the user ended editing:
    func textFieldDidEndEditing(_ textField: UITextField) {
         
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
            self.temperatureLabel.text = weather.tempDecimalRemovable
            self.cityLabel.text = weather.cityName
            
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        let userLocation = locations[0] as CLLocation
        
//        print("\(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
