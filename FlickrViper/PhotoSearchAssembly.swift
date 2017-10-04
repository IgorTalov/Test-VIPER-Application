//
//  PhotoSearchAssembly.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation
import UIKit

class PhotoSearchAssembly {
    
    static let sharedInstance = PhotoSearchAssembly()
    
    func configure(_ viewController: PhotoViewController) {
        let APIDataManager = FlickrDataManager()
        let interactor = PhotoSearchInteractor()
        let presenter = PhotoSearchPresenter()
        let router = PhotoSearchRouting()
        router.viewController = viewController
        presenter.router = router
        presenter.view = viewController
        interactor.presenter = presenter
        viewController.presenter = presenter
        presenter.interactor = interactor
        interactor.APIDataManager = APIDataManager
    }
    
    
}
