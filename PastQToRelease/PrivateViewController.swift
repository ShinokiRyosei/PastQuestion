//
//  PrivateViewController.swift
//  PastQToRelease
//
//  Created by owner on 2016/08/06.
//  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
//

import UIKit

class PrivateViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var Table:UITableView!
    @IBOutlet var Label:UILabel!
    var gakkouname:String!
    var ranck:[String] = []
    var id:String = ""
    var Score:[String] = []
    var sum = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        Table.delegate = self
        Table.dataSource = self
     Label.text = gakkouname
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Score.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //        let year = (id as NSString).substringWithRange(NSRange(location: 1, length: 4))
        //        let month = (id as NSString).substringWithRange(NSRange(location: 5, length: 2))
        //        let date = (id as NSString).substringWithRange(NSRange(location: 8, length: 2))
        //        var when = ""
        //        if year == "2016"{
        //         when = "今年"
        //        }else{
        //            when = "遥か彼方昔"
        //        }
        let index = ranck.index(of: Score[(indexPath as NSIndexPath).row])
        let sai = (indexPath as NSIndexPath).row - sum
        if index == nil{
                 cell.textLabel!.text = "得点 \(Score[(indexPath as NSIndexPath).row]) 平均との差異\(sai) 頑張れ！"
        }else{
            cell.textLabel!.text = "得点 \(Score[(indexPath as NSIndexPath).row]) ユーザー順位\(String(index! + 1))位 おめでとう！"
        }
        print("ランキング\(ranck) スコア\(index)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
