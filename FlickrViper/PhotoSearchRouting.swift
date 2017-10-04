//
//  PhotoSearchRouting.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoSearchRouterInput {
    func navigateToPhotoDetail()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
}


class PhotoSearchRouting: PhotoSearchRouterInput {
    
    weak var viewController: PhotoViewController!
    
    //MARK: Navigation
    func navigateToPhotoDetail() {
        viewController.performSegue(withIdentifier: "ShowDetail", sender: nil)
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        if segue.identifier == "ShowDetail" {
            passDataToShowPhotodetailScene(segue)
        }
    }
    
    func passDataToShowPhotodetailScene(_ segue: UIStoryboardSegue) {
        if let selectedIndexPath = viewController.photoCollectionView.indexPathsForSelectedItems?.first {
            let selectedPhotoModel = viewController.photos[selectedIndexPath.row] as FlickrPhotoModel!
            let showDetailViewController = segue.destination as! PhotoDetailViewController
            
            showDetailViewController.presenter.saveSelectedPhotoModel(selectedPhotoModel!)
        }
    }
    
}
