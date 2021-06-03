//
//  Settings.swift
//  PhotoGalleryApp
//
//  Created by Prachi Bile on 01/06/21.
//

import Foundation
import UIKit

enum GalleryURL {
    static let galleryURL = "https://www.flickr.com/services/feeds/photos_public.gne?tags=soccer&format=json&nojsoncallback=?"
}

enum GalleryPlaceholder {
    static let placeholderDateText = ""
    static let placeholderImageNameText = "Loading..."
    static let placeholderCatImage = UIImage(named: "PlaceholderCatImage")
}

enum GalleryStoryboardID {
    static let imageStoryboardID = "ImageVC"
    static let internetConnectStoryboardID = "InternectConnectionMessageVC"
    static let errorStoryboardID = "ErrorVC"
}

enum GalleryError: String {
    case noError = ""
    case decodeError = "Error encountered while decoding data..."
    case responseError = "Error received from response..."
    case noDataError = "No Data received from response..."
    case invalidStatusError = "API called failed,status code is not equal to 200..."
}
