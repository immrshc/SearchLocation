//
//  HotelFetcher.swift
//  SearchLocation
//
//  Created by 今村翔一 on 2015/09/29.
//  Copyright © 2015年 今村翔一. All rights reserved.
//

import Alamofire
import SwiftyJSON
import MapKit

class HotelFetcher {
    //static var hotelArray:[Hotel] = []
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    let baseURL = "https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20131024"
    var defaultParameter:[String:String] = [
        "format":"json",
        "datumType":"1",
        "latitude":"35.6065914",
        "longitude":"139.7513225",
        "searchRadius":"3.0",
        "applicationId":"1001243668926306259",
    ]
    
    func download(callback: ([Hotel]) -> Void){
        
        //位置情報を取得し、パラメータに設定する
        if let latitude = self.app.sharedLocation["latitude"],
            let longtitude = self.app.sharedLocation["longtitude"]{
            //タイムラインにホテルが表示されない場合は位置情報が検索できない緯度・経度になっていることを疑う
            self.defaultParameter["latitude"] = String(latitude)
            self.defaultParameter["longitude"] = String(longtitude)
            //print(self.defaultParameter)
        }
        
        //楽天APIからホテルの情報を取得する
        Alamofire.request(.GET, baseURL, parameters: defaultParameter).responseJSON{_, _, result in
        if result.isSuccess,
            let res = result.value as? [String:AnyObject],
            let json = res["hotels"] as? [[String:AnyObject]]{
                var dataArray:[Hotel] = []
                for var i = 0; i < json.count; i++ {
                    if let item = json[i]["hotel"]{
                        let hotel = Hotel(json: JSON(item))//JSON形式にキャスト
                        dataArray.append(hotel)
                        /*
                        let hco = CLLocationCoordinate2DMake(hotel.latitude!, hotel.longitude!)
                        let hotelPin = MKPointAnnotation()
                        //print("latitude of wholeMap: \(hco.latitude)")
                        hotelPin.coordinate = hco
                        hotelPin.title = hotel.hotelName
                        //既にできているビューのインスタンスと重複させることは出来ない
                        MapViewController().wholeMapView.addAnnotation(hotelPin)
                        */
                    }
                }
                callback(dataArray)
                print("クロージャでコールバックできるは、if文ではなくダウンロードのみ")
        }
    }}
    
    /*
    func makeHotelArray(callback:([Hotel])->Void){
        //型プロパティからデータを取得する
        if HotelFetcher.hotelArray.count != 0 {
            callback(HotelFetcher.hotelArray)
            print("④型プロパティからデータを取得する")
        }
    }
    */
    
}

/*
//一番最初の処理で実行しておく
//ダウンロード出来たら型プロパティに格納する
HotelFetcher().download{(dataArray)->Void in
    HotelFetcher.hotelArray = dataArray
}

func makeHotelArray(callback:([Hotel])->Void){
    //型プロパティからデータを取得する
    if HotelFetcher.hotelArray.count != 0 {
        callback(HotelFetcher.hotelArray)
    }
}
*/