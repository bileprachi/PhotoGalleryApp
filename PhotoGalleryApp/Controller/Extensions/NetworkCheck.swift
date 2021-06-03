//
//  NetworkCheck.swift
//  PhotoGalleryApp
//
//  Created by Prachi Bile on 03/06/21.
//

import Foundation

//MARK: - Reachability
extension GalleryViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
//                self.view.window?.rootViewController?.dismiss(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
            self.reachability.whenUnreachable = { _ in
                print("Not reachable")
                let internetConnectionMessageVC = self.storyboard?.instantiateViewController(identifier: GalleryStoryboardID.internetConnectStoryboardID) as! InternetConnectionMessageViewController
                self.present(internetConnectionMessageVC, animated: true, completion: nil)
            }

            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }
}
