//
//  ContentView.swift
//  DynamicIslandDemoProject
//
//  Created by Mac Mini 1 on 12/02/24.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                do {
                    deleteAllActivities()
                    
                    let id = try LiveActivityManager.startAvtivity(arrivalTime: "15 Mins", phoneNumber: "1234567", restaurantName: "McDonald's", customerAddress: "221 Baker Street")
                    
                    UserDefaultsManager.saveNewActivity(id: id, arrivalTime: "15 Mins", phoneNumber: "1234567", restaurantName: "McDonald's", customerAddress: "221 Baker Street")
                } catch {
                    print(error.localizedDescription)
                }
            }, label: {
                Text("Place order")
            })
        }
        .padding()
    }
    private func deleteAllActivities() {
        for item in
                UserDefaultsManager.fetchActivities() {
            if let activity =
                Activity<FootDeliveryAttributes>.activities.first(where: {
                    
                    $0.contentState.phoneNumber == item.phoneNumber}) {
                        Task {
                            await
                            LiveActivityManager.endActivity(activity.id)
                        }
                    }
             
        }
    }
}

#Preview {
    ContentView()
}
