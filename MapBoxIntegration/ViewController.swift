//
//  ViewController.swift
//  MapBoxIntegration
//
//  Created by Sahan Nagodavithana on 2022-09-13.
//

import UIKit
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import CoreLocation

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define two waypoints to travel between
        let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 6.033359, longitude: 80.212444), name: "Galle")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 6.932050, longitude: 79.846306), name: "Colombo")
        
        // Set options
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        
        // Request a route using MapboxDirections.swift
        Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let self = self else { return }
                // Pass the first generated route to the the NavigationViewController
                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
}
