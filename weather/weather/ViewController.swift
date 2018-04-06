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
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBAction func weatherSearch(_ sender: Any) {
        // 天気情報APIにアクセスする
        Alamofire.request("http://weather.livedoor.com/forecast/webservice/json/v1?city=130010").responseJSON {response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(String(describing: response.result))")
            
            if let json = response.result.value {
                print("JSON: \(json)")  // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")  // original server data as UTF8 String
            }
        }
    }
}

