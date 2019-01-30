//
//  SingleEventViewController.swift
//  Event
//
//  Created by Josh Slebodnik on 1/29/19.
//  Copyright © 2019 Josh Slebodnik. All rights reserved.
//

import UIKit
import SDWebImage

class SingleEventViewController: UIViewController {
    
    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationButton: UIButton!
    
    var event: Event? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make sure event is here
        if event != nil {
            
            self.title = event?.title
            
            eventImageView.sd_setImage(with: URL(string: (event?.image_url)!) )
            titleLabel.text = event?.title
            
            //Set Date
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MM/dd/yyyy ha"
            let dateFormatterPrintHA = DateFormatter()
            dateFormatterPrintHA.dateFormat = "ha"
            
            //Get Start Date
            let startDate = dateFormatterGet.date(from: event!.start_date_time)
            let startDateString = dateFormatterPrint.string(from: startDate!)
            
            //Get End Date
            let endDate = dateFormatterGet.date(from: event!.end_date_time)
            let endDateString = dateFormatterPrintHA.string(from: endDate!)
            
            dateLabel.text = startDateString + " - " + endDateString
            
            locationButton.setTitle(event?.location, for: UIControl.State.normal)
        }
    }
    
    @IBAction func pressedLocationButton(_ sender: UIButton) {
        
        //Need coordinates maybe. Would open up in maps app.
//        if let locationURL = URL(string: String(format: "http://maps.apple.com/?q=%@,%@&address=%@", locationlatitude, locationLongitude, event?.location!)) {
//            UIApplication.shared.open(locationURL, options: [:], completionHandler: nil)
//        }
    }
    
}
