//
//  ViewController.swift
//  weather
//
//  Created by home on 2018/04/06.
//  Copyright © 2018年 Swift-beginners. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // 天気を調べる
    @IBAction func weatherSearch(_ sender: Any) {
        getWeather ()
    }
    
    
    // 天気情報APIにアクセスする
    func getWeather () {
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?id=1850147&units=metric&appid=ecea42c72b75c53caefaa93002224dd6").validate().responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 都市名の表示
                let cityName = json["name"].stringValue
                self.cityNameLabel.text = cityName
                
                // 現在の天気を表示
                let name = json["weather"][0]["main"].stringValue
                self.weatherLabel.text = name
                
                // 天気アイコンを表示
                let icon = json["weather"][0]["icon"]
                let url = NSURL(string:"http://openweathermap.org/img/w/\(icon).png")!
                let imageData = try? Data(contentsOf: url as URL)
                let image = UIImage(data:imageData!)
                self.iconView.image = image
                
                // 現在気温の表示
                let temperature = json["main"]["temp"].stringValue
                print(temperature)
                self.temperatureLabel.text = "現在の気温：\(temperature)℃"

            case .failure(let error):
                print(error)
            }
        }
    }
}


