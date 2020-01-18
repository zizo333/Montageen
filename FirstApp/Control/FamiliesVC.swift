//
//  FamiliesVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/21/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

class FamiliesVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var familyCollectionView: UICollectionView!
    
    // MARK: - variables
    var itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
    var familiesData: [FamilyData] = []
    let reachability = try! Reachability()
    var firstConnected = 0
    var familiesIds: [Int] = []
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        downloadAllFamilies()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    // MARK: - Download all families data from server
    private func downloadAllFamilies() {
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
                hideConnectionFailedImage(vc: self)
            }
            Request.getAllFamilies { (allFamilies) in
                DispatchQueue.main.async {
                    self.familiesData = allFamilies
                    self.familyCollectionView.reloadData()
                }
            }
        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                showConnectionFailedImage(vc: self)
                showAlert(vc: self, message: "لا يوجد اتصال بالانترنت")
            }
        }
    }
    // check the internet
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability
      switch reachability.connection {
      case .wifi, .cellular:
            DispatchQueue.main.async {
                if self.firstConnected != 0 {
                    showAlert(vc: self, message: "تم الاتصال بالانترنت")
                }
            }
            downloadAllFamilies()
      case .unavailable:
            DispatchQueue.main.async {
                self.familiesData = []
                self.familyCollectionView.reloadData()
                showAlert(vc: self, message: "لا يوجد اتصال بالانترنت")
            }
        firstConnected = 1
      default:
            break
      }
    }

}

// MARK: - collection view config
extension FamiliesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return familiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FamilyCell
        familiesIds.append(familiesData[indexPath.item].id ?? 0)
        cell.generateCell(familyData: familiesData[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Request.getOsraItems(osraId: familiesIds[indexPath.item]) { (items) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "osraId") as! OsraVC
            vc.familyCity = self.familiesData[indexPath.item].city ?? "المكان"
            vc.familyName = self.familiesData[indexPath.item].username ?? "اسم الاسرة"
            vc.osraItems = items
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - set size of cells and insets between them
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.view.frame.width - paddingSpace
        if self.view.frame.width > 700 {
            itemsPerRow = 4
        }
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 215)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
