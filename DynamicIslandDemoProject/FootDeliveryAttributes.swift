//
//  FootDeliveryAttributes.swift
//  DynamicIslandDemoProject
//
//  Created by Mac Mini 1 on 12/02/24.
//

import Foundation
import ActivityKit

struct FootDeliveryAttributes: ActivityAttributes {
    
    
    public struct ContentState: Codable, Hashable {
        var arrivalTime: String
        var phoneNumber: String
        var restaurantName: String
        var customerAddress: String
    }
}
