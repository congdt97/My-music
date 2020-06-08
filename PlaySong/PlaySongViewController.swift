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
    @IBOutlet weak var lblPlayerTime: UILabel!
    @IBOutlet weak var lblTimeEnd: UILabel!
    
    @IBOutlet weak var btnPlay: UIButton!
    
    //MARK: Property
    var audioPlayer : AVPlayer!
    var listSongs: [SongModel]?
    var toggleState = 2
    var songIndex : Int?
    
    //MARK: IBAction
    @IBAction func btnPlay(_ sender: Any) {
        playPauseButton()
        
    }
    @IBAction func btnForwar(_ sender: Any) {
        guard let index = songIndex else {
            songIndex = 0
            return
        }
        songIndex = index + 1
        audioPlayer.pause()
        loadSong()
        audioPlayer.play()
    }
    @IBAction func songSliderAction(_ sender: Any) {
        audioPlayer.pause()
        audioPlayer.rate = sliderTime.value
        audioPlayer.play()
    }
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadSong()
        playPauseButton()
    }
    
    func loadSong() {
        if let song = listSongs?[songIndex ?? 0] as? SongModel {
            lblName.text = song.name
            lblSingle.text = song.url
            
            if let duration = song.duration {
                self.sliderTime.maximumValue = Float(duration) ?? 0
                setTime(timeSeconds: Float(duration) ?? 0, lblTime: lblTimeEnd)
            }
            if let path = song.url {
                guard let url = URL(string: path) else {
                    print("error to get the mp3 file")
                    return
                }
                do {
                    audioPlayer = try AVPlayer(url: url as URL)
                } catch {
                    print("audio file error")
                }

            }
            updateTime()
        }
    }
    
    func playPauseButton(){
        if toggleState == 1 {
            audioPlayer.play()
            toggleState = 2
            btnPlay.setImage(UIImage(named: "pause"), for: UIControl.State.normal)
        } else {
            self.audioPlayer.pause()
            toggleState = 1
            btnPlay.setImage(UIImage(named: "play"), for: UIControl.State.normal)
            
        }
    }
    
    func updateTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(time) in
            let currentTime = Float(CMTimeGetSeconds(self.audioPlayer.currentTime()))
            self.sliderTime.value = currentTime
            self.setTime(timeSeconds: currentTime, lblTime: self.lblPlayerTime)
            print(currentTime)
        })
    }
    
    func setTime(timeSeconds: Float, lblTime: UILabel) {
        let minutes = Int(timeSeconds/60)
        let seconds = Int(timeSeconds)-minutes*60
        lblTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    /*
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
     */
    
    
    

}
