//
//  Spot.swift
//  Snacktacular
//
//  Created by BC Swift Student Loan 1 on 3/30/19.
//  Copyright © 2019 Richard Li. All rights reserved.
//

import Foundation
import CoreLocation

class Spot {
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    var averageRating: Float
    var numberOfReviews: Int
    var postingUserID: String
    var documentID: String
    
    init(name: String, address: String, coordinate: CLLocationCoordinate2D, averageRating: Float, numberOfReviews: Int, postingUserID: String, documentID: String) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
        self.averageRating = averageRating
        self.numberOfReviews = numberOfReviews
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(name: "", address: "", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: "")
    }
}
