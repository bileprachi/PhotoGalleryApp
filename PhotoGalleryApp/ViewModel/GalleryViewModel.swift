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
    func didFailWithError(responseErr responseError: String)
}

class GalleryViewModel {
    
    weak var delegate: GalleryViewModelDelegate?
    
    let galleryUrl = GalleryURL.galleryURL
    var galleryManagerObj = GalleryManager()
    
    func fetchGalleryData() {
        print("Inside fetchGalleryData...GalleryUrl: \(galleryUrl)")
        galleryManagerObj.getGalleryData(for: galleryUrl, completionHandler: {
            galleryData,error  in
            guard error == GalleryError.noError.rawValue else {
                self.delegate?.didFailWithError(responseErr: error)
                return
            }
            self.delegate?.didGetNoOfRowsInSection(rows: (galleryData?.items.count)!)
            self.delegate?.didGetGalleryData(galleryData: galleryData!)
            self.delegate?.didFailWithError(responseErr: error)
            
        })
    }
}
