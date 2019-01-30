//
//  Event.swift
//  Event
//
//  Created by Josh Slebodnik on 1/29/19.
//  Copyright © 2019 Josh Slebodnik. All rights reserved.
//

import Foundation
import EVReflection

class Event: EVObject {
    var id: Int = 0
    var title: String = ""
    var image_url: String = ""
    var start_date_time: String = ""
    var end_date_time: String = ""
    var location: String = ""
    var featured: Bool = false
}
