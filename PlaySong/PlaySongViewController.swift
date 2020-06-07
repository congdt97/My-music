//
//  PlaySongViewController.swift
//  PlaySong
//
//  Created by Apple on 6/4/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import AVKit
import Alamofire
import AVFoundation
import ObjectMapper
import Foundation

class PlaySongViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var sliderTime: UISlider!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSingle: UILabel!
    @IBOutlet weak var lblBegin: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    
    var audioPlayer : AVPlayer!
    var song: SongModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playAudioFromURL()
    }
    
    private func playAudioFromURL() {
        guard let url = URL(string: "https://d2hc9p90vjxzi0.cloudfront.net/video-cutter/musics/Glow.mp3") else {
            print("error to get the mp3 file")
            return
        }
        do {
            audioPlayer = try AVPlayer(url: url as URL)
            audioPlayer?.play()
            self.sliderTime.maximumValue = 300
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(time) in
                var currentTime = CMTimeGetSeconds(self.audioPlayer.currentTime())
                self.sliderTime.value = Float(currentTime)
                print(currentTime)
            })
        } catch {
            print("audio file error")
        }
        
    }

    private func playAudioFromProject() {
        guard let url = Bundle.main.url(forResource: "azanMakkah2016", withExtension: "mp3") else {
            print("error to get the mp3 file")
            return
        }

        do {
            audioPlayer = try AVPlayer(url: url)
        } catch {
            print("audio file error")
        }
        audioPlayer?.play()
    }
    
    
    

}
