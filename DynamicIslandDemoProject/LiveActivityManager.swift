//
//  LiveActivityManager.swift
//  DynamicIslandDemoProject
//
//  Created by Mac Mini 1 on 12/02/24.
//

import Foundation
import ActivityKit

class LiveActivityManager {
    
    @discardableResult
    static func startAvtivity(arrivalTime: String, phoneNumber: String, restaurantName: String, customerAddress: String) throws -> String {
        
        var activity: Activity<FootDeliveryAttributes>?
        
        let initialState = FootDeliveryAttributes.ContentState(arrivalTime: arrivalTime, phoneNumber: phoneNumber, restaurantName: restaurantName, customerAddress: customerAddress)
        
        
        do {
            activity = try Activity.request(attributes: FootDeliveryAttributes(), contentState: initialState, pushType: nil )
            
            guard let id = activity?.id else { throw
                
                LiveActivityErrorType.failedToGetID
            }
            
            return id
            
            
        }catch{
            throw error
        }
        
    }
    
    static func listAllActivities() -> [[String:String]] {
        
        let sortedActivities = Activity<FootDeliveryAttributes>.activities.sorted{
            $0.id > $1.id }
        
        return sortedActivities.map {
            [
                "id" : $0.id,
                "arrivalTime" : $0.contentState.arrivalTime,
                "phoneNumber" : $0.contentState.phoneNumber,
                "restaurentName" : $0.contentState.restaurantName,
                "customerAddress" : $0.contentState.customerAddress
                
            ]
        }
       
    }
    
    static func endAllActivities() async {
        for activity in Activity<FootDeliveryAttributes>.activities{
            await activity.end(dismissalPolicy: .immediate)
        }
    }
    
    static func endActivity(_ id: String)async{
        await Activity<FootDeliveryAttributes>.activities.first(where: {
            $0.id == id
        })?.end(dismissalPolicy: .immediate )
    }
     
    
    static func updateActivity(id: String, arrivalTime: String, phoneNumber: String, restaurantName: String, customerAddress: String) async {
        let updateContentState = FootDeliveryAttributes.ContentState(arrivalTime: arrivalTime, phoneNumber: phoneNumber, restaurantName: restaurantName, customerAddress: customerAddress)
        
        let activity =  Activity<FootDeliveryAttributes>.activities.first(where: {$0.id == id })
        
        await activity?.update(using: updateContentState)
        
        
    }
    
    
}
enum LiveActivityErrorType: Error {
    case failedToGetID
}
