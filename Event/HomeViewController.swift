//
//  ViewController.swift
//  Event
//
//  Created by Josh Slebodnik on 1/29/19.
//  Copyright © 2019 Josh Slebodnik. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
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

