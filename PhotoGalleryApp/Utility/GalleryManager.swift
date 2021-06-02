//
//  GalleryManager.swift
//  PhotoGalleryApp
//
//  Created by Prachi Bile on 01/06/21.
//

import Foundation

class GalleryManager {
    
    func getGalleryData(for urlStr: String, completionHandler: @escaping(_ galleryData: GalleryData?) -> Void) {
        
        print("Inside getGalleryData...url: \(urlStr)")
        
        let galleryUrl = URL(string: urlStr)
        let session = URLSession.init(configuration: .default)
        
        let task = session.dataTask(with: galleryUrl!) { galleryData, galleryResponse, galleryError in
            
            guard galleryError == nil else {
                print("Error accoured...\(String(describing: galleryError?.localizedDescription))")
                return
            }
            guard let data = galleryData else {
                print("No Data Received...")
                return
            }
            
            //Data Binding
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(GalleryData.self, from: data)
                print("Decoded Data count : \(decodedData.items.count)")
                completionHandler(decodedData)
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
}
