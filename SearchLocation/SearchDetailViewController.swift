//
//  SearchDetailViewController.swift
//  SearchLocation
//
//  Created by 今村翔一 on 2015/09/29.
//  Copyright © 2015年 今村翔一. All rights reserved.
//

import UIKit
import MapKit
import TTTAttributedLabel

class SearchDetailViewController: UIViewController, MKMapViewDelegate, TTTAttributedLabelDelegate {
    
    var hotel:Hotel!
    
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelAddressLabel: UILabel!
    @IBOutlet weak var hotelURLLabel: TTTAttributedLabel!
    @IBOutlet weak var hotelMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hotelImageView.sd_setImageWithURL(NSURL(string: hotel.roomImageUrl))
        hotelNameLabel.text = hotel.hotelName
        hotelAddressLabel.text = hotel.address1+"\n"+hotel.address2
        
        //文字列のURLをリンクさせる
        hotelURLLabel.delegate = self
        hotelURLLabel.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue
        hotelURLLabel.text = hotel.hotelInformationUrl
        
        //地図にピンを立てる
        if let latitude = hotel.latitude,
            let longtitude = hotel.longitude{
                //print("\(latitude),\(longtitude)")
                let co = CLLocationCoordinate2DMake(latitude, longtitude)
                let rg = MKCoordinateRegionMakeWithDistance(co, 3000, 3000)
                hotelMapView.setRegion(rg, animated: false)
                
                //ホテルのピン
                let hotelPin = MKPointAnnotation()
                hotelPin.coordinate = co
                hotelPin.title = hotel.hotelName
                hotelMapView.addAnnotation(hotelPin)

                //ユーザのピン
                let app = UIApplication.sharedApplication().delegate as! AppDelegate
                if let userLatitude = app.sharedLocation["latitude"] as? Double,
                    let userLongtitude = app.sharedLocation["longtitude"] as? Double{
                        //print("userPin")
                        let userPin = MKPointAnnotation()
                        userPin.coordinate = CLLocationCoordinate2DMake(userLatitude, userLongtitude)
                        userPin.title = "現在地"
                        hotelMapView.addAnnotation(userPin)
                }
        }
    }
    
    //URLを開く
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        UIApplication.sharedApplication().openURL(url)
    }
    
    //下記のメソッドをSearchTableViewControllerから直接呼び出して実行しても、
    //UIButtonインスタンスが生成されていないので、存在しないメモリへ格納することになり、
    //EXC_BAD_INSTRUCTIONエラーが発生するので、
    //ViewDidLoad()を実行してから格納する
    /*
    func displayUpdate(hotel:Hotel){
        hotelImageView.sd_setImageWithURL(NSURL(string: hotel.roomImageUrl))
        hotelNameLabel.text = hotel.hotelName
        hotelAddressLabel.text = hotel.address1+"\n"+hotel.address2
        hotelURLLabel.text = hotel.hotelInformationUrl
    }
    */
    
}
