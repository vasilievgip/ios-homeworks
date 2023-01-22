//
//  MapViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 17.01.2023.
//

import UIKit
import CoreLocation
import MapKit



@available(iOS 16.0, *)
class MapViewController: UIViewController {

    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.toAutoLayout()
        mapView.delegate = self

        let preferredConfiguration = MKStandardMapConfiguration()
        mapView.preferredConfiguration = preferredConfiguration


        let pointOfInterestFilter = MKPointOfInterestFilter()
        mapView.pointOfInterestFilter = pointOfInterestFilter

        let initialLocation = CLLocationCoordinate2D(latitude: 55.75222, longitude: 37.61556)
        mapView.setCenter(initialLocation, animated: true)

        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)

        var myAnnotations = CapitalAnnotation.make()
        mapView.addAnnotations(myAnnotations)

        return mapView
    }()

    var loc1 = CLLocationCoordinate2D()
    var loc2 = CLLocationCoordinate2D(latitude: 55.876890, longitude: 37.693417)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        navigationController?.navigationBar.isHidden = false
        let filterBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: "Маршрут", style: .plain, target: self, action: #selector(routeOnMap))
            return barButtonItem
        }()
        let noFilterBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: "Убрать точки", style: .plain, target: self, action: #selector(clearPoint))
            return barButtonItem
        }()
        self.navigationItem.rightBarButtonItems = [noFilterBarButtonItem, filterBarButtonItem]

        let uiLongGR = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        uiLongGR.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(uiLongGR)

        findUserLocation()
        layout()
    }

    //        MKGeoJSONDecoder
    //        CLGeocoder

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        locationManager.requestLocation()
    }

    func findUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }

    func layout() {
        view.addSubviews(mapView)

        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .walking

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if (error != nil) {
                let alert = UIAlertController(title: "Неудалось проложить маршрут!", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: { action in }))
                self.present(alert, animated: true)
            }
            guard let unwrappedResponse = response else { return }
            if let route = unwrappedResponse.routes.first {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80, left: 20, bottom: 100, right: 20), animated: true)
            }

        }

    }

    @objc
    func routeOnMap() {
        showRouteOnMap(pickupCoordinate: loc1, destinationCoordinate: loc2)
    }

    @objc
    func clearPoint() {
        mapView.removeAnnotations(mapView.annotations)
    }

    @objc
    func longTap(longGestureRecognizer: UIGestureRecognizer){

        let touchPoint = longGestureRecognizer.location(in: mapView)
        let wayCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let wayAnnotation = MKPointAnnotation()
        loc2 = wayCoords
        wayAnnotation.coordinate = wayCoords
        mapView.addAnnotation(wayAnnotation)

    }

}


@available(iOS 16.0, *)
extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {

        case .notDetermined:
            print("Определение локации не запрошено")
        case .restricted:
            print("Определение локации невозможно")
        case .denied:
            print("Определение локации невозможно")
        case .authorizedAlways:
            manager.requestLocation()
        case .authorizedWhenInUse:
            manager.requestLocation()
        @unknown default:
            fatalError()
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.setCenter(location.coordinate, animated: true)
            loc1 = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle failure to get a user’s location
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .green
        renderer.lineWidth = 6.0
        return renderer
    }

}
