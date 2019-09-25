//
//  SongTableViewController.swift
//  PlaylistCoreData
//
//  Created by Jordan Lamb on 9/25/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    var receiver: Playlist?
    
    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = receiver?.playlistName
    }
    
    // MARK: - Actions
    @IBAction func addNewSongButtonTapped(_ sender: Any) {
        guard let playlist = receiver,
            let songName = songNameTextField.text,
            let artistName = artistNameTextField.text,
            !songName.isEmpty,
            !artistName.isEmpty
            else {return}
        SongController.createSong(songName: songName, artistName: artistName, to: playlist)
        
        // Clean up the data
        songNameTextField.text = ""
        artistNameTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiver?.songs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        guard let unwrappedPlaylist = receiver,
            let song = unwrappedPlaylist.songs?[indexPath.row] as? Song
            else  { return UITableViewCell()}
        cell.detailTextLabel?.text = song.artistName
        cell.textLabel?.text = song.songName
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = receiver ,
            let song = playlist.songs?[indexPath.row] as? Song
            else { return }
            SongController.deleteSong(song: song)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
} // End of Class
