//
//  FlickrDataManager.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation
import SDWebImage

protocol FlickrPhotoSearchProtocol: class {
    func fetchPhotosForSearchtext(searchText:String, page:NSInteger, closure:@escaping (NSError?, NSInteger, [FlickrPhotoModel]?) -> Void) -> Void
}

protocol FlickrPhotoLoadImageProtocol: class {
    func loadImageFromURL(_ url: URL, closure:@escaping(UIImage?, NSError?) -> Void)
}

class FlickrDataManager: FlickrPhotoSearchProtocol, FlickrPhotoLoadImageProtocol {
    
    struct Errors {
        static let invalidAccessErrorCode = 100
    }
    
    struct  FlickrAPIMetadataKeys {
        static let failureStatusCode = "code"
    }
    
    struct FlickrAPI {
        static let APIKey = "cea40cebcfaecfb932d593bf0f265606"
        
        static let tagsSearchFormat = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%i&format=json&nojsoncallback=1"
    }
    
    func fetchPhotosForSearchtext(searchText:String, page:NSInteger, closure:@escaping (NSError?, NSInteger, [FlickrPhotoModel]?) -> Void) -> Void {
        
        let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let format = FlickrAPI.tagsSearchFormat
        let arguments: [CVarArg] = [FlickrAPI.APIKey, escapedSearchText!, page]
        
        let photoURL = String(format: format, arguments: arguments)
        
        let url = URL(string: photoURL)
        let request = URLRequest(url: url as! URL)
        
        let searchTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error fetching photos\(error)")
                closure(error as NSError?, 0, nil)
            }
            
            do {
                
                let resultsDictinary = try JSONSerialization.jsonObject(with: data!, options: []) as?[String : AnyObject]
                
                guard let results = resultsDictinary else {return}
                
                if let statusCode = results[FlickrAPIMetadataKeys.failureStatusCode] as? Int {
                    if statusCode == Errors.invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "FlickrAPIDomain", code: statusCode, userInfo: nil)
                        closure(invalidAccessError, 0, nil)
                        return
                    }
                }
                
                guard let photosContainer = resultsDictinary!["photos"] as? NSDictionary else {return}
                guard let totalPageCountString = photosContainer["total"] as? String else {return}
                guard let totalPageCount = NSInteger(totalPageCountString as String) else {return}
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else {return}
                
                let flickrPhotos: [FlickrPhotoModel] = photosArray.map({ (photoDictinary) -> FlickrPhotoModel in
                    
                    let photoId = photoDictinary["id"] as? String ?? ""
                    let farm = photoDictinary["farm"] as? Int ?? 0
                    let secret = photoDictinary["secret"] as? String ?? ""
                    let server = photoDictinary["server"] as? String ?? ""
                    let title = photoDictinary["title"] as? String ?? ""
                    
                    let flickrPhotoModel = FlickrPhotoModel(photoId: photoId, farm: farm, secret: secret, server: server, title: title)
                    
                    return flickrPhotoModel
                })
                
                closure(nil, totalPageCount, flickrPhotos)
                
            } catch let error as NSError{
                print("Error parsing JSON\(error)")
                closure(error, 0, nil)
                return
            }
            
        }
        searchTask.resume()
    }
    
    func loadImageFromURL(_ url: URL, closure:@escaping(UIImage?, NSError?) -> Void) {
        SDWebImageManager.shared().loadImage(with: url, options: .cacheMemoryOnly, progress: nil) { (image, data, error, cache, finished, withUrl) in
            if (image != nil && finished) {
               closure(image, error as? NSError) 
            }
        }
    
    
    }
    
}
