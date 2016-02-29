//
//  DetailViewController.swift
//  Weatherman
//
//  Created by Weifan Lin on 2/28/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    
    var receivedCellIndex = 0
    
    var cityName : String =  ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityName = NSUserDefaults.standardUserDefaults().objectForKey("array")![receivedCellIndex] as! String
        
        findWeather()   

        // Do any additional setup after loading the view.
    }
    
    
    func findWeather (){
        
        var weather : String = ""
        
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityName.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        
        
        if url != nil {
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
                
                var urlError = false
                
                let data = dataOrNil
                if error == nil {
                    let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                    
                    //                    print(urlContent)
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 1 {
                        
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0]
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                    } else {
                        urlError = true
                    }
                    
                } else {
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    if urlError == true {
                        self.showError()
                    } else {
                        self.weatherLabel.text = "Here is weather for \(self.cityName.uppercaseString):\n" + weather
                    }
                }
                
            })
            
            task.resume()
        } else {
            showError()
        }
    }


    func showError() {
        weatherLabel.text = "Could not find weather for " + cityName + ". Please try agian"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
