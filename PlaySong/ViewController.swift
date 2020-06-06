//
//  ViewController.swift
//  PlaySong
//
//  Created by Apple on 6/4/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Alamofire

class ListSongViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: property
    var songs: [SongModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "ListSongTableViewCell", bundle: nil), forCellReuseIdentifier: "ListSongTableViewCell")
        requestAPI()
        
    }
    
    func requestAPI() {
        AF.request(Constants.getAPI, method: .post).responseJSON{(reponse)in
        if let value = reponse.value as? [String: Any] {
            if let songModel = SongModel(JSON: value) {
                self.songs?.append(songModel)
                self.tableview.reloadData()
                }
            }
                
        }
    }
}

extension ListSongViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListSongTableViewCell", for: indexPath) as? ListSongTableViewCell else {
            return UITableViewCell()
        }
        cell.img.image = UIImage(named: "girl")
        cell.name.text = String(indexPath.row)
        cell.single.text = "Nhi xinh gai"
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = Storyboard
//    }
//
    
}

