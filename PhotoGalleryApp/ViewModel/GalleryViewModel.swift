//
//  GalleryViewModel.swift
//  PhotoGalleryApp
//
//  Created by Prachi Bile on 01/06/21.
//

import Foundation

protocol GalleryViewModelDelegate: AnyObject {
    func didGetNoOfRowsInSection(rows count: Int)
    func didGetGalleryData(galleryData gallery: GalleryData)
}

class GalleryViewModel {
    
    weak var delegate: GalleryViewModelDelegate?
    
    let galleryUrl = Constant.galleryURL
    var galleryManagerObj = GalleryManager()
    
    func fetchGalleryData() {
        print("Inside fetchGalleryData...GalleryUrl: \(galleryUrl)")
        galleryManagerObj.getGalleryData(for: galleryUrl, completionHandler: {
            galleryData in
            
            self.delegate?.didGetNoOfRowsInSection(rows: (galleryData?.items.count)!)
            self.delegate?.didGetGalleryData(galleryData: galleryData!)
            
        })
    }
}
