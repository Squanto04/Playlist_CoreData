//
//  PlaylistController.swift
//  PlaylistCoreData
//
//  Created by Jordan Lamb on 9/25/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

class PlaylistController {
    
    // CRUD
    // CREATE
    func createdPlaylist(withName name: String) {
        let playnasty = Playlist(playlist: name)
        
    }
    
    // DELETE
    func deletePlaylist(playlist: Playlist) {
        
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
