//
//  SongController.swift
//  PlaylistCoreData
//
//  Created by Jordan Lamb on 9/25/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation
import CoreData

class SongController {
    
    // CREATE
    static func createSong(songName: String, artistName: String, to playlist: Playlist) {
        Song(songName: songName, artistName: artistName, playlist: playlist)
        PlaylistController.sharedInstance.saveToPersistentStore()
    }
    
    // DELETE
    static func deleteSong(song: Song) {
        CoreDataStack.context.delete(song)
        PlaylistController.sharedInstance.saveToPersistentStore()
    }
}
