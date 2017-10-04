//
//  PhotoDetailAssembly.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation

class PhotoDetailAssembly {
    
    static let sharedInstance = PhotoDetailAssembly()
    
    func configure(_ viewController: PhotoDetailViewController) {
        let APIDataManager: FlickrPhotoLoadImageProtocol = FlickrDataManager()
        let interactor = PhotoDetailInteractor()
        let presenter = PhotoDetailPresenter()
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.view = viewController
        interactor.imageDataManager = APIDataManager
        interactor.presenter = presenter
    }
}
