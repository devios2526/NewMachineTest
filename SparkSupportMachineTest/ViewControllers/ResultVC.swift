//
//  ResultVC.swift
//  SparkSupportMachineTest
//
//  Created by Salman Macbook Air M3 on 22/11/24.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var weathrImgVw: UIImageView!
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData()
        navigationController?.setNavigationBarHidden(false, animated: false)
        // Do any additional setup after loading the view.
    }
    
    
    private func fetchWeatherData() {
           let apiKey = "7ebdb8d31b97de17f253d98f47ee4235"
           let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
           
           guard let url = URL(string: urlString) else {
               showAlert(message: "Invalid API URL.")
               return
           }
           
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   print("Error fetching weather data: \(error)")
                   DispatchQueue.main.async {
                       self.showAlert(message: "Failed to fetch weather data.")
                   }
                   return
               }
               guard let data = data else { return }
               do {
                   if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                       DispatchQueue.main.async {
                           self.fetchDetails(with: json)
                       }
                   }
               } catch {
                   print("JSON Parsing error: \(error)")
                   DispatchQueue.main.async {
                       self.showAlert(message: "Failed to parse weather data.")
                   }
               }
           }.resume()
       }

    private func fetchDetails(with json: [String: Any]) {
            let cityName = json["name"] as? String ?? "Unknown"
            let weatherArray = json["weather"] as? [[String: Any]]
            let weatherDescription = weatherArray?.first?["description"] as? String ?? "Unknown"
            let weatherMain = weatherArray?.first?["main"] as? String ?? "Unknown"
            let main = json["main"] as? [String: Any]
            let temperature = main?["temp"] as? Double ?? 0.0
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let currentDate = dateFormatter.string(from: Date())
            
           cityNameLbl.text = cityName
           temperatureLbl.text = "\(temperature)°C"
           dateLbl.text = currentDate
           weatherLbl.text = weatherDescription.capitalized
           updateWeatherIcon(for: weatherMain)
        }
    
    
    private func updateWeatherIcon(for condition: String) {
           let iconName: String
           switch condition.lowercased() {
           case "rain":
               iconName = "cloud.rain.fill"
           case "clear":
               iconName = "sun.max.fill"
           case "clouds":
               iconName = "cloud.fill"
           case "snow":
               iconName = "cloud.snow.fill"
           default:
               iconName = "questionmark.circle.fill" 
           }
           
        weathrImgVw.image = UIImage(systemName: iconName)
        weathrImgVw.tintColor = .white
       }
    
    private func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
