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
    
    //MARK:property
    var songs = [SongModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "ListSongTableViewCell", bundle: nil), forCellReuseIdentifier: "ListSongTableViewCell")
        request()
    }
    
    //MARK: request
    private func request() {
        AF.request(Constants.getAPI).responseJSON { (response) in
            do {
                if let data = response.data {
                    if let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] {
                        for item in jsonArray {
                            if let song = SongModel(JSON: item) {
                                self.songs.append(song)
                            }
                        }
                        self.tableview.reloadData()
                    }
                }
            } catch {
                print("Convert from data to json by NSJSONSeri.. is failed")
            }
        }
    }
     
}

extension ListSongViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListSongTableViewCell", for: indexPath) as? ListSongTableViewCell else {
            return UITableViewCell()
        }
        cell.img.image = UIImage(named: "girl")
        cell.name.text = self.songs[indexPath.row].name
        cell.single.text = self.songs[indexPath.row].duration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "PlaySongViewController") as? PlaySongViewController
        vc?.listSongs = songs
        vc?.songIndex = indexPath.row
        vc?.toggleState = 1
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    
}

