//
//  ViewController.swift
//  FirstApp
//
//  Created by Zizo Adel on 1/6/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ChoosePlaceVC: UIViewController {

    @IBOutlet var mapView: GMSMapView!
    @IBOutlet weak var searchTF: UITextField!
    
    var marker: GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        let locoation = CLLocationCoordinate2D(latitude: 30.808889, longitude: 31.320083)
        
        marker = GMSMarker()
        marker.position = locoation
        marker.title = "Location"
        
        marker.map = mapView
        mapView.camera = GMSCameraPosition(target: locoation, zoom: 15)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToPlace))
        searchTF.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func goToPlace() {
        searchTF.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        acController.modalPresentationStyle = .fullScreen
        present(acController, animated: true, completion: nil)
    }
    
    @IBAction func getLocationAction(_ sender: UIButton) {
        print("lat: \(marker.position.latitude) \nlon: \(marker.position.longitude)")
    }
    
}

extension ChoosePlaceVC: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
        self.mapView.clear()
        self.searchTF.text = place.name!
        
        let coord = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        marker = nil
        marker = GMSMarker()
        marker.position = coord
        marker.title = "Location"
        marker.snippet = place.name
        
        marker.map = mapView
        mapView.camera = GMSCameraPosition(target: coord, zoom: 15)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension ChoosePlaceVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        marker = nil
        marker = GMSMarker()
        marker.position = coordinate
        marker.title = "Location"
        marker.snippet = "cairo"
        
        marker.map = mapView
        mapView.camera = GMSCameraPosition(target: coordinate, zoom: 15)
    }
}
