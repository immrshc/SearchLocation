//
//  SearchTableViewCell.swift
//  SearchLocation
//
//  Created by 今村翔一 on 2015/09/29.
//  Copyright © 2015年 今村翔一. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelPriceLabel: UILabel!
    
    //Hotelモデルのインスタンスをボタンに関連づける
    func displayUpdate(hotel:Hotel){
        hotelNameLabel.text = hotel.hotelName
        hotelPriceLabel.text = hotel.hotelMinCharge + "円"
        //Bridging-Headerを作成し以下を追加する
        //#import <SDWebImage/UIImageView+WebCache.h>
        hotelImageView.sd_setImageWithURL(NSURL(string: hotel.hotelImageUrl))
    }
}
