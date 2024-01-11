//
//  ListView.swift
//  FriendsGiving
//
//  Created by Christian Manzaraz on 10/01/2024.
//

import SwiftUI
import AVFAudio

struct ListView: View {
    @EnvironmentObject var friendsVM: FriendsViewModel
    @State private var sheetIsPresented = false
    @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friendsVM.friends) { friend in
                    NavigationLink {
                        DetailView(friend: friend)
                    } label: {
                        VStack (alignment: .leading) {
                            Text(friend.name)
                                .font(.title2)
                            Text(friend.bringing)
                                .font(.callout)
                        }
                    }
                }
                .onDelete(perform: friendsVM.deleteFriend)
                .onMove(perform: friendsVM.moveFriend)
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
        .onAppear {
            playSound(soundName: "gobble")
        }
    }
    
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("🔇 ERROR: Could not create a sound file from \(soundName)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch  {
            print("🔇 ERROR:  \(error.localizedDescription) creating audioPlayer")
        }
        
    }
}

#Preview {
    ListView()
        .environmentObject(FriendsViewModel())
}
