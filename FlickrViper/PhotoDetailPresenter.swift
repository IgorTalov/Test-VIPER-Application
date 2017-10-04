//
//  PhotoDetailPresenter.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoDetailPresenterInput: PhotoDetailViewControllerOutput, PhotoDetailInteractorOutput {}

class PhotoDetailPresenter: PhotoDetailPresenterInput {
    
    weak var view: PhotoDetailViewControllerInput!
    var interactor: PhotoDetailInteractorInput!
    
    //Passing data from PhotoSearch Module Router
    func saveSelectedPhotoModel(_ photoModel: FlickrPhotoModel) {
        self.interactor.configurePhotoModel(photoModel)
    }
    
    func loadLargePhotoImage() {
        self.interactor.loadUIImageFromUrl()
    }
    
    //results comes from interactor
    func sendLoadedPhotoImage(_ image: UIImage) {
        self.view.addLargeLoadedPhoto(image)
    }
    
    func getPhotoImageTitle() {
        let imageTitle = self.interactor.getPhotoImageTitle()
        self.view.addPhotoImageTitle(imageTitle)
    }
}
