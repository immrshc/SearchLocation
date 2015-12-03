//
//  Hotel.swift
//  SearchLocation
//
//  Created by 今村翔一 on 2015/09/29.
//  Copyright © 2015年 今村翔一. All rights reserved.
//
import Foundation
import SwiftyJSON


class Hotel {
    
    //TableViewでの表示
    private(set) var hotelImageUrl = ""
    private(set) var hotelName = ""
    private(set) var hotelMinCharge = ""
    //Detailでの表示
    private(set) var roomImageUrl = ""
    private(set) var hotelInformationUrl = ""
    private(set) var address1 = ""//都道府県
    private(set) var address2 = ""//市町村以下
    private(set) var serviceAverage:Double!
    private(set) var latitude:Double?
    private(set) var longitude:Double?

    
    init(json:JSON){
        //print(json)
        //json = JSON["hotels"][index]["hotel"]
        self.hotelImageUrl = json[0]["hotelBasicInfo"]["hotelImageUrl"].stringValue
        self.hotelName = json[0]["hotelBasicInfo"]["hotelName"].stringValue
        self.hotelMinCharge = json[0]["hotelBasicInfo"]["hotelMinCharge"].stringValue

        self.roomImageUrl = json[0]["hotelBasicInfo"]["roomImageUrl"].stringValue
        self.hotelInformationUrl = json[0]["hotelBasicInfo"]["hotelInformationUrl"].stringValue
        self.address1 = json[0]["hotelBasicInfo"]["address1"].stringValue
        self.address2 = json[0]["hotelBasicInfo"]["address2"].stringValue
        self.serviceAverage = json[1]["hotelRatingInfo"]["serviceAverage"].doubleValue
        self.latitude = json[0]["hotelBasicInfo"]["latitude"].doubleValue
        self.longitude = json[0]["hotelBasicInfo"]["longitude"].doubleValue
        
        /*
        print(self.hotelName)
        print(self.hotelImageUrl)
        print(self.hotelMinCharge)
        print(self.roomImageUrl)
        print(self.hotelInformationUrl)
        print(self.address1)
        print(self.address2)
        print(self.serviceAverage)
        print(self.latitude)
        print(self.longitude)
        print("==================================")
        */

    }
}
