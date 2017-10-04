//
//  PhotoDetailViewController.swift
//  FlickrViper
//
//  Created by Игорь Талов on 27.09.17.
//  Copyright © 2017 Игорь Талов. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerInput: class {
    func addLargeLoadedPhoto(_ image: UIImage)
    func addPhotoImageTitle(_ imageTitle: String)
}

protocol PhotoDetailViewControllerOutput: class {
    func saveSelectedPhotoModel(_ photoModel: FlickrPhotoModel)
    func loadLargePhotoImage()
    func getPhotoImageTitle()
}

class PhotoDetailViewController: UIViewController, PhotoDetailViewControllerInput {
    
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var presenter: PhotoDetailViewControllerOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        PhotoDetailAssembly.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ask title and image from presenter
        presenter.getPhotoImageTitle()
        presenter.loadLargePhotoImage()
    }
    
    func addPhotoImageTitle(_ imageTitle: String) {
        self.photoTitleLabel.text = imageTitle
    }
    
    func addLargeLoadedPhoto(_ image: UIImage) {
        self.photoImageView.image = image
    }

}
