//
//  TheaterViewController.swift
//  MyMovieChart
//
//  Created by 이병훈 on 2020/09/10.
//  Copyright © 2020 이병훈. All rights reserved.
//

import UIKit
import MapKit

class TheaterViewController : UIViewController {
    var param: NSDictionary!
    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        self.navigationItem.title = self.param["상영관명"] as? String
        //  1.위도와 경도를 추출하고 double형으로 캐스팅
        let lat = (param?["위도"] as! NSString).doubleValue
        let lng = (param?["경도"] as! NSString).doubleValue
        //  2.위도와 경도를 인수로하는 2D 위치 정보 객체를 정의한다.
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        //  3.지도로 표현될 거리: 값의 단위는 m이다.
        let regionRadius: CLLocationDistance = 100
        //  4. 거리를 반영한 지역 정보를 조합한 지도 데이터를 생성
        let coordinateRegion = MKCoordinateRegion(center:location,latitudinalMeters: regionRadius,longitudinalMeters: regionRadius)
        // 5. map변수에 연결된 지도 객체에 데이터를 전달하여 화면에 표시
        self.map.setRegion(coordinateRegion, animated: true)
        
        /*지도에서 위치를 콕집어 포인터 해주는 코드*/
        //위치를 표시해줄 객체를 생성, 앞에서 작성해준 위치값 객체를 할당
        let point = MKPointAnnotation()
        //cordinate속성을 통해 표시할 위치좌표를 입력받고 지정된 맵 뷰 위에 핀모양으로 해당위치 표시 
        point.coordinate = location
        //위치 표현값 추가
        self.map.addAnnotation(point)
    }
}

