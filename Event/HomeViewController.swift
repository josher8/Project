//
//  ViewController.swift
//  Event
//
//  Created by Josh Slebodnik on 1/29/19.
//  Copyright © 2019 Josh Slebodnik. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var eventArray: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.login(username: "Test", password: "Test") { token in
//            if token != nil {
//                print("Token: ", token?.token)
//            }else {
//                print("Token Nil")
//            }
//        }
        
        self.loadEventList() { events in
            if events != nil {
                self.eventArray = events!
                print(self.eventArray)
                self.tableView.reloadData()
            } else {
                print("Event Nil")
            }
        }
    }
    
//    func login(username:String, password: String, completion: @escaping (Token?) -> Void){
//
//        Alamofire.request(LoginRouter.login(username,password)).responseString { response in
//            guard response.result.isSuccess,
//                let value = response.result.value else {
//                    print("Error while getting token: \(String(describing: response.result.error))")
//                    completion(nil)
//                    return
//            }
//            completion(Token(json: value))
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let event = eventArray[indexPath.row]
        
        //Sets Event Image on Cell
        if let eventImageView = cell?.contentView.viewWithTag(1) as? UIImageView {
            eventImageView.sd_setImage(with: URL(string: event.image_url) )
        }
        
        //Event Title
        if let titleLabel = cell?.contentView.viewWithTag(2) as? UILabel {
            titleLabel.text = event.title
        }
        
        //Date
        if let dateLabel = cell?.contentView.viewWithTag(3) as? UILabel {
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MM/dd/yyyy ha"
            let dateFormatterPrintHA = DateFormatter()
            dateFormatterPrintHA.dateFormat = "ha"
            
            //Get Start Date
            let startDate = dateFormatterGet.date(from: event.start_date_time)
            let startDateString = dateFormatterPrint.string(from: startDate!)
            
            //Get End Date
            let endDate = dateFormatterGet.date(from: event.end_date_time)
            let endDateString = dateFormatterPrintHA.string(from: endDate!)
            
            dateLabel.text = startDateString + " - " + endDateString
            
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Pass event object to Single Event
        let event = eventArray[indexPath.row]
        self.performSegue(withIdentifier: "eventSegue", sender: event)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "eventSegue" {
            let singleEventController = segue.destination as? SingleEventViewController
            singleEventController?.event = sender as? Event
        }
        
    }
    
    func loadEventList(completion: @escaping ([Event]?) -> Void){
        
        Alamofire.request(EventRouter.events).responseString { response in
            guard response.result.isSuccess,
                let value = response.result.value else {
                    print("Error while getting events: \(String(describing: response.result.error))")
                    completion(nil)
                    return
            }
            completion([Event](json: value))
        }
    }


}

