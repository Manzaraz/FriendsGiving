//
//  FriendsViewModel.swift
//  FriendsGiving
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import Foundation


class FriendsViewModel: ObservableObject {
    @Published var friends: [Friend] = []
    
    init() {
        loadData()
    }
    
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
        saveData()
    }
    
    func deleteFriend(atOffsets: IndexSet) {
        friends.remove(atOffsets: atOffsets)
        saveData()
    }
    
    func moveFriend(fromOffsets: IndexSet, toOffset: Int) {
        friends.move(fromOffsets: fromOffsets, toOffset: toOffset)
        saveData()
    }
    
    private func loadData() {
        let path = URL.documentsDirectory.appending(component: "friends")
        guard let data = try? Data(contentsOf: path) else {
            print("😡 ERROR: Could not read the data into  path: \(path)")
            return
        }
        
        do {
            friends = try JSONDecoder().decode([Friend].self, from: data)
        } catch {
            print("😡 ERROR: Could not decode data from path: \(path)")
        }
    }
    
    private func saveData () {
        let path = URL.documentsDirectory.appending(component: "friends")
        let data = try? JSONEncoder().encode(friends)
        
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: Could not save data into the path \(path)")
        }
    }
}
