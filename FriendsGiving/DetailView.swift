//
//  DetailView.swift
//  FriendsGiving
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var friendsVM: FriendsViewModel
    @Environment(\.dismiss) private var dismiss
    @State var friend: Friend
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Name:")
                .bold()
            TextField("name", text: $friend.name)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            Text("Bringing:")
                .bold()
            TextField("bringing", text: $friend.bringing)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            Text("Notes:")
                .bold()
            TextField("notes", text: $friend.notes)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    friendsVM.saveFriend(friend: friend)
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailView(friend: Friend())
            .environmentObject(FriendsViewModel())
    }
}
