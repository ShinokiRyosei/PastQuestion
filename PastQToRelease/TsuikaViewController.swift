
//
//  SetPlace.swift
//  PastQToRelease
//
//  Created by owner on 2016/08/02.
//  Copyright © 2016年 Yuki Yanagawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class TsuikaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIAlertViewDelegate{
    @IBOutlet var Table: UITableView!
    @IBOutlet var Label: UILabel!
    let ref = FIRDatabase.database().reference()
    @IBOutlet var Seachbar:UISearchBar!
    var hairetu: [String] = []
    var kensakukouho: [String] = []
    var Gakkou: [String] = []
    var Select: [String] = ["TokyoKokuritsu","",""]
    var point: String!
    var id: String!
    var seach:String!
    let now = Date()
    let dateFormatter = DateFormatter()
    
    
    
    
    var step:Int! = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = Color().mainColor()
        self.navigationController!.navigationBar.barTintColor = Color().koime()
        
        hairetu = ["東京都高校","千葉県高校","神奈川県高校"]
        Table.delegate = self
        Table.dataSource = self
        Seachbar.delegate = self
        self.reload()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hairetu.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = hairetu[(indexPath as NSIndexPath).row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Label.text = "学校を選んでください。"
        if  step == 0 {
            
            step = step + 1
            if (indexPath as NSIndexPath).row == 0{
                hairetu = school().Tokyo()
                self.Table.reloadData()
            }else if (indexPath as NSIndexPath).row == 1{
                hairetu = school().Chiba()
            }else if (indexPath as NSIndexPath).row == 2{
                hairetu = school().Knagawa()
            }
            self.Table.reloadData()
        }else{
            
            let av = UIAlertView(title: "この学校を追加しますか？", message:"志望校に追加すると簡単に", delegate: self, cancelButtonTitle: "キャンセル", otherButtonTitles: "追加")
            av.show()
            //            if文で被らないように
            
            point = hairetu[(indexPath as NSIndexPath).row]
            
        }
    }
    func go(){
        print(point)
        dateFormatter.dateFormat = "yyyyMMddmmss"
        id = "\(dateFormatter.string(from: now))"
        if Gakkou.index(of: point) == nil{
            Gakkou.append(point)
            ref.child("SoCdata").child(id).updateChildValues(["School": point,"user": (FIRAuth.auth()?.currentUser?.uid)!])
        }
    }
    @IBAction func sa(){
        let url = URL(string: "")
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.openURL(url!)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //テキストが更新されたときに呼ばれる
        seach = searchBar.text
        if seach == ""{
            
        }else{
            let index = hairetu.index(of: seach)
            if index == nil{
            }else{
                kensakukouho.append(hairetu[index!])
                hairetu = kensakukouho
                
                self.reload()
            }
        }
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        seach = searchBar.text
        searchBar.resignFirstResponder()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            
        } else {
            go()
        }
    }
    func reload(){
        self.Table.reloadData()
    }
}
