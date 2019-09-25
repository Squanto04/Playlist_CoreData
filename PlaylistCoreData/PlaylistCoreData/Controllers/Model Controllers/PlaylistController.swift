//
//  PlaylistController.swift
//  PlaylistCoreData
//
//  Created by Jordan Lamb on 9/25/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    // Singleton
    static let sharedInstance = PlaylistController()
    
    // Local Source of Truth
    var playlists: [Playlist] {
            let fetchRequest: NSFetchRequest<Playlist> = Playlist.fetchRequest()
            return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        }
    
    // MARK: - CRUD
    
    // CREATE
    func createdPlaylist(withName name: String) {
        _ = Playlist(playlistName: name)
        saveToPersistentStore()
    }
    
    // DELETE
    func deletePlaylist(playlist: Playlist) {
        CoreDataStack.context.delete(playlist)
        saveToPersistentStore()
    }
    
    // SAVE
    func saveToPersistentStore() {
        do {
           try CoreDataStack.context.save()
        } catch {
            print("There was an error saving the Ojects in \(#function): \(error.localizedDescription)")
        }
    }
    
} // End of Class
