//
//  FriendsGivingApp.swift
//  FriendsGiving
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import SwiftUI

@main
struct FriendsGivingApp: App {
    @StateObject var friendsVM = FriendsViewModel() // first I initialize this object 
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .environmentObject(friendsVM) 
        }
    }
}
