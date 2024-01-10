//
//  ListView.swift
//  FriendsGiving
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var friendsVM: FriendsViewModel
    @State private var sheetIsPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friendsVM.friends) { friend in
                    NavigationLink {
                        DetailView(friend: friend)
                    } label: {
                        VStack {
                            Text(friend.name)
                                .font(.title2)
                            Text(friend.bringing)
                                .font(.callout)
                        }
                    }
                }                
            }
            .listStyle(.plain)
            .navigationTitle("Friends")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            NavigationStack {
                DetailView(friend: Friend())
            }
        }
    }
}

#Preview {
    ListView()
        .environmentObject(FriendsViewModel())
}
