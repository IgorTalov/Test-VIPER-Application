//
//  PhotoDetailInteractor.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoDetailInteractorOutput: class {
    func sendLoadedPhotoImage(_ image: UIImage)
}

protocol PhotoDetailInteractorInput: class {
    func configurePhotoModel(_ photoModel: FlickrPhotoModel)
    func getPhotoImageTitle() -> String
    func loadUIImageFromUrl()
}

class PhotoDetailInteractor: PhotoDetailInteractorInput {
    
    weak var presenter: PhotoDetailInteractorOutput!
    var photoModel: FlickrPhotoModel?
    var imageDataManager: FlickrPhotoLoadImageProtocol!
    
    func configurePhotoModel(_ photoModel: FlickrPhotoModel) {
        self.photoModel = photoModel
    }
    
    func loadUIImageFromUrl() {
        imageDataManager.loadImageFromURL(self.photoModel!.largePhotoURL as URL) { (image, error) in
            if let image = image {
                self.presenter.sendLoadedPhotoImage(image)
            }
        }
    }
    
    func getPhotoImageTitle() -> String {
        if let title = self.photoModel?.title {
            return title
        }
        return ""
    }
    
}
