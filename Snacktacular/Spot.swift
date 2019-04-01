//
//  Spot.swift
//  Snacktacular
//
//  Created by BC Swift Student Loan 1 on 3/30/19.
//  Copyright © 2019 Richard Li. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

class Spot {
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    var averageRating: Float
    var numberOfReviews: Int
    var postingUserID: String
    var documentID: String
    
    var longitude: CLLocationDegrees {
        return coordinate.longitude
    }
    
    var latitude: CLLocationDegrees {
        return coordinate.longitude
    }
    
    var dictionary: [String: Any] {
        return ["name": name, "address": address, "longitude": longitude, "latitude": latitude, "averageRating": averageRating, "numberOfReviews": numberOfReviews, "postingUserID": postingUserID]
    }
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
    
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completion(false)
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing the data we want to save
        let dataToSave = self.dictionary
        // if we have a document record then we must also have a documentID
        if self.documentID != "" {
            let ref = db.collection("spots").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("*** ERROR: updating document \(self.documentID) \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("^^^ Document updated with ref ID \(ref.documentID)")
                    completion(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil //Let firestore create the new documentID
            ref = db.collection("spots").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("*** ERROR: creating new document \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("^^^ new document created with ref ID \(ref?.documentID ?? "unknown")")
                    completion(true)
                }
            }
        }
    }
}
