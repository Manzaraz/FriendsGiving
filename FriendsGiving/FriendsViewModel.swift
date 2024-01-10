//
//  FriendsViewModel.swift
//  FriendsGiving
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import Foundation

class FriendsViewModel: ObservableObject {
    @Published var friends: [Friend] = []
    
    
    func saveFriend(friend: Friend) {
        if friend.id == nil { // This is a new friend to append. Create an id, first.
            var newFriend = friend
            newFriend.id = UUID().uuidString
            friends.append(newFriend)
        } else { // This is an existing freind we're editing. Find the index to update w/friend.
            if let index = friends.firstIndex(where: { $0.id == friend.id }) {
                friends[index] = friend
            }
        }
    }
}
