//
//  SearchTableViewController.swift
//  SearchLocation
//
//  Created by 今村翔一 on 2015/09/29.
//  Copyright © 2015年 今村翔一. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var dataArray:[Hotel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        //処理が後の方なので、if文の条件を満たしているからクロージャである必要がないのでは？
        /*
        HotelFetcher().makeHotelArray{(items) -> Void in
            self.dataArray = items
            self.tableView.reloadData()
            print("③ホテルの配列をテーブルに表示する")
        }
        */
        
        //実際にクロージャを使わなくても処理ができたので、処理が後の方なために、if文の条件を既に満たしていただけで、
        //if文をコールバックしたわけではないことがわかる
        self.dataArray = HotelFetcher.hotelArray
        self.tableView.reloadData()
        */

        HotelFetcher().download{ (items) -> Void in
            self.dataArray = items
            self.tableView.reloadData()
        }
        
    }
    
    //テーブルの件数を登録
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //テーブルの内容を代入
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SearchTableViewCell
        cell.displayUpdate(dataArray[indexPath.row])
        return cell
    }
    
    //画面遷移する際にHotelモデルを渡す
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSearchDetailVC" {
            let vc = segue.destinationViewController as! SearchDetailViewController
            //print(segue.identifier)
            if let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow{
                vc.hotel = dataArray[indexPath.row]
            }
        }
    }
}
