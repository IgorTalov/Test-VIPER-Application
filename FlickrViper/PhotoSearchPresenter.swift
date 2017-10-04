//
//  PhotoSearchPresenter.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoSearchPresenterInput: PhotoViewControllerOutput, PhotoSearchInteractorOutput {
    
}

class PhotoSearchPresenter: PhotoSearchPresenterInput {
    
    weak var view: PhotoViewControllerInput!
    var interactor: PhotoSearchInteractorInput!
    var router: PhotoSearchRouterInput!
    
    func fetchPhotos(_ searchTag: String, page: NSInteger) {
        
        if view.getTotalPhotosCount() == 0 {
            view.showWaitingView()
        }
        
        interactor.fetchAllPhotosFromDataManager(searchTag, page: page)
    }
    
    //Srvices return photos and interactor passes all data to presenter which make view display them
    func providedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger) {
        self.view.hideWaitingView()
        self.view.displayFetchedPhotos(photos, totalPages: totalPages)
    }
    
    //Show error
    func serviceError(_ errorMessage: String) {
        self.view.displayErrorView(errorMessage)
    }
    
    func gotoPhotoDetailScreen() {
        self.router.navigateToPhotoDetail()
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        self.router.passDataToNextScene(segue)
        
    }
    
}
