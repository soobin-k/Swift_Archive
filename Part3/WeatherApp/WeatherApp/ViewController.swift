//
//  ViewController.swift
//  WeatherApp
//
//  Created by 김수빈 on 2022/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapFetchWeatherButton(_ sender: Any) {
            if let cityName = self.cityNameTextField.text {
              self.getCurrentWeather(cityName: cityName)
              self.view.endEditing(true)
            }
    }

    func configureView(weatherInformation: WeatherInformation) {
          self.cityNameLabel.text = weatherInformation.name
          if let weather = weatherInformation.weather.first {
              self.weatherDescriptionLabel.text = weather.description
          }
          self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))℃"
          self.minTempLabel.text = "최저: \(Int(weatherInformation.temp.minTemp - 273.15))℃"
          self.maxTempLabel.text = "최고: \(Int(weatherInformation.temp.maxTemp - 273.15))℃"
    }

    func showAlert(message: String) {
          let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
    }

    func getCurrentWeather(cityName: String) {
          guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=ee212b801dceebdfd085b239eb4dc24f") else { return }
          let session = URLSession(configuration: .default)
          session.dataTask(with: url) { [weak self] data, response, error in
                let successRange = (200..<300)
                guard let data = data, error == nil else { return }
                let decoder = JSONDecoder()
                if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                      guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return } // ✨JSON 형 -> WeatherInformation 형으로 변환
                      DispatchQueue.main.async { // UI 작업은 main 쓰레드에서 이루어져야 하기 때문
                            self?.weatherStackView.isHidden = false
                            self?.configureView(weatherInformation: weatherInformation)
                      }
                } else {
                      guard let errorMesaage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                      DispatchQueue.main.async {
                          self?.showAlert(message: errorMesaage.message)
                      }
                }

          }.resume()
    }
}

