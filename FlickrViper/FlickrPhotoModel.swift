//
//  FlickrPhotoModel.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation

struct FlickrPhotoModel {
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoURL: NSURL {
        return flickrImageURL()
    }
    
    var largePhotoURL: NSURL {
        return flickrImageURL(size: "b")
    }
    
    private func flickrImageURL(size: String = "m") -> NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_\(size).jpg")!
    }
    
    
}
