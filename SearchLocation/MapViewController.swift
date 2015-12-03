//
//  MapViewController.swift
//  SearchLocation
//
//  Created by 今村翔一 on 2015/09/29.
//  Copyright © 2015年 今村翔一. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var lm: CLLocationManager!
    var latitude: CLLocationDegrees!
    var longtitude: CLLocationDegrees!

    @IBOutlet weak var wholeMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //現在位置情報の取得
        lm = CLLocationManager()
        longtitude = CLLocationDegrees()
        latitude = CLLocationDegrees()
        lm.delegate = self
        lm.requestAlwaysAuthorization()
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.distanceFilter = 100
        lm.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        latitude = newLocation.coordinate.latitude
        longtitude = newLocation.coordinate.longitude
        
        NSLog("latitude: \(latitude), longtitude: \(longtitude)")
        
        //位置情報を保存する
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        app.sharedLocation = ["latitude":latitude, "longtitude":longtitude]
        
        lm.stopUpdatingLocation()
        
        //位置情報から地図を表示する
        let uco = CLLocationCoordinate2DMake(latitude, longtitude)
        let rg = MKCoordinateRegionMakeWithDistance(uco, 3000, 3000)
        self.wholeMapView.setRegion(rg, animated: false)
        
        //位置情報からピンを立てる
        let currentPin = MKPointAnnotation()
        currentPin.coordinate = uco
        currentPin.title = "現在地"
        //if self.wholeMapView.
        //self.wholeMapView.removeAnnotation()
        if self.wholeMapView.annotations.count != 0 {
            print("重複した古い現在地のピンを削除する：\(self.wholeMapView.annotations[0].title)")
            self.wholeMapView.removeAnnotation(self.wholeMapView.annotations[0])
        }
        self.wholeMapView.addAnnotation(currentPin)
        
        /*
        //ダウンロード出来たら型プロパティに格納する
        HotelFetcher().download{(dataArray)->Void in
            HotelFetcher.hotelArray = dataArray
            print("①ダウンロード出来たら型プロパティに格納する")
        }
        
        //なぜか実行されない
        //=========================================================
        //クロージャでコールバックできるは、if文ではなくダウンロードのみだから
        //=========================================================
        HotelFetcher().makeHotelArray{(items) -> Void in
            self.arrangeMap(items)
            print("③ホテルの配列をピンにする")
        }
        */
        
        //位置情報を保存して、デフォルトパラメータを更新後にホテル一覧をピンにする
        HotelFetcher().download{(items) -> Void in
            self.arrangeMap(items)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("ErrorDomain: \(error.domain)")
        NSLog("ErrorCode: \(error.code)")
        //http://stackoverflow.com/questions/1409141/location-manager-error-kclerrordomain-error-0
    }

    func arrangeMap(dataArray: [Hotel]) -> Void {
        print("ホテルの都道府県：\(dataArray[0].address1)")
        if dataArray.count != 0 {
            for var i = 0; i < dataArray.count; i++ {
                if let hotelLatitude = dataArray[i].latitude,
                    let hotelLongtitude = dataArray[i].longitude {
                        let hco = CLLocationCoordinate2DMake(hotelLatitude, hotelLongtitude)
                        let hotelPin = MKPointAnnotation()
                        //print("latitude of wholeMap: \(hco.latitude)")
                        hotelPin.coordinate = hco
                        hotelPin.title = dataArray[i].hotelName
                        self.wholeMapView.addAnnotation(hotelPin)
                }
            }
        }
    }
}
