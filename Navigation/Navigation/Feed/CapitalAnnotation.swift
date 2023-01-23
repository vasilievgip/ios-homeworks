//
//  LocationManager.swift
//  Navigation
//
//  Created by Андрей Васильев on 17.01.2023.
//

import Foundation
import MapKit

// MKAnnotationView

final class CapitalAnnotation: NSObject, MKAnnotation {

    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(
        title: String,
        coordinate: CLLocationCoordinate2D,
        info: String
    ) {
        self.title = title
        self.coordinate = coordinate
        self.info = info

        super.init()
    }
}


extension CapitalAnnotation {

    static func make() -> [CapitalAnnotation] {
        return [
            .init(
                title: NSLocalizedString("title1CapitalAnnotation", comment: ""),
                coordinate: CLLocationCoordinate2D(
                    latitude: 51.507222,
                    longitude: -0.1275
                ),
                info: NSLocalizedString("info1CapitalAnnotation", comment: "")
            ),
            .init(
                title: NSLocalizedString("title2CapitalAnnotation", comment: ""),
                coordinate: CLLocationCoordinate2D(
                    latitude: 55.75222,
                    longitude: 37.61556
                ),
                info: NSLocalizedString("info2CapitalAnnotation", comment: "")
            ),
            .init(
                title: NSLocalizedString("title3CapitalAnnotation", comment: ""),
                coordinate: CLLocationCoordinate2D(
                    latitude: 59.95,
                    longitude: 10.75
                ),
                info: NSLocalizedString("info3CapitalAnnotation", comment: "")
            ),
            .init(
                title: NSLocalizedString("title4CapitalAnnotation", comment: ""),
                coordinate: CLLocationCoordinate2D(
                    latitude: 48.8567,
                    longitude: 2.3508
                ),
                info: NSLocalizedString("info4CapitalAnnotation", comment: "")
            ),
            .init(
                title: NSLocalizedString("title5CapitalAnnotation", comment: ""),
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.9,
                    longitude: 12.5
                ),
                info: NSLocalizedString("info5CapitalAnnotation", comment: "")
            ),
            .init(
                title: NSLocalizedString("title6CapitalAnnotation", comment: ""),
                coordinate: CLLocationCoordinate2D(
                    latitude: 38.895111,
                    longitude: -77.036667
                ),
                info: NSLocalizedString("info6CapitalAnnotation", comment: "")
            ),
            .init(
                title: NSLocalizedString("title7CapitalAnnotation", comment: ""),
                coordinate: CLLocationCoordinate2D(
                    latitude: 53.9,
                    longitude: 27.5667
                ),
                info: NSLocalizedString("info7CapitalAnnotation", comment: "")
            ),
            .init(
                title: NSLocalizedString("title8CapitalAnnotation", comment: ""),
                coordinate: CLLocationCoordinate2D(
                    latitude: 47.0056,
                    longitude: 28.8575
                ),
                info: NSLocalizedString("info8CapitalAnnotation", comment: "")
            ),
        ]
    }
}
