//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by Prachi Bile on 01/06/21.
//

import UIKit

//MARK: - GalleryViewController
class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleyTableView: UITableView!
    
    private var galleryViewModelObj: GalleryViewModel!
    private var noOfRowsInSection: Int = 1
    private var galleryDetails: GalleryData!
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObjects()
        settingsSelf()
        galleryViewModelObj.fetchGalleryData()
    }
    
    func settingsSelf() {
        galleyTableView.delegate = self
        galleyTableView.dataSource = self
        galleryViewModelObj.delegate = self
    }
    
    func createObjects() {
        galleryViewModelObj = GalleryViewModel()
    }
    
    deinit {
        reachability.stopNotifier()
    }
}

//MARK: - GalleryViewModelDelegate
extension GalleryViewController: GalleryViewModelDelegate {
    
    func didGetNoOfRowsInSection(rows count: Int) {
        noOfRowsInSection = count
        DispatchQueue.main.async {
            self.galleyTableView.reloadData()
        }
    }
    func didGetGalleryData(galleryData gallery: GalleryData) {
        galleryDetails = gallery
        DispatchQueue.main.async {
            self.galleyTableView.reloadData()
        }
    }
    func didFailWithError(responseErr responseError: String) {
        print("Error: \(responseError)")
        if responseError != GalleryError.noError.rawValue {
            DispatchQueue.main.async {
                let errorVC = self.storyboard?.instantiateViewController(identifier: GalleryStoryboardID.errorStoryboardID) as! ErrorMessageViewController
                
                self.present(errorVC, animated: true, completion: nil)
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension GalleryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let galleryCell = galleyTableView.dequeueReusableCell(withIdentifier: "PhotoGalleryCell", for: indexPath) as! GalleryTableViewCell
        if galleryDetails == nil {
            galleryCell.galleryImageNameLbl.text = ""
            galleryCell.galleryImageView.image = GalleryPlaceholderImage.placeholderCatImage
        }else {
            let galleryImageUrl = URL(string: self.galleryDetails.items[indexPath.row].media.m)!
            let imageSafeData = try? Data(contentsOf: galleryImageUrl)
            galleryCell.galleryImageView.image = UIImage(data: imageSafeData!)
            galleryCell.galleryImageNameLbl.text = self.galleryDetails.items[indexPath.row].title
            galleryCell.dateOfImageTaken.text = self.galleryDetails.items[indexPath.row].dateTaken
        }
        return galleryCell
    }
    
}

//MARK: - UITableViewDelegate
extension GalleryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row selected: \(indexPath.row)")
        let imageVC = (storyboard?.instantiateViewController(identifier: GalleryStoryboardID.imageStoryboardID))! as ImageViewController
        
        let galleryImageUrl = URL(string: self.galleryDetails.items[indexPath.row].media.m)!
        let imageSafeData = try? Data(contentsOf: galleryImageUrl)
        
        DispatchQueue.main.async {
            imageVC.sportImageView.image = UIImage(data: imageSafeData!)
            imageVC.imageTitleLabel.text = self.galleryDetails.items[indexPath.row].title
            imageVC.imageDateTaken.text = "Captured on: "+self.galleryDetails.items[indexPath.row].dateTaken
            imageVC.imageDatePublished.text = "Published on: "+self.galleryDetails.items[indexPath.row].published
        }
        
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
}


