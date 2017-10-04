//
//  PhotoSearchInteractor.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoSearchInteractorInput: class {
    func fetchAllPhotosFromDataManager(_ searchTag: String, page: NSInteger)
}

protocol PhotoSearchInteractorOutput: class {
    func providedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger)
    func serviceError(_ errorMessage: String)
}

class PhotoSearchInteractor: PhotoSearchInteractorInput {
    
    weak var presenter: PhotoSearchInteractorOutput!
    var APIDataManager: FlickrPhotoSearchProtocol!
    
    func fetchAllPhotosFromDataManager(_ searchTag: String, page: NSInteger) {
        APIDataManager.fetchPhotosForSearchtext(searchText: searchTag, page: page) { (error, totalPages, flickrPhotos) in
            if let photos = flickrPhotos {
                print(photos)
                self.presenter.providedPhotos(photos, totalPages: totalPages)
            } else if let error = error {
                print(error)
                self.presenter.serviceError(error.description)
            }
        }
    }
    
}
