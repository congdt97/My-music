//
//  SongModel.swift
//  PlaySong
//
//  Created by Apple on 6/4/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

class SongModel: Mappable {
    var name: String?
    var duration: String?
    var url: String?
    
    required init?(map: Map) {}
    
    init(name: String?, duration: String?, url: String?) {
        self.name = name
        self.duration = duration
        self.url = url
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        duration <- map["duration"]
        url <- map["url"]
    }
}
