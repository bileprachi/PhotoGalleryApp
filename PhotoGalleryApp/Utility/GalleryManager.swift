//
//  GalleryManager.swift
//  PhotoGalleryApp
//
//  Created by Prachi Bile on 01/06/21.
//

import Foundation

class GalleryManager {
    
    func getGalleryData(for urlStr: String, completionHandler: @escaping(_ galleryData: GalleryData?, _ error: String) -> Void) {
            
        let galleryUrl = URL(string: urlStr)
        let session = URLSession.init(configuration: .default)
        let task = session.dataTask(with: galleryUrl!) { galleryData, galleryResponse, galleryError in
            
            guard galleryError == nil else {
                completionHandler(nil, GalleryError.responseError.rawValue)
                return
            }
            guard let data = galleryData else {
                completionHandler(nil, GalleryError.noDataError.rawValue)
                return
            }
            
            let response = (galleryResponse as! HTTPURLResponse)
            guard response.statusCode == 200 else {
                completionHandler(nil, GalleryError.invalidStatusError.rawValue)
                return
            }
            
            //Data Binding
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(GalleryData.self, from: data)
                print("Decoded Data count : \(decodedData.items.count)")
                completionHandler(decodedData, GalleryError.noError.rawValue)
            } catch {
                completionHandler(nil, GalleryError.decodeError.rawValue)
            }
        }
        task.resume()
    }
}
