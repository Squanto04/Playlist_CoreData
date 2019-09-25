//
//  PlaylistTableViewController.swift
//  PlaylistCoreData
//
//  Created by Jordan Lamb on 9/25/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {

    
    @IBOutlet weak var playlistNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Actions
    @IBAction func addPlaylistButtonTapped(_ sender: Any) {
        guard let name = playlistNameTextField.text,
            !name.isEmpty
            else {return}
        PlaylistController.sharedInstance.createdPlaylist(withName: name)
        
        // Clean up the data
        playlistNameTextField.text = ""
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.sharedInstance.playlists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
        let songCount = playlist.songs?.count ?? 0
        cell.textLabel?.text = playlist.playlistName
            if songCount == 0 {
                cell.detailTextLabel?.text = "0 songs"
                cell.detailTextLabel?.textColor = .white
                cell.textLabel?.textColor = .white
                cell.backgroundColor = .red
            } else if songCount == 1 {
                cell.detailTextLabel?.text = "1 song"
                cell.detailTextLabel?.textColor = .black
                cell.textLabel?.textColor = .black
                cell.backgroundColor = .white
            } else {
                cell.detailTextLabel?.text = "\(songCount) songs"
                cell.detailTextLabel?.textColor = .black
                cell.textLabel?.textColor = .black
                cell.backgroundColor = .white
            }
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
            PlaylistController.sharedInstance.deletePlaylist(playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        if segue.identifier == "toSongDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            guard let destinationVC = segue.destination as? SongTableViewController else {return}
            
            let objectToSend = PlaylistController.sharedInstance.playlists[indexPath.row]
            destinationVC.receiver = objectToSend
        }
    }
    
} // End of Class
